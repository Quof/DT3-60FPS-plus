"""
perdoor.py: overrides.txt's lines for a whole room (in *) door by door. A line for every way in gives each door the same
need, as if the player were already where whoever wrote it had in mind; from another door of the room the way there can
take more, or not be there at all. This works out, with the room analysis (RoomLogic.exe --probes), what getting from
each way in takes to each other way in's place (where it puts the player) and to the space around each place and exit
such a line is for, and writes them to perdoor.txt beside the lines, room by room: what checking those lines door by
door goes by. The logic doesn't read it.

    python perdoor.py            (all of them; RoomLogic.exe made again first if RoomLogic.cs is newer)
    python perdoor.py rMain_72   (some rooms)
    python perdoor.py --report   (the report again from the last run's work\\probes, after changing overrides.txt)
"""
import os, re, subprocess, sys, collections
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import solve, roomlogic

OUT = os.path.join(HERE, "work", "probes")
REPORT = os.path.join(HERE, "perdoor.txt")
NEAR = (48, 96)          # (the boxes around a place or an exit: this far each way)


def tag(*parts):
    return "_".join(str(p).replace("-", "m") for p in parts)


def xy(s):
    a, b = s.split(",")[:2]
    return int(a), int(b.split("(")[0])


def room_wide(rooms):
    """{room: [(line number, set/add, target text, requirement text)]}: the in * lines of rooms with more than one way in"""
    out = collections.OrderedDict()
    for ln, raw in enumerate(open(solve.OVERRIDES, encoding="utf-8"), 1):
        line = raw.split("#", 1)[0].strip()
        m = re.match(r"^(set|add) (\S+) in \* -> (.*?) : (.*)$", line)
        if m and m.group(2) in rooms and len(rooms[m.group(2)].ins) > 1:
            out.setdefault(m.group(2), []).append((ln, m.group(1), m.group(3).strip(), m.group(4).strip()))
    return out


def loc_at(room_file):
    """{"loc T N": (x, y)} from a room file's place lines (their comment: '..., at X,Y')"""
    at = {}
    for line in open(room_file, encoding="utf-8"):
        m = re.match(r"^loc (\d+) (\d+)\s+#.*\bat (-?\d+),(-?\d+)", line)
        if m: at["loc %s %s" % (m.group(1), m.group(2))] = (int(m.group(3)), int(m.group(4)))
    return at


def target_key(rooms, rm, text):
    """an override's target text ('loc heart piece 22', 'loc 1 22', 'out 1,2') as the room table's key"""
    if text.startswith("out "): return ("out", text[4:].strip())
    if text.startswith("spot "): return ("spot", text[5:].strip())
    names = {nm.lower(): key for key, nm in rooms[rm].loc_names.items()}
    t = text[4:].strip().lower()
    if t in names:
        k = names[t]
        return k if k[0] == "loc" else ("loc",) + tuple(k)
    f = t.split()
    return ("loc", int(f[0]), int(f[1]))


