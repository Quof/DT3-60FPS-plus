"""
solve.py: the Randomizer's logic for the whole game, joined from each room's logic.

Each room's file (rooms\\<room>.txt, made by roomlogic.py) says, for each way into the room, what each way out and
each place (Randomizer location) needs, from the moves inside that room alone. connections.txt says which way in each
exit leads to. overrides.txt holds hand-made changes. This joins them all from the start of a new game, and works out
what each place needs: its alternatives, any one of which is enough. No simulation runs here: it takes seconds.

usage:
  python solve.py                            solve; write roomlogic.txt; say how many places are reached
  python solve.py --explain <place>          the ways to a place, room by room: <place> is "loc 10 59" or its name
                                             ("skill point 59")
  python solve.py --room <room>              what each way in, way out and place of a room needs from the start
  python solve.py --check <roomlogic.txt>    compare with another result (RoomLogic.exe's own: work\\roomlogic_check.txt)
  python solve.py --no-overrides             leave overrides.txt out
  python solve.py --option <name>            count an option's ways (requirements "option <name>") as there

Requirements, in every file: alternatives separated by |, any one of which is enough; each a list (commas or spaces)
of: djump, adash, gdash, hijump N, mario, link N, belmont N, megaman N, samus N, gamej N, gamec N (N: that many of the
item; "megaman:2" is the same as "megaman 2"), key N (the key of the locked door whose objectNum is N), attack (any
ability set's attack: link 1, belmont 1, megaman 1 or samus 1), option NAME (only with that option on), nothing or -
(walking and jumping), never (no way).
"""
import os, sys, collections

HERE = os.path.dirname(os.path.abspath(__file__))
ROOMS_DIR = os.path.join(HERE, "rooms")
CONNECTIONS = os.path.join(HERE, "connections.txt")
OVERRIDES = os.path.join(HERE, "overrides.txt")
OUT = os.path.join(HERE, "roomlogic.txt")

# the items the logic counts, in RoomLogic.cs's order (Req.Names); djump, adash, gdash and mario are one item each
ITEMS = ["djump", "adash", "gdash", "hijump", "mario", "link", "belmont", "megaman", "samus", "gamej", "gamec"]
SINGLE = {"djump", "adash", "gdash", "mario"}


# ---------------------------------------------------------------- requirements
class Need(collections.namedtuple("Need", "c k o")):
    """one alternative: c the items' counts (in ITEMS' order), k the keys (doors' objectNums), o the options"""
    __slots__ = ()

    def __str__(self):
        p = []
        for i, n in enumerate(self.c):
            if n == 1 and ITEMS[i] in SINGLE: p.append(ITEMS[i])
            elif n > 0: p.append("%s:%d" % (ITEMS[i], n))
        p += ["key:%d" % k for k in sorted(self.k)]
        p += ["option:%s" % o for o in sorted(self.o)]
        return ",".join(p) if p else "-"


NOTHING = Need((0,) * len(ITEMS), frozenset(), frozenset())


def mx(a, b):
    """what needing both a and b needs"""
    return Need(tuple(max(x, y) for x, y in zip(a.c, b.c)), a.k | b.k, a.o | b.o)


def le(a, b):
    """a needs no more than b"""
    return all(x <= y for x, y in zip(a.c, b.c)) and a.k <= b.k and a.o <= b.o


def add(alts, n):
    """adds an alternative to a list, unless one there needs no more; drops the ones that need more. True if added"""
    for a in alts:
        if le(a, n): return False
    alts[:] = [a for a in alts if not le(n, a)]
    alts.append(n)
    return True


def product(xs, ys):
    """every way of needing one of xs and one of ys"""
    out = []
    for x in xs:
        for y in ys: add(out, mx(x, y))
    return out


def alts_text(alts):
    return " | ".join(str(a) for a in alts) if alts else "never"


