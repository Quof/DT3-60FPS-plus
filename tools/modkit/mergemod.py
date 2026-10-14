r"""
Merged versions of the game's scripts and object events for a mod that was made as an edited copy of the original game
and changed them (the way Altered Beast changed the player's code): DT3+'s versions with the mod's changes in them,
finished by hand (conflicts merged, the mod's code made to work at DT3+'s frame rates) and kept in the config's
"merged" folder. The mod tools copy them into the mod (convert.py), where they replace the game's versions.

  python mergemod.py init <config.json>     merges what isn't merged yet: merged\<target>.gml, with the conflicts
                                            marked (merge3.py); dt3base\ keeps the DT3+ version it was made from
  python mergemod.py update <config.json>   after DT3+ changed: puts DT3+'s new changes into the merged versions
                                            (a three-way merge of dt3base -> DT3+ now -> merged), marking conflicts
  python mergemod.py check <config.json>    lists what's left: conflict markers, merges older than DT3+'s code, and
                                            merged versions whose braces or /* */ comments don't close like DT3+'s
                                            (a block of the mod's put in the wrong place)
  python mergemod.py review <config.json>   writes merged\review.txt: the mod's lines in each merged version (where a
                                            fresh merge puts them), with what in them a 60fps port may need to change

The config's "merge" section:
  "scripts": [names]                        the game's scripts
  "objects": {object: [events] or "all"}    events of the game's objects ("all": every event the mod changed), or
                                            "changed": every event of every object the mod changed (a mod that
                                            changes the whole game), but those of "skip_objects": [names]
  "only_objects": {object: [events]/"all"}  the same, but only the mod's changes matching "only" are merged
  "only": regex
  "leave_out": regex                        the mod's changes whose lines match it are left out (e.g. parts that
                                            belong to something else, or that are done another way)
  "append_events": true                     an event the mod only added lines to the end of (or one the object
                                            doesn't have in DT3+) is kept as just those lines, <event>.append.gml,
                                            which the game adds after the object's own event (object.ini append):
                                            replacing an event means clearing it first, which is slow. Not when the
                                            event can end early (exit) or the lines use its var locals: as an action
                                            of its own, they'd run anyway, or without them
  "merged": folder, "dt3base": folder       (relative to the config)
A target's name: scripts\<name> or objects\<object>\<event>.
"""
import os, re, sys, json
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import merge3, gmlcheck, gml
from sources import GmkSplit, Gm82Project

OVR = re.compile(r"^if global\.modOvr\[.*scrModOverride\(")
EVOVR = re.compile(r"^if global\.modEvOvr\[\d+\]>=0 \{event_perform_object\(")
YYD = re.compile(r'^/\*"/\*\'/\*\*//\* YYD ACTION\n(?:.*\n)*?\*/\n?', re.M)

def dt3_script(proj, name):
    t = proj.script(name)
    if t is None: return None
    # without the line that runs a mod's version (the merged version is the mod's version)
    return "\n".join(l for l in t.replace("\r\n", "\n").split("\n") if not OVR.match(l))

def code_only(text):
    """the code without its comments, spacing and line breaks"""
    return " ".join(t for k, t in gml.tokens((text or "").replace("\r\n", "\n")) if k not in ("cm1", "cm2", "ws"))

def dt3_event(proj, obj, ev):
    evs = proj.object_events(obj) if obj in proj.names["Objects"] else {}
    if ev not in evs: return ""
    t = evs[ev].replace("\r\n", "\n")
    # without the line that runs a mod's version in place of the event's code (addevoverride.py): a merged version is
    # a mod's version, which runs through that line, so it mustn't have the line itself (it would run itself again)
    t = "\n".join(l for l in YYD.sub("", t).split("\n") if not EVOVR.match(l))
    return t.strip("\n") + "\n"

