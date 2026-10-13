"""
Starts the 60fps port of a mod's new objects that were made from one of vanilla's (portbase.py finds which): writes
ported/objects/<object>/<event>.gml for each event the mod's object has, from DT3+'s port of the vanilla object it was
made from, as portclones.py does for the copies:
  - an event the same as the vanilla object's: DT3+'s version of it (already ported)
  - an event changed from it: a three-way merge (merge3.py) of vanilla -> DT3+ and vanilla -> the mod's object, so
    DT3+'s port and the mod's changes are both in it; conflicts are marked (//<<<<<<< DT3+ ... //>>>>>>> end)
  - an event the vanilla object doesn't have: the mod's code
ported/bases.json says which vanilla object each was made from ({"object": "vanilla object"}). The mod's own lines are
still 30fps code: ported/review.txt lists them, to port by hand. An object already in ported/objects is left alone.

usage: python portnew.py <config.json> [object ...]   (default: every object in bases.json)
"""
import os, sys, json
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import convert, merge3, mergemod
from portclones import hints
from sources import GmkSplit, Gm82Project


def main():
    cfg = convert.load_config(sys.argv[1])
    only = set(sys.argv[2:])
    mod = GmkSplit(cfg["mod"]); van = GmkSplit(cfg["vanilla"]); proj = Gm82Project(cfg["project"])
    base = os.path.join(cfg["_base"], cfg.get("ported", "ported"))
    bases = json.load(open(os.path.join(base, "bases.json"), encoding="utf-8"))
    R = []
    for n, b in sorted(bases.items()):
        if only and n not in only: continue
        d = os.path.join(base, "objects", n)
        if os.path.isdir(d):
            R.append("== %s: already in ported/objects, left alone" % n)
            continue
        os.makedirs(d)
        mo = mod.object(n)["events"]
        va = van.object(b)["events"]
        for ev in sorted(mo):
            m = mo[ev].replace("\r\n", "\n")
            o = va.get(ev)
            dt = mergemod.dt3_event(proj, b, ev)
            if o is None or not dt.strip():
                text, kind = m, "%s has no such event: port all of it" % b
                review = [(i + 1, l) for i, l in enumerate(m.split("\n"))]
            elif merge3.norm_lines(merge3.split_lines(o)) == merge3.norm_lines(merge3.split_lines(m)):
                text, kind, review = dt, "the same as %s's: DT3+'s port" % b, []
            else:
                tr = []
                text, conflicts, applied, skipped = merge3.merge(o.replace("\r\n", "\n"), dt, m, trace=tr)
                kind = "merged with %s (%d conflict%s)" % (b, conflicts, "" if conflicts == 1 else "s") if conflicts else "merged with %s" % b
                G = merge3.split_lines(text)
                review = []
                for (i1, i2, j1, j2), p in tr:
                    for k in range(j2 - j1):
                        if p + k < len(G):
                            review.append((p + k + 1, G[p + k]))
                if conflicts:
                    for i, l in enumerate(G):
                        if l.strip() == merge3.MARK_D:
                            review.append((i + 1, "<conflict>"))
            with open(os.path.join(d, ev + ".gml"), "w", encoding="utf-8", newline="\n") as f:
                f.write(text.rstrip("\n") + "\n")
            R.append("== %s/%s: %s" % (n, ev, kind))
            for ln, l in review:
                if not l.strip() or l.strip().startswith("//"): continue
                h = hints(l)
                if h or l == "<conflict>":
                    R.append("   %5d  %-60s %s" % (ln, l.strip()[:60], ", ".join(h)))
    p = os.path.join(base, "review.txt")
    with open(p, "a", encoding="utf-8") as f:
        f.write("\n".join(R) + "\n")
    print("\n".join(x for x in R if x.startswith("==")))
    print("written; the lines to port are in", p)


if __name__ == "__main__":
    main()