def parse(text, where=""):
    """requirements text (see the top of this file) -> a list of alternatives ([] for never)"""
    out = []
    t = text.strip()
    if t.lower() in ("never", "everything"): return []
    for part in t.split("|"):
        toks = part.replace(",", " ").split()
        alts = [NOTHING]
        i = 0
        while i < len(toks):
            w = toks[i].lower()
            name, _, cnt = w.partition(":")
            if not cnt and i + 1 < len(toks) and (toks[i + 1].isdigit() or (name == "option" and toks[i + 1])):
                cnt = toks[i + 1]; i += 1
            i += 1
            if name in ("nothing", "-"): continue
            if name == "attack":
                alts = [mx(a, Need(tuple(1 if ITEMS[j] == it else 0 for j in range(len(ITEMS))), frozenset(), frozenset()))
                        for a in alts for it in ("link", "belmont", "megaman", "samus")]
                continue
            if name == "key":
                if not cnt.isdigit(): raise SystemExit("%s: 'key' needs a door's objectNum: %r" % (where, text))
                alts = [mx(a, Need(NOTHING.c, frozenset([int(cnt)]), frozenset())) for a in alts]
                continue
            if name == "option":
                if not cnt: raise SystemExit("%s: 'option' needs a name: %r" % (where, text))
                alts = [mx(a, Need(NOTHING.c, frozenset(), frozenset([cnt]))) for a in alts]
                continue
            if name not in ITEMS: raise SystemExit("%s: unknown requirement %r in %r" % (where, name, text))
            n = int(cnt) if cnt else 1
            c = [0] * len(ITEMS); c[ITEMS.index(name)] = n
            alts = [mx(a, Need(tuple(c), frozenset(), frozenset())) for a in alts]
        for a in alts: add(out, a)
    return out


ATTACK = parse("attack")


# ---------------------------------------------------------------- the files
class RoomLogic:
    """a room's file: its ways in (ids "x,y"), ways out (ids as the file names them), places ((type, number)), and the
    table: (way in, target) -> alternatives, a target being ("out", id) or ("loc", type, number)"""

    def __init__(self, name):
        self.name = name; self.area = ""; self.boss = False; self.map = False
        self.ins, self.outs, self.locs, self.loc_names = [], [], [], {}
        self.table = collections.OrderedDict()

    def ways_from(self, inid):
        return [(t, a) for (i, t), a in self.table.items() if i == inid]


def load_room(path):
    r = RoomLogic(os.path.splitext(os.path.basename(path))[0])
    cur = None
    for ln, raw in enumerate(open(path, encoding="utf-8"), 1):
        line = raw.rstrip("\n")
        if line.startswith("# " + r.name + ":"): r.area = line.split(":", 1)[1].strip()
        body = line.split("#", 1)[0].rstrip()
        if not body.strip(): continue
        f = body.split()
        if line.startswith(" "):
            # a row of the table under "from in <x,y>": "  out <id> <alternatives>" or "  loc <type> <number> <alternatives>"
            if cur is None or f[0].startswith("("): continue      # (a note, as "(the room has no ways out or places)")
            if f[0] == "out": target, rest = ("out", f[1]), f[2:]
            elif f[0] == "loc": target, rest = ("loc", int(f[1]), int(f[2])), f[3:]
            else: raise SystemExit("%s line %d: %r" % (path, ln, line))
            r.table[(cur, target)] = parse(" ".join(rest), "%s line %d" % (path, ln))
            continue
        if f[0] == "how": break           # (the rest of the file explains; the solver doesn't need it)
        if f[0] == "boss": r.boss = True
        elif f[0] == "map": r.map = True
        elif f[0] == "in": r.ins.append(f[1])
        elif f[0] == "out": r.outs.append(f[1])
        elif f[0] == "loc":
            key = (int(f[1]), int(f[2])); r.locs.append(key)
            if "#" in line: r.loc_names[key] = line.split("#", 1)[1].split(",")[0].strip()
        elif f[0] == "from": cur = f[2]
        else: raise SystemExit("%s line %d: %r" % (path, ln, line))
    return r


def load_rooms(folder=ROOMS_DIR):
    rooms = {}
    for fn in sorted(os.listdir(folder)):
        if fn.endswith(".txt") and not fn.startswith("_"):
            r = load_room(os.path.join(folder, fn)); rooms[r.name] = r
    return rooms


class Connections:
    def __init__(self):
        self.start = None
        self.links = collections.OrderedDict()   # (room, out) -> (room, in)
        self.via = set()                         # (room, out): a boss fight
        self.need = {}                           # (room, out) -> alternatives (overrides' "need")


def load_connections(path=CONNECTIONS):
    c = Connections()
    for ln, raw in enumerate(open(path, encoding="utf-8"), 1):
        line = raw.split("#", 1)[0].strip()
        if not line: continue
        f = line.split()
        if f[0] == "start": c.start = (f[1], f[3])
        elif f[0] == "via": c.via.add((f[1], f[3]))
        elif len(f) == 7 and f[1] == "out" and f[3] == "->" and f[5] == "in": c.links[(f[0], f[2])] = (f[4], f[6])
        else: raise SystemExit("connections.txt line %d: %r" % (ln, raw))
    return c