def main():
    report_only = "--report" in sys.argv
    only = set(a for a in sys.argv[1:] if not a.startswith("--"))
    rooms = solve.load_rooms()
    lines = room_wide(rooms)
    if only: lines = collections.OrderedDict((k, v) for k, v in lines.items() if k in only)
    exe, cs = os.path.join(roomlogic.WORK, "RoomLogic.exe"), os.path.join(HERE, "RoomLogic.cs")
    if not os.path.exists(exe) or os.path.getmtime(exe) < os.path.getmtime(cs):
        csc = next((c for c in roomlogic.CSC if os.path.exists(c)), None)
        subprocess.check_call([csc, "/nologo", "/O+", "/out:" + exe, "/r:System.Drawing.dll", cs])
    boxes = collections.OrderedDict()
    meta = {}
    for rm, ls in lines.items():
        r = rooms[rm]
        at = loc_at(os.path.join(solve.ROOMS_DIR, rm + ".txt"))
        bl, tg = [], {}
        for i in r.ins:
            x, y = xy(i)
            t = tag("in", x, y); bl.append("%s:%s:%d,%d,%d,%d" % (rm, t, x - 12, y - 32, x + 12, y)); tg[("in", i)] = t
        for ln, kind, text, req in ls:
            key = target_key(rooms, rm, text)
            if key[0] == "out": p = xy(key[1])
            elif key[0] == "spot": p = None
            else: p = at.get("loc %d %d" % (key[1], key[2]))
            if not p: continue
            for d in NEAR:
                t = tag("near%d" % d, *([key[1]] if key[0] == "out" else key[1:]))
                if (key, d) in tg: continue
                bl.append("%s:%s:%d,%d,%d,%d" % (rm, t, p[0] - d, p[1] - d, p[0] + d, p[1] + d)); tg[(key, d)] = t
        boxes[rm] = bl
        meta[rm] = tg
    os.makedirs(OUT, exist_ok=True)
    names = [] if report_only else list(boxes)
    if report_only: lines = collections.OrderedDict((k, v) for k, v in lines.items() if os.path.exists(os.path.join(OUT, k + ".txt")))
    for k in range(0, len(names), 15):
        args = [b for n in names[k:k + 15] for b in boxes[n]]
        subprocess.check_call([exe, "--probes", roomlogic.PROJ, os.path.join(roomlogic.WORK, "rooms.txt"), OUT] + args,
                              stdout=subprocess.DEVNULL)
    conn = solve.load_connections()
    now = solve.load_rooms()
    solve.load_overrides(now, conn)
    rep, counts = [], collections.Counter()
    for rm, ls in lines.items():
        pr = solve.load_room(os.path.join(OUT, rm + ".txt"))
        r, tg = rooms[rm], meta[rm]

        def spot(w, t):
            """what getting from way in w to box t takes (alternatives, [] never; None: no such box)"""
            al = pr.table.get(((w, ()), ("spot", t)))
            return None if al is None else list(al)

        def target(rt, w, key):
            """a room table's alternatives from way in w to a target (an exit in any state it's left in)"""
            out = []
            for (wy, t), al in rt.table.items():
                if wy[0] != w: continue
                if t == key or (key[0] == "out" and t[0] == "out" and t[1] == key[1]):
                    for a in al: solve.add(out, a)
            return out

        rep.append("== %s (%s)" % (rm, r.area))
        for ln, kind, text, req in ls: rep.append("   line %d: %s in * -> %s : %s" % (ln, kind, text, req))
        for i in r.ins:
            rep.append("   from in %s: to the other ways in: %s" % (i, "; ".join(
                "%s %s" % (j, solve.alts_text(spot(i, tg[("in", j)]) or [])) for j in r.ins if j != i)))
        for ln, kind, text, req in ls:
            key = target_key(rooms, rm, text)
            R = solve.parse(req)
            nears = {}
            for i in r.ins:
                n = []
                for d in NEAR:
                    t = tg.get((key, d))
                    for a in (spot(i, t) or []) if t else []: solve.add(n, a)
                nears[i] = n
            anywhere = any(nears.values())
            rep.append("   %s:" % text)
            for i in r.ins:
                own = target(rooms[rm], i, key)
                n = nears[i]
                if kind == "add" and covers(own, R): st = "no effect"
                elif key[0] == "spot": st = "unknown (a spot)"
                elif n:
                    both = solve.product(n, R)
                    st = "fine" if covers(both, R) else "stricter: " + solve.alts_text(both)
                elif anywhere: st = "cut off"
                else: st = "unknown"
                counts[st.split(":")[0]] += 1
                rep.append("      from %-12s %-34s (room's own: %s; near: %s)" % (i, st, solve.alts_text(own), solve.alts_text(n)))
    rep.insert(0, "door statuses: " + ", ".join("%s %d" % kv for kv in counts.most_common()))
    open(REPORT, "w", encoding="utf-8").write("\n".join(rep) + "\n")
    print("%d rooms, %d lines; %s: %s" % (len(lines), sum(len(v) for v in lines.values()), rep[0], REPORT))


def covers(xs, ys):
    """xs needs no more than ys: every alternative of ys has one of xs needing no more (anything does, against never)"""
    return all(any(solve.le(x, y) for x in xs) for y in ys)


if __name__ == "__main__":
    main()
