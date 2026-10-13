"""
For a mod's new objects (not in vanilla): the vanilla object each one was most likely made from (the one whose events
are most like its own), so its 60fps port can start from DT3+'s port of that object with a three-way merge (portnew.py).
Prints, per object, the best match and how alike they are (0-1, over all of the new object's code).

usage: python portbase.py <config.json> [object ...]
"""
import os, sys, difflib, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import convert, merge3
from sources import GmkSplit


def lines(t):
    return [l for l in merge3.norm_lines(merge3.split_lines((t or "").replace("\r\n", "\n"))) if l]


def main():
    cfg = convert.load_config(sys.argv[1])
    only = set(sys.argv[2:])
    mod = GmkSplit(cfg["mod"]); van = GmkSplit(cfg["vanilla"])
    vnames = sorted(van.names("Objects"))
    # an index: line -> vanilla objects that have it (to find candidates quickly)
    vev = {}
    idx = collections.defaultdict(set)
    for v in vnames:
        evs = van.object(v)["events"]
        vev[v] = {ev: lines(c) for ev, c in evs.items()}
        for ev, L in vev[v].items():
            for l in set(L):
                if len(l) > 12:
                    idx[l].add(v)
    new = sorted(set(mod.names("Objects")) - set(vnames))
    for n in new:
        if only and n not in only: continue
        me = {ev: lines(c) for ev, c in mod.object(n)["events"].items()}
        total = sum(len(L) for L in me.values())
        if total == 0:
            print("%-30s (no code)" % n)
            continue
        votes = collections.Counter()
        for L in me.values():
            for l in set(L):
                for v in idx.get(l, ()):
                    votes[v] += 1
        best = None
        for v, _ in votes.most_common(8):
            same = 0
            for ev, L in me.items():
                B = vev[v].get(ev)
                if B:
                    sm = difflib.SequenceMatcher(None, B, L, autojunk=False)
                    same += sum(b.size for b in sm.get_matching_blocks())
            score = same / total
            if best is None or score > best[1]:
                best = (v, score)
        if best:
            print("%-30s %-30s %.2f  (%d lines)" % (n, best[0], best[1], total))
        else:
            print("%-30s (nothing alike)  (%d lines)" % (n, total))


if __name__ == "__main__":
    main()
