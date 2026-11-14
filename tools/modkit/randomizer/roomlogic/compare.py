r"""
compare.py: two runs of the room logic side by side, for a change to the simulation (RoomLogic.cs): which rooms'
ways through changed, and what the joined logic (with overrides.txt, as solve.py makes it) gets with each.

  python compare.py <rooms folder A> <rooms folder B> [<connections A> <connections B>]

A folder is a rooms\ as roomlogic.py writes it (e.g. rooms, and work\allfps\rooms from RoomLogic.exe run into
work\allfps). Prints the rooms whose files differ (the ways through, not the "how" lines), then each run's places
reached and the places whose requirements differ.
"""
import os, sys, re
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import solve


def ways(path):
    """a room file's ways through: {(from, to): requirements}"""
    out, cur = {}, None
    for l in open(path, encoding="utf-8", errors="replace"):
        s = l.rstrip("\n")
        if s.startswith("from "):
            cur = s[5:].strip()
        elif s.startswith("  ") and not s.startswith("   ") and cur is not None:
            # "  out 0,224      djump,megaman:2 | ..." / "  loc 10 59   ..." (a place's type and number)
            m = re.match(r"((?:out|in|spot) \S+(?: \[[^\]]*\])?|loc \d+ \d+)\s+(.*)$", s.strip())
            if m:
                out[(cur, m.group(1))] = m.group(2).strip()
        elif not s.startswith(" "):
            cur = None
    return out


def main():
    a, b = sys.argv[1], sys.argv[2]
    ca = sys.argv[3] if len(sys.argv) > 3 else solve.CONNECTIONS
    cb = sys.argv[4] if len(sys.argv) > 4 else solve.CONNECTIONS
    names = sorted(set(os.listdir(a)) | set(os.listdir(b)))
    changed = []
    for n in names:
        pa, pb = os.path.join(a, n), os.path.join(b, n)
        if not n.endswith(".txt"):
            continue
        if not (os.path.exists(pa) and os.path.exists(pb)):
            changed.append((n, "only in " + ("A" if os.path.exists(pa) else "B"), 0, 0, 0))
            continue
        wa, wb = ways(pa), ways(pb)
        gone = [k for k in wa if k not in wb]
        new = [k for k in wb if k not in wa]
        diff = [k for k in wa if k in wb and wa[k] != wb[k]]
        if gone or new or diff:
            changed.append((n, "", len(gone), len(new), len(diff)))
    print("%d room files differ (ways only in A / only in B / different needs):" % len(changed))
    for n, note, g, nw, d in changed:
        print("  %-28s %s%d / %d / %d" % (n[:-4], note + " " if note else "", g, nw, d))
    res = []
    for folder, conn in ((a, ca), (b, cb)):
        rms = solve.load_rooms(folder)
        cn = solve.load_connections(conn)
        solve.load_overrides(rms, cn)
        out = os.path.join(HERE, "work", "compare_%s.txt" % ("A" if folder == a else "B"))
        reached, total = solve.write_result(rms, solve.solve_events(rms, cn), out)
        res.append((reached, total, out))
        print("%s: places reached %d of %d" % ("A" if folder == a else "B", reached, total))
    la = {l.split(" ", 3)[2] + " " + l.split(" ", 3)[1]: l for l in open(res[0][2], encoding="utf-8") if l.startswith("loc ")}
    lb = {l.split(" ", 3)[2] + " " + l.split(" ", 3)[1]: l for l in open(res[1][2], encoding="utf-8") if l.startswith("loc ")}
    d = [k for k in la if k in lb and la[k] != lb[k]]
    print("%d places' requirements differ" % len(d))
    for k in d[:40]:
        print("  A " + la[k].rstrip())
        print("  B " + lb[k].rstrip())


if __name__ == "__main__":
    main()
