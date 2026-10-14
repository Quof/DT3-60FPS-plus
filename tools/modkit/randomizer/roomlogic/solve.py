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
of: djump, adash, gdash, hijump N, mario, link N, belmont N, megaman N, samus N, gamej N, gamec N, varia (the Varia
Suit), cursed N (that many of the three cursed equipment pieces) (N: that many of the item; "megaman:2" is the same as
"megaman 2"), key N (the key of the locked door whose objectNum is N), attack (any
ability set's attack: link 1, belmont 1, megaman 1 or samus 1), event NAME (once it's happened: events.txt), option
NAME (only with that option on), nothing or - (walking and jumping), never (no way).

States the player carries from room to room (connections.txt's "carried" lines: the red/blue switches' state, the
Water Palace's level) go with each way in and out of the rooms that have them ("from in 48,480 [water 3]"); events are
worked out from the rest and put in their place, over and over till nothing changes (solve_events).
"""
import os, re, sys, collections

HERE = os.path.dirname(os.path.abspath(__file__))
ROOMS_DIR = os.path.join(HERE, "rooms")
CONNECTIONS = os.path.join(HERE, "connections.txt")
OVERRIDES = os.path.join(HERE, "overrides.txt")
EVENTS = os.path.join(HERE, "events.txt")
OUT = os.path.join(HERE, "roomlogic.txt")

# the items the logic counts, in RoomLogic.cs's order (Req.Names); djump, adash, gdash, mario and varia are one item
# each (varia: the Varia Suit; cursed: the Trial Master's three cursed equipment pieces)
ITEMS = ["djump", "adash", "gdash", "hijump", "mario", "link", "belmont", "megaman", "samus", "gamej", "gamec", "varia", "cursed"]
SINGLE = {"djump", "adash", "gdash", "mario", "varia"}


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
        p += [o if o.startswith("event:") else "option:%s" % o for o in sorted(self.o)]
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
            name, _, cnt = toks[i].partition(":")
            name = name.lower()   # (an event's or option's name keeps its case)
            if not cnt and i + 1 < len(toks) and (toks[i + 1].isdigit() or (name in ("option", "event") and toks[i + 1])):
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
                alts = [mx(a, Need(NOTHING.c, frozenset(), frozenset([cnt.lower()]))) for a in alts]
                continue
            if name == "event":
                if not cnt: raise SystemExit("%s: 'event' needs a name: %r" % (where, text))
                alts = [mx(a, Need(NOTHING.c, frozenset(), frozenset(["event:" + cnt]))) for a in alts]
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
    """a room's file: its ways in (ids "x,y"), ways out (ids as the file names them), places ((type, number)), the
    states it carries (carried: "rb", "water") and sets as the player comes in (resets), and the table:
    (way, target) -> alternatives. A way is (way in, state): the state the carried ones are in as the player comes in,
    (("rb", "1"),) say, or () in a room that carries none. A target is ("out", id, state: the state the player leaves in)
    or ("loc", type, number)"""

    def __init__(self, name):
        self.name = name; self.area = ""; self.area_num = None; self.boss = False; self.map = False
        self.ins, self.outs, self.locs, self.loc_names = [], [], [], {}
        self.carried, self.resets = [], {}
        self.spots = []          # its spots (somewhere whose reaching is the event <room>/<spot>)
        self.table = collections.OrderedDict()

    def ways(self, inid=None):
        """its ways (way in, state) that the table has rows for (one way in's, or all)"""
        seen = []
        for (w, t) in self.table:
            if (inid is None or w[0] == inid) and w not in seen: seen.append(w)
        return seen


def split_state(toks):
    """tokens that may start with a state, "[rb 1, water 2]": (the state as sorted (name, value) pairs, the rest)"""
    if not toks or not toks[0].startswith("["): return (), toks
    for i, t in enumerate(toks):
        if t.endswith("]"):
            inner = " ".join(toks[:i + 1])[1:-1]
            return tuple(sorted(tuple(p.split()) for p in inner.split(",") if p.strip())), toks[i + 1:]
    raise ValueError("no ] in %r" % " ".join(toks))


def state_text(st):
    return " [" + ", ".join("%s %s" % gv for gv in st) + "]" if st else ""


def load_room(path):
    r = RoomLogic(os.path.splitext(os.path.basename(path))[0])
    cur = None
    for ln, raw in enumerate(open(path, encoding="utf-8"), 1):
        line = raw.rstrip("\n")
        if line.startswith("# " + r.name + ":"):
            r.area = line.split(":", 1)[1].strip()
            m = re.search(r"\(area (\d+)\)", line)
            if m: r.area_num = int(m.group(1))
        body = line.split("#", 1)[0].rstrip()
        if not body.strip(): continue
        f = body.split()
        where = "%s line %d" % (path, ln)
        if line.startswith(" "):
            # a row of the table under "from in <x,y> [state]": "  out <id> [state] <alternatives>" or
            # "  loc <type> <number> <alternatives>"
            if cur is None or f[0].startswith("("): continue      # (a note, as "(the room has no ways out or places)")
            if f[0] == "out":
                st, rest = split_state(f[2:])
                target = ("out", f[1], st)
            elif f[0] == "loc": target, rest = ("loc", int(f[1]), int(f[2])), f[3:]
            elif f[0] == "spot": target, rest = ("spot", f[1]), f[2:]
            else: raise SystemExit("%s: %r" % (where, line))
            r.table[(cur, target)] = parse(" ".join(rest), where)
            continue
        if f[0] == "how": break           # (the rest of the file explains; the solver doesn't need it)
        if f[0] == "boss": r.boss = True
        elif f[0] == "map": r.map = True
        elif f[0] == "carried": r.carried.append(f[1])
        elif f[0] == "resets": r.resets[f[1]] = f[2]
        elif f[0] == "in": r.ins.append(f[1])
        elif f[0] == "out": r.outs.append(f[1])
        elif f[0] == "loc":
            key = (int(f[1]), int(f[2])); r.locs.append(key)
            if "#" in line: r.loc_names[key] = line.split("#", 1)[1].split(",")[0].strip()
        elif f[0] == "spot": r.spots.append(f[1])
        elif f[0] == "from": cur = (f[2], split_state(f[3:])[0])
        else: raise SystemExit("%s: %r" % (where, line))
    r.carried.sort()
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
        self.carried = []                        # [(state, its value as a new game starts)]: what the player carries


def load_connections(path=CONNECTIONS):
    c = Connections()
    for ln, raw in enumerate(open(path, encoding="utf-8"), 1):
        line = raw.split("#", 1)[0].strip()
        if not line: continue
        f = line.split()
        if f[0] == "start": c.start = (f[1], f[3])
        elif f[0] == "via": c.via.add((f[1], f[3]))
        elif f[0] == "carried": c.carried.append((f[1], f[2]))
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
                target = ("out", right[1], None)   # (left in the state it's come in in: below)
            elif right[0] == "loc" and len(right) == 3 and right[1].isdigit() and right[2].isdigit():
                target = ("loc", int(right[1]), int(right[2]))
            elif right[0] == "loc" and " ".join(right[1:]).lower() in names:
                k = names[" ".join(right[1:]).lower()]; target = ("loc",) + k
            elif right[0] == "spot" and len(right) == 2 and right[1] in r.spots:
                target = ("spot", right[1])
            else: raise SystemExit("%s: '%s' isn't a way out ('out <x,y>') or a place ('loc <type> <number>' or its name)" % (where, hf[1].strip()))
            if target[0] == "loc" and (target[1], target[2]) not in r.locs: raise SystemExit("%s: %s has no place %s" % (where, room, hf[1].strip()))
            if left[2] != "*" and left[2] not in r.ins: raise SystemExit("%s: %s has no way in %r" % (where, room, left[2]))
            # (each of the way in's states, in a room that carries one; a way out is left in the same state)
            ways = r.ways(None if left[2] == "*" else left[2])
            if not ways: ways = [(i, ()) for i in (r.ins if left[2] == "*" else [left[2]])]
            alts = parse(req, where)
            for w in ways:
                t = target if target[0] in ("loc", "spot") else ("out", target[1], w[1])
                if cmd == "set": r.table[(w, t)] = list(alts)
                else:
                    cur = r.table.setdefault((w, t), [])
                    for a in alts: add(cur, a)
            n += 1
        elif cmd in ("room", "area"):
            # every way through the room (or every room of the area): from each way in (in each state) to each way out
            # (left in the same state), place and spot, needing this, in place of what the room's file says
            head, _, req = f[1].partition(":")
            if not _: raise SystemExit("%s: no ':'" % where)
            what = head.strip()
            if cmd == "room":
                if what not in rooms: raise SystemExit("%s: no room %r" % (where, what))
                these = [rooms[what]]
            else:
                if not what.isdigit(): raise SystemExit("%s: 'area <number> : <requirements>'" % where)
                these = [r for r in rooms.values() if r.area_num == int(what)]
                if not these: raise SystemExit("%s: no room in area %s" % (where, what))
            alts = parse(req, where)
            for r in these:
                ways = r.ways() or [(i, ()) for i in r.ins]
                for w in ways:
                    for o in r.outs: r.table[(w, ("out", o, w[1]))] = list(alts)
                    for l in r.locs: r.table[(w, ("loc",) + l)] = list(alts)
                    for sp in r.spots: r.table[(w, ("spot", sp))] = list(alts)
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
            raise SystemExit("%s: unknown line %r (set, add, room, area, need or link)" % (where, cmd))
    return n


# ---------------------------------------------------------------- joining the rooms
class Result:
    """a node is (room, way in, the carried states' values: in connections.txt's order)"""
    def __init__(self):
        self.ways_in = {}        # node -> alternatives from the start
        self.back = {}           # (node, need) -> (node before, its need, the target taken, what the room part needed)
        self.places = collections.OrderedDict()   # (type, number) -> alternatives
        self.place_room = {}     # (type, number) -> the room (the first that has it)
        self.place_back = {}     # ((type, number), need) -> (node, its need, what the room part needed)
        self.spots = {}          # (room, spot) -> alternatives: what reaching it needs


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
    """an alternative that holds with these options on (its options dropped, its events kept), or None"""
    if not n.o: return n
    opts = {o for o in n.o if not o.startswith("event:")}
    if opts <= options: return Need(n.c, n.k, frozenset(o for o in n.o if o.startswith("event:")))
    return None


def with_events(alts, events):
    """alternatives with each event in them replaced by what the event needs (events: {name: alternatives}; one not
    there: never)"""
    out = []
    for a in alts:
        evs = [o for o in a.o if o.startswith("event:")]
        if not evs: add(out, a); continue
        base = [Need(a.c, a.k, a.o - frozenset(evs))]
        for e in evs: base = product(base, events.get(e[6:], []))
        for b in base: add(out, b)
    return out


def load_events(path=EVENTS):
    """events.txt: {event: [(kind "room" or "area", the room or area number, alternatives)]}"""
    ev = collections.OrderedDict()
    if not os.path.exists(path): return ev
    for ln, raw in enumerate(open(path, encoding="utf-8"), 1):
        line = raw.split("#", 1)[0].strip()
        if not line: continue
        head, _, req = line.partition(":")
        f = head.split()
        if len(f) != 3 or f[1] not in ("room", "area"): raise SystemExit("events.txt line %d: '<event> room <room> [: <requirements>]' or '<event> area <number> ...'" % ln)
        ev.setdefault(f[0], []).append((f[1], f[2], parse(req, "events.txt line %d" % ln) if req.strip() else [NOTHING]))
    return ev


def event_needs(rooms, res, events):
    """what each event needs, from a result: {event: alternatives}. Each room's spots are events too: <room>/<spot>,
    what reaching it needs"""
    out = {}
    for r in rooms.values():
        for sp in r.spots: out["%s/%s" % (r.name, sp)] = list(res.spots.get((r.name, sp), []))
    for name, ways in events.items():
        alts = []
        for kind, what, extra in ways:
            if kind == "room": base = room_needs(rooms, res, what) if what in rooms else []
            else:
                base = []
                for rn, r in rooms.items():
                    if str(r.area_num) == what:
                        for a in room_needs(rooms, res, rn): add(base, a)
            for a in product(base, extra): add(alts, a)
        out[name] = alts
    return out


def solve_events(rooms, conn, options=frozenset(), events=None):
    """solve, with the events worked out: solved with what each event's been found to need so far, put in its place,
    till that stops changing"""
    if events is None: events = load_events()
    known = {}
    for _ in range(30):
        res = solve(rooms, conn, options, events=known)
        new = event_needs(rooms, res, events)
        if {k: sorted(map(str, v)) for k, v in new.items()} == {k: sorted(map(str, v)) for k, v in known.items()}: break
        known = new
    res.events = known
    return res


def solve(rooms, conn, options=frozenset(), carry=True, events=None):
    """joins the rooms from the start: what each way in (in each carried state) and each place needs. carry=False: each
    room as if the player came in with the carried states as a new game starts them (what RoomLogic.exe's own joining
    does: the check). events: {event: what it needs}, put in each event's place (solve_events works them out); None:
    events stay in the requirements as they are (the check)"""
    res = Result()
    sub = (lambda alts: with_events(alts, events)) if events is not None else (lambda alts: alts)
    groups = [g for g, v in conn.carried]
    start_gs = tuple(v for g, v in conn.carried)

    def come_in(r, gs):
        # (the states as the player comes into the room: those it sets, set; and the room's own part of them)
        if not carry: gs = start_gs
        if r.resets: gs = tuple(r.resets.get(g, v) for g, v in zip(groups, gs))
        return gs, tuple(sorted((g, v) for g, v in zip(groups, gs) if g in r.carried))

    def leave(gs, st):
        if not carry: return start_gs
        d = dict(st)
        return tuple(d.get(g, v) for g, v in zip(groups, gs))

    start = (conn.start[0], conn.start[1], start_gs)
    res.ways_in[start] = [NOTHING]
    queue = collections.deque([start]); queued = {start}
    by_way = {}
    for r in rooms.values():
        for (w, t), alts in r.table.items(): by_way.setdefault((r.name, w), []).append((t, sub(alts)))
    while queue:
        node = queue.popleft(); queued.discard(node)
        room, inid, gs = node
        if room not in rooms: continue
        gs1, st = come_in(rooms[room], gs)
        for target, alts in by_way.get((room, (inid, st)), []):
            if target[0] != "out" or not alts: continue
            to, extra = through_exit(rooms, conn, room, target[1])
            if to is None or to[0] not in rooms or to[1] not in rooms[to[0]].ins: continue
            nxt = (to[0], to[1], leave(gs1, target[2]))
            part = sub(product(alts, extra))
            dst = res.ways_in.setdefault(nxt, [])
            changed = False
            for a in list(res.ways_in[node]):
                for p in part:
                    n = keep(mx(a, p), options)
                    if n is not None and add(dst, n):
                        res.back[(nxt, n)] = (node, a, target, p); changed = True
            if changed and nxt not in queued: queue.append(nxt); queued.add(nxt)
    # the places: each from each way in it's reached by
    for r in rooms.values():
        for key in r.locs:
            res.places.setdefault(key, [])
            res.place_room.setdefault(key, r.name)
    for node, alts in res.ways_in.items():
        if node[0] not in rooms: continue
        gs1, st = come_in(rooms[node[0]], node[2])
        for target, talts in by_way.get((node[0], (node[1], st)), []):
            if target[0] == "spot":
                dst = res.spots.setdefault((node[0], target[1]), [])
                for a in alts:
                    for t in talts:
                        n = keep(mx(a, t), options)
                        if n is not None: add(dst, n)
                continue
            if target[0] != "loc": continue
            key = (target[1], target[2])
            for a in alts:
                for t in talts:
                    n = keep(mx(a, t), options)
                    if n is not None and add(res.places[key], n): res.place_back[(key, n)] = (node, a, t)
    return res


def room_needs(rooms, res, name):
    out = []
    for node, alts in res.ways_in.items():
        if node[0] == name:
            for a in alts: add(out, a)
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
    """the rooms' parts from the start to a way in, with that need: [(node, the target taken, what the part needed)]"""
    out = []
    while (node, need) in res.back:
        prev, pneed, target, part = res.back[(node, need)]
        out.append((prev, target, part))
        node, need = prev, pneed
    out.reverse()
    return out


def node_text(rooms, conn, node):
    """a way in, with the carried states as the room has them ("48,480 [water 3]")"""
    r = rooms.get(node[0])
    st = tuple(sorted((g, v) for (g, s), v in zip(conn.carried, node[2]) if r is not None and g in r.carried))
    if r is not None and r.resets: st = tuple(sorted((g, r.resets.get(g, v)) for g, v in st))
    return node[1] + state_text(st)


def explain(rooms, conn, res, key):
    name = rooms[res.place_room[key]].loc_names.get(key, "")
    alts = res.places.get(key, [])
    print("loc %d %d (%s), in %s: %s" % (key[0], key[1], name, res.place_room[key], alts_text(alts)))
    if not alts: print("  not reached from the start (see the rooms on the way: --room, and their files' 'never's)")
    for k, a in enumerate(alts, 1):
        node, nneed, part = res.place_back[(key, a)]
        print("\nway %d: %s" % (k, a))
        print("  start: %s in %s" % conn.start)
        for prev, target, pt in chain_to(res, node, nneed):
            to = conn.links[(prev[0], target[1])]
            print("  %-22s in %-18s -> out %-20s %-28s (then %s in %s)" % (prev[0], node_text(rooms, conn, prev), target[1] + state_text(target[2]),
                                                                          "[" + str(pt) + "]", to[0], to[1]))
        print("  %-22s in %-18s -> loc %d %d %s" % (node[0], node_text(rooms, conn, node), key[0], key[1], "[" + str(part) + "]"))
    if alts: print("\n(each room's part is in its file, rooms\\<room>.txt: its 'how in <x,y> -> <way out or place>' lines say the moves)")


def show_room(rooms, conn, res, name):
    if name not in rooms: raise SystemExit("no room %r" % name)
    r = rooms[name]
    print("%s: %s%s%s" % (name, r.area, " (boss)" if r.boss else "", " (map)" if r.map else ""))
    nodes = [nd for nd in res.ways_in if nd[0] == name]
    for i in r.ins:
        best = []
        for nd in nodes:
            if nd[1] == i:
                for a in res.ways_in[nd]: add(best, a)
        print("  in  %-12s from the start: %s" % (i, alts_text(best)))
    for o in r.outs:
        best = []
        for nd in nodes:
            st = tuple(sorted((g, v) for (g, s), v in zip(conn.carried, nd[2]) if g in r.carried))
            if r.resets: st = tuple(sorted((g, r.resets.get(g, v)) for g, v in st))
            for (w, t), talts in r.table.items():
                if w == (nd[1], st) and t[0] == "out" and t[1] == o:
                    for a in res.ways_in[nd]:
                        for x in talts: add(best, mx(a, x))
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
    res = solve_events(rooms, conn, options)
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
    res = solve_events(rooms, conn, frozenset(opts))
    if "--explain" in args:
        explain(rooms, conn, res, find_place(rooms, args[args.index("--explain") + 1])); return
    if "--room" in args:
        show_room(rooms, conn, res, args[args.index("--room") + 1]); return
    if "--check" in args:
        # (RoomLogic.exe's own joining has each room come into with the carried states as a new game starts them)
        path = args[args.index("--check") + 1]
        res = solve(rooms, conn, frozenset(opts), carry=False)
        d = check(res, path) + check_rooms(rooms, res, path)
        print("%d differences" % len(d)); print("\n".join(d[:50])); return
    reached, total = write_result(rooms, res)
    print("%d rooms, %d connections, %d overrides; places reached %d of %d; written %s" % (len(rooms), len(conn.links), n, reached, total, OUT))


if __name__ == "__main__":
    main()
