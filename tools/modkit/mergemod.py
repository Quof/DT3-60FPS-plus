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

The config's "merge" section:
  "scripts": [names]                        the game's scripts
  "objects": {object: [events] or "all"}    events of the game's objects ("all": every event the mod changed)
  "only_objects": {object: [events]/"all"}  the same, but only the mod's changes matching "only" are merged
  "only": regex
  "leave_out": regex                        the mod's changes whose lines match it are left out (e.g. parts that
                                            belong to something else, or that are done another way)
  "merged": folder, "dt3base": folder       (relative to the config)
A target's name: scripts\<name> or objects\<object>\<event>.
"""
import os, re, sys, json
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import merge3, gmlcheck
from sources import GmkSplit, Gm82Project

OVR = re.compile(r"^if global\.modOvr\[.*scrModOverride\(")
YYD = re.compile(r'^/\*"/\*\'/\*\*//\* YYD ACTION\n(?:.*\n)*?\*/\n?', re.M)

def dt3_script(proj, name):
    t = proj.script(name)
    if t is None: return None
    # without the line that runs a mod's version (the merged version is the mod's version)
    return "\n".join(l for l in t.replace("\r\n", "\n").split("\n") if not OVR.match(l))

def dt3_event(proj, obj, ev):
    evs = proj.object_events(obj) if obj in proj.names["Objects"] else {}
    if ev not in evs: return ""
    t = evs[ev].replace("\r\n", "\n")
    return YYD.sub("", t).strip("\n") + "\n"

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

    def targets(self):
        """[(target, original, DT3+'s, the mod's)]"""
        mg = self.cfg["merge"]; out = []
        for s in mg.get("scripts", []):
            out.append(("scripts\\" + s, self.van.script(s), dt3_script(self.proj, s), self.mod.script(s)))
            self.filters["scripts\\" + s] = self.keep
        for key, flt in (("objects", self.keep), ("only_objects", self.keep_only)):
            for o, evs in mg.get(key, {}).items():
                a = self.mod.object(o); v = self.van.object(o) if o in self.van.names("Objects") else {"events": {}}
                if evs == "all":
                    evs = sorted(e for e in set(a["events"]) | set(v["events"])
                                 if merge3.split_lines(a["events"].get(e, "")) != merge3.split_lines(v["events"].get(e, "")))
                for e in evs:
                    t = "objects\\%s\\%s" % (o, e)
                    out.append((t, v["events"].get(e, ""), dt3_event(self.proj, o, e), a["events"].get(e, "")))
                    self.filters[t] = flt
        return out

    def path(self, folder, target): return os.path.join(folder, target + ".gml")

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
                for w in self.structure(text, d or ""): print("%-60s %s" % (t, w)); bad += 1
            old = open(bp, encoding="utf-8").read() if os.path.exists(bp) else ""
            if merge3.split_lines(old) != merge3.split_lines(d or ""): print("%-60s DT3+ changed it since: run update" % t); bad += 1
        print("all merged and up to date" if not bad else "%d to see to" % bad)

if __name__ == "__main__":
    getattr(Merges(sys.argv[2]), sys.argv[1])()
