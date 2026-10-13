"""
Starts the 60fps port of a mod's copies of the game's objects (convert.py's clones, <name><clone_suffix>): writes
ported/objects/<copy>/<event>.gml for each event the mod's version has, from DT3+'s own port where it can:
  - an event the mod didn't change: DT3+'s version (already ported)
  - an event the mod changed: a three-way merge (merge3.py) of vanilla -> DT3+ and vanilla -> the mod, so DT3+'s port
    and the mod's changes are both in it; conflicts are marked (//<<<<<<< DT3+ ... //>>>>>>> end)
  - an event only the mod has: the mod's code
The mod's own lines in it are still 30fps code: ported/review.txt lists them (and the events only the mod has), to port
by hand. An object already in ported/objects is left alone.

usage: python portclones.py <config.json> [copy name ...]
"""
import os, sys, re
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import convert, merge3, mergemod, gml
from sources import GmkSplit, Gm82Project

# what a port changes, to point out in the mod's lines
HINTS = [
    (re.compile(r"(?<![\w.])(speed|direction|hspeed|vspeed|gravity|gravity_direction|friction)\s*[-+*/]?=(?!=)"), "built-in motion"),
    (re.compile(r"\.(speed|direction|hspeed|vspeed|gravity|friction)\s*[-+*/]?=(?!=)"), "built-in motion of another instance"),
    (re.compile(r"motion_set|motion_add|move_towards_point|path_start"), "built-in motion"),
    (re.compile(r"alarm\[[^\]]+\]\s*=\s*(?!1\b|0\b|-1\b)"), "alarm with a duration"),
    (re.compile(r"\b\w+(\[[^\]]*\])?\s*[-+]=\s*(?![^;\n]*gDeltaTime)"), "counter"),
    (re.compile(r"(oGame\.time|current_frame)\s*mod"), "oGame.time mod"),
    (re.compile(r"\*=\s*0?\.\d"), "decay"),
    (re.compile(r"\bmoveTo\s*\((?![^)]*gDeltaTime)"), "moveTo"),
    (re.compile(r"instance_create"), "instance_create"),
    (re.compile(r"random\("), "random"),
]


def hints(line):
    return sorted(set(h for p, h in HINTS if p.search(line)))


def main():
    cfg = convert.load_config(sys.argv[1])
    only = set(sys.argv[2:])
    mod = GmkSplit(cfg["mod"]); van = GmkSplit(cfg["vanilla"]); proj = Gm82Project(cfg["project"])
    suffix = cfg.get("clone_suffix", "__AI")
    base = os.path.join(cfg["_base"], cfg.get("ported", "ported"))
    out = cfg["out"]
    copies = sorted(o for o in os.listdir(os.path.join(out, "objects")) if o.endswith(suffix))
    R = []
    for c in copies:
        n = c[:-len(suffix)]
        if only and c not in only and n not in only: continue
        d = os.path.join(base, "objects", c)
        if os.path.isdir(d):
            R.append("== %s: already in ported/objects, left alone" % c)
            continue
        os.makedirs(d)
        mo = mod.object(n)["events"]
        va = van.object(n)["events"] if n in van.names("Objects") else {}
        for ev in sorted(mo):
            m = mo[ev].replace("\r\n", "\n")
            o = va.get(ev)
            dt = mergemod.dt3_event(proj, n, ev)
            if o is None:
                text, kind = m, "only the mod has it: port all of it"
                review = [(i + 1, l) for i, l in enumerate(m.split("\n"))]
            elif merge3.norm_lines(merge3.split_lines(o)) == merge3.norm_lines(merge3.split_lines(m)):
                if dt.strip():
                    text, kind, review = dt, "unchanged by the mod: DT3+'s port", []
                else:
                    text, kind = m, "unchanged by the mod, but DT3+ has no such event: port all of it"
                    review = [(i + 1, l) for i, l in enumerate(m.split("\n"))]
            elif not dt.strip():
                text, kind = m, "changed by the mod, DT3+ has no such event: port all of it"
                review = [(i + 1, l) for i, l in enumerate(m.split("\n"))]
            else:
                tr = []
                text, conflicts, applied, skipped = merge3.merge(o.replace("\r\n", "\n"), dt, m, trace=tr)
                kind = "merged (%d conflict%s)" % (conflicts, "" if conflicts == 1 else "s") if conflicts else "merged"
                M = merge3.split_lines(m)
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
            flagged = [(ln, l, hints(l)) for ln, l in review if l.strip() and not l.strip().startswith("//")]
            R.append("== %s/%s: %s" % (c, ev, kind))
            for ln, l, h in flagged:
                if h or l == "<conflict>":
                    R.append("   %5d  %-60s %s" % (ln, l.strip()[:60], ", ".join(h)))
    p = os.path.join(base, "review.txt")
    with open(p, "a", encoding="utf-8") as f:
        f.write("\n".join(R) + "\n")
    print("\n".join(x for x in R if x.startswith("==")))
    print("written; the lines to port are in", p)


if __name__ == "__main__":
    main()