def load_overrides(rooms, conn, path=OVERRIDES):
    """applies overrides.txt to the rooms' tables and the connections (see the file for its lines). Returns how many"""
    if not os.path.exists(path): return 0
    names = {}
    for r in rooms.values():
        for key, nm in r.loc_names.items(): names[nm.lower()] = key
    n = 0
    for ln, raw in enumerate(open(path, encoding="utf-8"), 1):
        line = raw.split("#", 1)[0].strip()
        if not line: continue
        where = "overrides.txt line %d" % ln
        f = line.split(None, 1)
        cmd = f[0].lower()
        if cmd in ("set", "add"):
            head, _, req = f[1].partition(":")
            if not _: raise SystemExit("%s: no ':'" % where)
            hf = head.split("->")
            if len(hf) != 2: raise SystemExit("%s: '<room> in <x,y> -> <way out or place>'" % where)
            left, right = hf[0].split(), hf[1].split()
            if len(left) != 3 or left[1] != "in": raise SystemExit("%s: '<room> in <x,y>' (or 'in *')" % where)
            room = left[0]
            if room not in rooms: raise SystemExit("%s: no room %r (rooms\\ has a file a room)" % (where, room))
            r = rooms[room]
            if right[0] == "out" and len(right) == 2:
                if right[1] not in r.outs: raise SystemExit("%s: %s has no way out %r" % (where, room, right[1]))
                target = ("out", right[1])
            elif right[0] == "loc" and len(right) == 3 and right[1].isdigit() and right[2].isdigit():
                target = ("loc", int(right[1]), int(right[2]))
            elif right[0] == "loc" and " ".join(right[1:]).lower() in names:
                k = names[" ".join(right[1:]).lower()]; target = ("loc",) + k
            else: raise SystemExit("%s: '%s' isn't a way out ('out <x,y>') or a place ('loc <type> <number>' or its name)" % (where, hf[1].strip()))
            if target[0] == "loc" and (target[1], target[2]) not in r.locs: raise SystemExit("%s: %s has no place %s" % (where, room, hf[1].strip()))
            ins = r.ins if left[2] == "*" else [left[2]]
            if left[2] != "*" and left[2] not in r.ins: raise SystemExit("%s: %s has no way in %r" % (where, room, left[2]))
            alts = parse(req, where)
            for i in ins:
                if cmd == "set": r.table[(i, target)] = list(alts)
                else:
                    cur = r.table.setdefault((i, target), [])
                    for a in alts: add(cur, a)
            n += 1
        elif cmd == "need":
            head, _, req = f[1].partition(":")
            hf = head.split()
            if len(hf) != 3 or hf[1] != "out": raise SystemExit("%s: 'need <room> out <x,y> : <requirements>'" % where)
            if (hf[0], hf[2]) not in conn.links: raise SystemExit("%s: no exit %s out %s in connections.txt" % (where, hf[0], hf[2]))
            conn.need[(hf[0], hf[2])] = parse(req, where); n += 1
        elif cmd == "link":
            hf = f[1].split()
            if len(hf) != 7 or hf[1] != "out" or hf[3] != "->" or hf[5] != "in":
                raise SystemExit("%s: 'link <room> out <x,y> -> <room> in <x,y>'" % where)
            if hf[0] not in rooms or hf[2] not in rooms[hf[0]].outs: raise SystemExit("%s: %s has no way out %r" % (where, hf[0], hf[2]))
            if hf[4] not in rooms or hf[6] not in rooms[hf[4]].ins: raise SystemExit("%s: %s has no way in %r" % (where, hf[4], hf[6]))
            conn.links[(hf[0], hf[2])] = (hf[4], hf[6]); n += 1
        else:
            raise SystemExit("%s: unknown line %r (set, add, need or link)" % (where, cmd))
    return n


# ---------------------------------------------------------------- joining the rooms
class Result:
    def __init__(self):
        self.ways_in = {}        # (room, in) -> alternatives from the start
        self.back = {}           # ((room, in), need) -> ((room, in) before, its need, the exit taken, what the room part needed)
        self.places = collections.OrderedDict()   # (type, number) -> alternatives
        self.place_room = {}     # (type, number) -> the room (the first that has it)
        self.place_back = {}     # ((type, number), need) -> ((room, in), its need, what the room part needed)


