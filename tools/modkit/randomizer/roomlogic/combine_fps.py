r"""
combine_fps.py: the room files of three frame rates made into one. A player plays at one of 30, 60 and 120fps, and the
moves come out a little differently at each (RoomLogic.exe works out each frame rate's own logic with --fps30, --fps 60
and --fps 120), so a seed has to be finishable at any of them: each way through a room needs what it needs at 30fps
and what it needs at 60fps and what it needs at 120fps (each frame rate's alternatives, the product of the three).

  python combine_fps.py <rooms 30fps> <rooms 60fps> <rooms 120fps> <out rooms folder>

The out files are the 30fps ones (the "how" lines are the 30fps moves) with each table row's needs replaced. A way one
frame rate's file doesn't have is never.
"""
import os, sys
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import solve


def combine(paths, out_path):
    rooms = [solve.load_room(p) for p in paths]
    base = rooms[0]
    lines = open(paths[0], encoding="utf-8").read().split("\n")
    out, cur, changed = [], None, 0
    for line in lines:
        if line.startswith("how "):
            out.append(line); cur = "how"; continue
        if cur == "how":
            out.append(line); continue
        if line.startswith("# What each way out and place needs"):
            out.append("# Each need below is what it takes at 30, 60 and 120fps alike (a player plays at any of them); the moves")
            out.append("# shown under \"how\" are the 30fps ones.")
        f = line.split("#", 1)[0].split()
        if line.startswith("from "):
            # ("from in <x,y> [state]": the key solve.load_room gives the way)
            cur = (f[2], solve.split_state(f[3:])[0])
            out.append(line); continue
        if line.startswith("  ") and not line.startswith("   ") and cur is not None and f and f[0] in ("out", "loc", "spot"):
            if f[0] == "out":
                st, rest = solve.split_state(f[2:]); target = ("out", f[1], st); head = " ".join(f[:2]) + solve.state_text(st)
            elif f[0] == "loc":
                target = ("loc", int(f[1]), int(f[2])); head = " ".join(f[:3])
            else:
                target = ("spot", f[1]); head = " ".join(f[:2])
            key = (cur, target)
            alts = base.table.get(key, [])
            for r in rooms[1:]:
                alts = solve.product(alts, r.table.get(key, []))
            new = solve.alts_text(alts)
            if new != solve.alts_text(base.table.get(key, [])): changed += 1
            out.append("  %-14s %s" % (head, new))
            continue
        if line and not line.startswith(" "):
            cur = None
        out.append(line)
    open(out_path, "w", encoding="utf-8", newline="\n").write("\n".join(out))
    return changed


def main():
    if len(sys.argv) != 5:
        raise SystemExit(__doc__)
    d30, d60, d120, dout = sys.argv[1:5]
    os.makedirs(dout, exist_ok=True)
    total = 0
    for fn in sorted(os.listdir(d30)):
        if not fn.endswith(".txt"):
            continue
        paths = [os.path.join(d, fn) for d in (d30, d60, d120)]
        if not all(os.path.exists(p) for p in paths):
            print("not in every folder:", fn); continue
        n = combine(paths, os.path.join(dout, fn))
        if n: print("%-28s %d way(s) need more than at 30fps" % (fn[:-4], n))
        total += n
    print("%d way(s) changed" % total)


if __name__ == "__main__":
    main()
