"""
Starts the 60fps port of a mod's objects that have no vanilla object to merge with (see portnew.py): copies each
object's events from the mod as they are into ported/objects/<object>/, to be ported there by hand. An object already
in ported/objects is left alone.

usage: python portcopy.py <config.json> object [object ...]
"""
import os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import convert
from sources import GmkSplit


def main():
    cfg = convert.load_config(sys.argv[1])
    mod = GmkSplit(cfg["mod"])
    base = os.path.join(cfg["_base"], cfg.get("ported", "ported"), "objects")
    for n in sys.argv[2:]:
        d = os.path.join(base, n)
        if os.path.isdir(d):
            print("%s: already in ported/objects, left alone" % n)
            continue
        os.makedirs(d)
        evs = mod.object(n)["events"]
        for ev, code in sorted(evs.items()):
            with open(os.path.join(d, ev + ".gml"), "w", encoding="utf-8", newline="\n") as f:
                f.write(code.replace("\r\n", "\n").rstrip("\n") + "\n")
        print("%s: %d events copied" % (n, len(evs)))


if __name__ == "__main__":
    main()