def through_exit(rooms, conn, room, out):
    """where an exit leads, and what going through it needs on top (a boss fight, overrides' need): (room, in), alts"""
    link = conn.links.get((room, out))
    if not link: return None, None
    extra = [NOTHING]
    r2 = rooms.get(link[0])
    if r2 is not None and r2.boss and link[0] != room: extra = product(extra, ATTACK)
    if (room, out) in conn.via: extra = product(extra, ATTACK)
    if (room, out) in conn.need: extra = product(extra, conn.need[(room, out)])
    return link, extra


def keep(n, options):
    """an alternative that holds with these options on (its options dropped), or None"""
    if not n.o: return n
    if n.o <= options: return Need(n.c, n.k, frozenset())
    return None


def solve(rooms, conn, options=frozenset()):
    res = Result()
    start = conn.start
    res.ways_in[start] = [NOTHING]
    queue = collections.deque([start]); queued = {start}
    by_in = {}
    for r in rooms.values():
        for (i, t), alts in r.table.items(): by_in.setdefault((r.name, i), []).append((t, alts))
    while queue:
        node = queue.popleft(); queued.discard(node)
        room, inid = node
        for target, alts in by_in.get(node, []):
            if target[0] != "out" or not alts: continue
            to, extra = through_exit(rooms, conn, room, target[1])
            if to is None or to[0] not in rooms or to[1] not in rooms[to[0]].ins: continue
            part = product(alts, extra)
            dst = res.ways_in.setdefault(to, [])
            changed = False
            for a in list(res.ways_in[node]):
                for p in part:
                    n = keep(mx(a, p), options)
                    if n is not None and add(dst, n):
                        res.back[(to, n)] = (node, a, target[1], p); changed = True
            if changed and to not in queued: queue.append(to); queued.add(to)
    # the places: each from each way in it's reached by
    for r in rooms.values():
        for key in r.locs:
            res.places.setdefault(key, [])
            res.place_room.setdefault(key, r.name)
    for node, alts in res.ways_in.items():
        for target, talts in by_in.get(node, []):
            if target[0] != "loc": continue
            key = (target[1], target[2])
            for a in alts:
                for t in talts:
                    n = keep(mx(a, t), options)
                    if n is not None and add(res.places[key], n): res.place_back[(key, n)] = (node, a, t)
    return res


def room_needs(rooms, res, name):
    out = []
    for i in rooms[name].ins:
        for a in res.ways_in.get((name, i), []): add(out, a)
    return out


def write_result(rooms, res, path=OUT):
    L = ["# what each Randomizer location needs, joined by solve.py from the rooms' logic (rooms\\<room>.txt), connections.txt",
         "# and overrides.txt: don't edit this file (README.txt says how to change the logic)",
         "#   loc <type> <number> <alternatives> <room>      room <room> <alternatives>",
         "# (alternatives separated by |, each a comma-separated list; - nothing; never: not reached from the start)"]
    reached = 0
    for key in sorted(res.places):
        alts = res.places[key]
        if alts: reached += 1
        L.append("loc %d %d %s %s" % (key[0], key[1], "|".join(str(a) for a in alts) if alts else "never", res.place_room[key]))
    for name in sorted(rooms):
        alts = room_needs(rooms, res, name)
        L.append("room %s %s" % (name, "|".join(str(a) for a in alts) if alts else "never"))
    with open(path, "w", encoding="utf-8", newline="\n") as f: f.write("\n".join(L) + "\n")
    return reached, len(res.places)


# ---------------------------------------------------------------- explaining
def find_place(rooms, text):
    t = text.strip().lower()
    f = t.split()
    if len(f) == 3 and f[0] == "loc" and f[1].isdigit() and f[2].isdigit(): return (int(f[1]), int(f[2]))
    if t.startswith("loc "): t = t[4:]
    for r in rooms.values():
        for key, nm in r.loc_names.items():
            if nm.lower() == t: return key
    raise SystemExit("no place %r (a place is 'loc <type> <number>' or its name, as in the room files)" % text)


def chain_to(res, node, need):
    """the rooms' parts from the start to a way in, with that need: [(room, in, exit, what the part needed)]"""
    out = []
    while (node, need) in res.back:
        prev, pneed, out_id, part = res.back[(node, need)]
        out.append((prev[0], prev[1], out_id, part))
        node, need = prev, pneed
    out.reverse()
    return out