class Merges:
    def __init__(self, cfgpath):
        import convert
        self.cfg = convert.load_config(cfgpath)
        base = self.cfg["_base"]
        mg = self.cfg["merge"]
        self.merged = os.path.join(base, mg.get("merged", "merged"))
        self.dt3base = os.path.join(base, mg.get("dt3base", "dt3base"))
        self.mod = GmkSplit(self.cfg["mod"]); self.van = GmkSplit(self.cfg["vanilla"]); self.proj = Gm82Project(self.cfg["project"])
        lo, only = mg.get("leave_out"), mg.get("only")
        self.keep = (lambda o, m: not re.search(lo, "\n".join(o + m))) if lo else (lambda o, m: True)
        self.keep_only = (lambda o, m: self.keep(o, m) and bool(re.search(only, "\n".join(o + m)))) if only else self.keep
        self.filters = {}

    def changed_objects(self):
        """the game's objects the mod changed the code (not just the comments) of, but skip_objects"""
        skip = set(self.cfg["merge"].get("skip_objects", []))
        out = []
        for o in sorted(self.mod.names("Objects") & self.van.names("Objects")):
            if o in skip: continue
            a, b = self.van.object(o), self.mod.object(o)
            if any(code_only(a["events"].get(e, "")) != code_only(b["events"].get(e, ""))
                   for e in set(a["events"]) | set(b["events"])):
                out.append(o)
        return out

    def targets(self):
        """[(target, original, DT3+'s, the mod's)]"""
        mg = self.cfg["merge"]; out = []
        for s in mg.get("scripts", []):
            out.append(("scripts\\" + s, self.van.script(s), dt3_script(self.proj, s), self.mod.script(s)))
            self.filters["scripts\\" + s] = self.keep
        for key, flt in (("objects", self.keep), ("only_objects", self.keep_only)):
            objs = mg.get(key, {})
            if objs == "changed": objs = {o: "all" for o in self.changed_objects()}
            for o, evs in objs.items():
                a = self.mod.object(o); v = self.van.object(o) if o in self.van.names("Objects") else {"events": {}}
                if evs == "all":
                    # (an event the mod changed only the comments of isn't merged: replacing it would change nothing)
                    evs = sorted(e for e in set(a["events"]) | set(v["events"])
                                 if code_only(a["events"].get(e, "")) != code_only(v["events"].get(e, "")))
                for e in evs:
                    t = "objects\\%s\\%s" % (o, e)
                    out.append((t, v["events"].get(e, ""), dt3_event(self.proj, o, e), a["events"].get(e, "")))
                    self.filters[t] = flt
        return out

    def path(self, folder, target):
        p = os.path.join(folder, target + ".gml")
        ap = os.path.join(folder, target + ".append.gml")
        if folder == self.merged and not os.path.exists(p) and os.path.exists(ap): return ap
        return p

    def appended_part(self, t, o, d, m):
        """append_events: the lines that can go after DT3+'s version of an object's event (the mod's whole event when
        neither the original nor DT3+ has it), or None"""
        import convert
        if not self.cfg["merge"].get("append_events") or not t.startswith("objects\\"): return None
        if not (o or "").strip() and not (d or "").strip(): return m if (m or "").strip() else None
        if not (d or "").strip(): return None
        add = convert.appended(o, m)
        if not add or not add.strip(): return None
        if gml.ends_early(d) or gml.ends_early(o): return None
        if (gml.var_locals(d) | gml.var_locals(o)) & gml.identifiers(add): return None
        # (lines that go on from the event's own code, an "else" after its last "if", aren't code of their own)
        if gmlcheck.check(add): return None
        return add

    @staticmethod
    def structure(text, dt3):
        """what's wrong with a merged version's blocks and comments (that DT3+'s version doesn't have)"""
        L, D = merge3.split_lines(text), merge3.split_lines(dt3)
        out = []
        if merge3.braces(L) != merge3.braces(D): out.append("braces don't balance (%+d)" % (merge3.braces(L) - merge3.braces(D)))
        if merge3.comment_open(L) and not merge3.comment_open(D): out.append("a /* comment isn't closed")
        for line, msg in gmlcheck.check(text): out.append("doesn't compile, line %d: %s" % (line, msg))
        return out

    @staticmethod
    def write(p, text):
        os.makedirs(os.path.dirname(p), exist_ok=True)
        open(p, "w", encoding="utf-8", newline="\n").write(text)

    def init(self):
        n_new = n_conf = 0
        for t, o, d, m in self.targets():
            mp = self.path(self.merged, t)
            if os.path.exists(mp): continue
            add = self.appended_part(t, o, d, m)
            if add is not None:
                self.write(os.path.join(self.merged, t + ".append.gml"), add.rstrip("\n") + "\n")
                self.write(self.path(self.dt3base, t), d or "")
                n_new += 1
                print("%-60s the mod's lines go after DT3+'s event (append)" % t)
                continue
            text, c, a, s = merge3.merge(o, d or "", m, self.filters[t])
            if a == 0 and c == 0:
                print("  (nothing of the mod's left in %s: not merged)" % t); continue
            self.write(mp, text); self.write(self.path(self.dt3base, t), d or "")
            n_new += 1; n_conf += c
            print("%-60s %d of the mod's changes, %d left out, %d conflicts" % (t, a, s, c))
            for w in ([] if c else self.structure(text, d or "")): print("    check it by hand:", w)
        print("merged %d, conflicts to merge by hand: %d" % (n_new, n_conf))

    def update(self):
        n = 0
        for t, o, d, m in self.targets():
            mp, bp = self.path(self.merged, t), self.path(self.dt3base, t)
            if not os.path.exists(mp): continue
            old = open(bp, encoding="utf-8").read() if os.path.exists(bp) else ""
            if merge3.split_lines(old) == merge3.split_lines(d or ""): continue
            if mp.endswith(".append.gml"):
                # (lines added after DT3+'s event: nothing to merge, as long as they still can be)
                self.write(bp, d or ""); n += 1
                add = open(mp, encoding="utf-8").read()
                if gml.ends_early(d or "") or gml.var_locals(d or "") & gml.identifiers(add):
                    print("%-60s DT3+ changed it, and its event can now end early or has var locals the lines use: merge it instead" % t)
                else: print("%-60s DT3+ changed it (the mod's lines still go after it)" % t)
                continue
            text, c, a, s = merge3.merge(old, d or "", open(mp, encoding="utf-8").read())
            self.write(mp, text); self.write(bp, d or "")
            n += 1
            print("%-60s DT3+ changed it: updated, %d conflicts" % (t, c))
        print("updated %d" % n)

    def check(self):
        bad = 0
        for t, o, d, m in self.targets():
            mp, bp = self.path(self.merged, t), self.path(self.dt3base, t)
            if not os.path.exists(mp):
                text, c, a, s = merge3.merge(o, d or "", m, self.filters[t])
                if a or c: print("not merged:", t); bad += 1
                continue
            text = open(mp, encoding="utf-8").read()
            k = text.count(merge3.MARK_D)
            if k: print("%-60s %d conflicts to merge" % (t, k)); bad += 1
            else:
                # (lines added after DT3+'s event stand on their own)
                for w in self.structure(text, "" if mp.endswith(".append.gml") else (d or "")): print("%-60s %s" % (t, w)); bad += 1
            old = open(bp, encoding="utf-8").read() if os.path.exists(bp) else ""
            if merge3.split_lines(old) != merge3.split_lines(d or ""): print("%-60s DT3+ changed it since: run update" % t); bad += 1
        print("all merged and up to date" if not bad else "%d to see to" % bad)

    def review(self):
        from portclones import hints
        R = []
        for t, o, d, m in self.targets():
            mp = self.path(self.merged, t)
            if not os.path.exists(mp): continue
            if mp.endswith(".append.gml"):
                lines = [(i + 1, l) for i, l in enumerate(merge3.split_lines(open(mp, encoding="utf-8").read()))]
                R.append("== %s (append: all of it is the mod's)" % t)
            else:
                tr = []
                text, c, a, s = merge3.merge(o, d or "", m, self.filters[t], trace=tr)
                M = merge3.split_lines(m); G = merge3.split_lines(text)
                lines = []
                for (i1, i2, j1, j2), p in tr:
                    for k in range(j2 - j1):
                        if p + k < len(G): lines.append((p + k + 1, G[p + k]))
                R.append("== %s (%d of the mod's changes%s)" % (t, a, ", %d conflicts" % c if c else ""))
            for ln, l in lines:
                if not l.strip() or l.strip().startswith("//"): continue
                h = hints(l)
                R.append("   %5d  %-70s %s" % (ln, l.strip()[:70], ", ".join(h)))
        p = os.path.join(self.merged, "review.txt")
        open(p, "w", encoding="utf-8", newline="\n").write("\n".join(R) + "\n")
        print("written:", p)

if __name__ == "__main__":
    getattr(Merges(sys.argv[2]), sys.argv[1])()