def explain(rooms, conn, res, key):
    name = rooms[res.place_room[key]].loc_names.get(key, "")
    alts = res.places.get(key, [])
    print("loc %d %d (%s), in %s: %s" % (key[0], key[1], name, res.place_room[key], alts_text(alts)))
    if not alts: print("  not reached from the start (see the rooms on the way: --room, and their files' 'never's)")
    for k, a in enumerate(alts, 1):
        node, nneed, part = res.place_back[(key, a)]
        print("\nway %d: %s" % (k, a))
        print("  start: %s in %s" % conn.start)
        for room, inid, out_id, pt in chain_to(res, node, nneed):
            to = conn.links[(room, out_id)]
            print("  %-22s in %-10s -> out %-12s %-28s (then %s in %s)" % (room, inid, out_id, "[" + str(pt) + "]", to[0], to[1]))
        print("  %-22s in %-10s -> loc %d %d %s" % (node[0], node[1], key[0], key[1], "[" + str(part) + "]"))
    if alts: print("\n(each room's part is in its file, rooms\\<room>.txt: its 'how in <x,y> -> <way out or place>' lines say the moves)")


def show_room(rooms, conn, res, name):
    if name not in rooms: raise SystemExit("no room %r" % name)
    r = rooms[name]
    print("%s: %s%s%s" % (name, r.area, " (boss)" if r.boss else "", " (map)" if r.map else ""))
    for i in r.ins: print("  in  %-12s from the start: %s" % (i, alts_text(res.ways_in.get((name, i), []))))
    for o in r.outs:
        best = []
        for i in r.ins:
            for a in res.ways_in.get((name, i), []):
                for t in r.table.get((i, ("out", o)), []): add(best, mx(a, t))
        to = conn.links.get((name, o))
        print("  out %-12s from the start: %s   (to %s)" % (o, alts_text(best), "%s in %s" % to if to else "nowhere"))
    for key in r.locs: print("  loc %d %d %-20s from the start: %s" % (key[0], key[1], r.loc_names.get(key, ""), alts_text(res.places.get(key, []))))


def check(res, path):
    """compares the places' and rooms' alternatives with another roomlogic.txt: the differences"""
    other = {}
    for line in open(path, encoding="utf-8"):
        f = line.split()
        if len(f) >= 5 and f[0] == "loc": other[("loc", int(f[1]), int(f[2]))] = f[3]
        elif len(f) >= 3 and f[0] == "room": other[("room", f[1])] = f[2]
    diffs = []
    for key, alts in res.places.items():
        o = other.get(("loc",) + key)
        mine = sorted(str(a) for a in alts) or ["never"]
        theirs = sorted(o.split("|")) if o and o != "never" else ["never"]
        if o is not None and mine != theirs: diffs.append("loc %d %d: %s  vs  %s" % (key[0], key[1], "|".join(mine), "|".join(theirs)))
    return diffs


def check_rooms(rooms, res, path):
    """the same for the rooms' lines"""
    diffs = []
    for line in open(path, encoding="utf-8"):
        f = line.split()
        if len(f) >= 3 and f[0] == "room" and f[1] in rooms:
            mine = sorted(str(a) for a in room_needs(rooms, res, f[1])) or ["never"]
            theirs = sorted(f[2].split("|")) if f[2] != "never" else ["never"]
            if mine != theirs: diffs.append("room %s: %s  vs  %s" % (f[1], "|".join(mine), "|".join(theirs)))
    return diffs


def solve_all(use_overrides=True, options=frozenset(), write=True):
    """what rndgen.py calls: the places' alternatives ({(type, number): [Need]}), roomlogic.txt written"""
    rooms = load_rooms(); conn = load_connections()
    if use_overrides: load_overrides(rooms, conn)
    res = solve(rooms, conn, options)
    if write: write_result(rooms, res)
    return res.places


def main():
    args = sys.argv[1:]
    use_over = "--no-overrides" not in args
    opts = set()
    while "--option" in args:
        i = args.index("--option"); opts.add(args[i + 1].lower()); del args[i:i + 2]
    rooms = load_rooms(); conn = load_connections()
    n = load_overrides(rooms, conn) if use_over else 0
    res = solve(rooms, conn, frozenset(opts))
    if "--explain" in args:
        explain(rooms, conn, res, find_place(rooms, args[args.index("--explain") + 1])); return
    if "--room" in args:
        show_room(rooms, conn, res, args[args.index("--room") + 1]); return
    if "--check" in args:
        path = args[args.index("--check") + 1]
        d = check(res, path) + check_rooms(rooms, res, path)
        print("%d differences" % len(d)); print("\n".join(d[:50])); return
    reached, total = write_result(rooms, res)
    print("%d rooms, %d connections, %d overrides; places reached %d of %d; written %s" % (len(rooms), len(conn.links), n, reached, total, OUT))


if __name__ == "__main__":
    main()
