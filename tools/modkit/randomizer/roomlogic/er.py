"""
er.py: the entrance randomizer's doors, and its seed maker in Python (the same steps as the mod's: rndgen runs it for a
few seeds of each mode at build time, so a mode whose shuffles can't be finished shows up there).

Doors. Two exits that lead to each other (room A's exit to room B, and B's exit back to where A's one is) are a door
with two ends. An end is a room's exit and the way into that room the other end's exit leads to (where the player
comes back in). Shuffling pairs a mode's ends anew, at random: an exit leads to its new partner's way in, and the
partner's exit back to its own (going back through a door returns the player where they came from).

Modes (the new game's option Entrance Rando):
  gates       the Access Gates' and Nightmare Gates' doors (oAccessGate, oDistortionGate): Gate Swap
  overworld   those, every door between two areas, and every door between a map (Hyrule's, Gate 6's) and a room
  chaos       every door
Every mode leaves out: one-way exits, doors within a room, menus and encounters, the exits that are boss fights
(connections.txt's via), exits whose way goes by a carried state and the Forest Palace's rooms (its crystals), the
encounter rooms, rooms the logic doesn't reach even with everything (story rooms), ends whose way in reaches nothing
(the player would come in inside a solid) or doesn't get back out through the end's own exit (a drop with no way back
up), and exits the game can't find by where they are (two at one place). An end with a Metroid door in front of its
exit is only paired with one whose Metroid door needs the same (door_class).

The seed: shuffle, place the items as the game does (rndgen's fill_check: layers, the newest likelier) with what's
reached worked out from the rooms and the shuffled doors, then check that with everything every place the game's own
doors reach is reached, and the goal (the seven Nightmare Gates, the Abomination and the Warmaster). A shuffle that
fails is tried again with another.

usage: python er.py [<mode> [<seeds>]]     (the modes' doors, then <seeds> seeds made, default all modes, 20)
"""
import os, re, sys, time, random, collections
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
sys.path.insert(0, os.path.dirname(HERE))
import solve

MODES = ("gates", "overworld", "chaos")
GATE_OBJECTS = {"oAccessGate", "oDistortionGate"}
MAP_OBJECTS = {"oZeldaMapExit", "oGameMapExit"}
# exits the game's code (not the exit's own variables) sends somewhere: left as they are
FIXED_OBJECTS = {"oVaultGate", "oShooter_Start", "menu", "encounter"}
ENCOUNTER_ROOMS = {"rLink2_EnRoad", "rLink2_EnGrass", "rLink2_EnDesert", "rLink2_EnForest"}
# (a door's two exits: the way in each leads to is this near the other)
PAIR_DIST = 200


def xy(s):
    try: return tuple(int(v) for v in s.split(","))
    except ValueError: return None


def exit_objects(path=os.path.join(HERE, "work", "rooms.txt")):
    """{(room, "x,y"): the exit's object} from the room data (the ids as RoomLogic.cs gives them: where it's placed)"""
    out, room = {}, None
    for line in open(path, encoding="utf-8"):
        f = line.rstrip("\n").split("\t")
        if f[0] == "R": room = f[1]
        elif f[0] == "X" and room:
            key = (room, "%d,%d" % (round(float(f[2])), round(float(f[3]))))
            out.setdefault(key, f[11] if len(f) > 11 else "")
    return out


# a Metroid door (oMetroidDoorHolder) in front of an exit: going through the exit needs what opens it, from anywhere in
# the room (the room logic has it on every way there). An end whose exit has one only pairs with an end whose exit has
# one needing the same: the player only comes in behind one by going through one, so has what going back takes (an
# ordinary door to behind a Metroid door would leave them stuck there without a weapon)
METROID_DOOR_DIST = 96


def metroid_doors(path=os.path.join(HERE, "work", "rooms.txt")):
    """{room: [(x, y, what opening it needs)]} from the room data"""
    out, room = collections.defaultdict(list), None
    for line in open(path, encoding="utf-8"):
        f = line.rstrip("\n").split("\t")
        if f[0] == "R": room = f[1]
        elif f[0] == "G" and room and f[-1] == "oMetroidDoorHolder": out[room].append((float(f[2]), float(f[3]), f[7]))
    return out


def door_class(mdoors, room, out):
    """what the Metroid door in front of an exit needs ("attack", "samus:4"), or "" for none"""
    p = xy(out)
    if not p: return ""
    best = None
    for x, y, req in mdoors.get(room, ()):
        d = abs(p[0] - x) + abs(p[1] - y)
        if d <= METROID_DOOR_DIST and (best is None or d < best[0]): best = (d, req)
    return best[1] if best else ""


class End:
    __slots__ = ("i", "room", "out", "obj", "back", "area", "map", "cls")
    def __init__(self, i, room, out, obj, back, area, is_map, cls=""):
        self.i, self.room, self.out, self.obj, self.back, self.area, self.map = i, room, out, obj, back, area, is_map
        self.cls = cls      # (door_class: the Metroid door in front of its exit)
    def __repr__(self): return "%s out %s (in %s)" % (self.room, self.out, self.back)


def doors(rooms, conn, reach_all):
    """the doors: [(end, end)], each end an End. reach_all: the rooms the logic reaches with everything"""
    objs = exit_objects()
    mdoors = metroid_doors()
    links = [(rm, out, to[0], to[1]) for (rm, out), to in conn.links.items()]
    stated = set(conn.links_st)
    by_pair = collections.defaultdict(list)
    for l in links: by_pair[(l[0], l[2])].append(l)
    usable_in = {}
    back_out = set()      # (room, way in, way out): the way out gone through from the way in (with everything)
    for n, r in rooms.items():
        ok = set()
        for (w, t), alts in r.table.items():
            if alts:
                ok.add(w[0])
                if t[0] == "out": back_out.add((n, w[0], t[1]))
        if r.map: ok |= set(r.ins)
        usable_in[n] = ok

    def returns(rm, back, out):
        """an end's way back out: from where the player comes in, its own exit can be gone through (not a drop with no
        way back up: going in by another door would leave them where the shuffle's way back isn't)"""
        return (rm, back, out) in back_out or rooms[rm].map

    def ok_exit(rm, out):
        o = objs.get((rm, out), "")
        # (an exit the game finds by where it is: a menu's choice, or an exit with another at the same place, it can't)
        if "(" in out or ":" in out: return False
        if any(o.startswith(out + "(") for o in rooms[rm].outs): return False
        if o in FIXED_OBJECTS or (rm, out) in stated or (rm, out) in conn.via: return False
        if rm.startswith(tuple(conn.scope.values())) or rm in ENCOUNTER_ROOMS or rm not in reach_all: return False
        return True

    cands = []
    for (a, b), ls in by_pair.items():
        if a == b or a > b: continue
        for l1 in ls:
            for l2 in by_pair.get((b, a), []):
                o1, i1, o2, i2 = xy(l1[1]), xy(l2[3]), xy(l2[1]), xy(l1[3])
                if not (o1 and i1 and o2 and i2): continue
                d = abs(o1[0] - i1[0]) + abs(o1[1] - i1[1]) + abs(o2[0] - i2[0]) + abs(o2[1] - i2[1])
                if abs(o1[0] - i1[0]) + abs(o1[1] - i1[1]) > PAIR_DIST or abs(o2[0] - i2[0]) + abs(o2[1] - i2[1]) > PAIR_DIST: continue
                cands.append((d, l1, l2))
    cands.sort()
    used, pairs = set(), []
    for d, l1, l2 in cands:
        if (l1[0], l1[1]) in used or (l2[0], l2[1]) in used: continue
        if not ok_exit(l1[0], l1[1]) or not ok_exit(l2[0], l2[1]): continue
        if l2[3] not in usable_in.get(l1[0], ()) or l1[3] not in usable_in.get(l2[0], ()): continue
        if not returns(l1[0], l2[3], l1[1]) or not returns(l2[0], l1[3], l2[1]): continue
        used.add((l1[0], l1[1])); used.add((l2[0], l2[1]))
        a = End(0, l1[0], l1[1], objs.get((l1[0], l1[1]), ""), l2[3], rooms[l1[0]].area_num, rooms[l1[0]].map,
                door_class(mdoors, l1[0], l1[1]))
        b = End(0, l2[0], l2[1], objs.get((l2[0], l2[1]), ""), l1[3], rooms[l2[0]].area_num, rooms[l2[0]].map,
                door_class(mdoors, l2[0], l2[1]))
        pairs.append((a, b))
    k = 0
    for a, b in pairs:
        a.i, b.i = k, k + 1; k += 2
    return pairs


def pool(pairs, mode):
    """the doors a mode shuffles (not a door whose two ends' Metroid doors need different things: the game's own pairs
    those, and the shuffle pairs only ends whose Metroid doors need the same: door_class)"""
    pairs = [p for p in pairs if p[0].cls == p[1].cls]
    if mode == "gates": return [p for p in pairs if p[0].obj in GATE_OBJECTS or p[1].obj in GATE_OBJECTS]
    if mode == "overworld":
        return [p for p in pairs if p[0].obj in GATE_OBJECTS or p[1].obj in GATE_OBJECTS or p[0].area != p[1].area
                or p[0].map or p[1].map]
    return list(pairs)


class Ways:
    """the world with everything, as ways: from each way into a room (room, in), the exits it gets to (any carried
    state), and where the exits the mode doesn't shuffle lead. For making a shuffle (what a door joins), not for the
    seed's check, which works out the items"""
    def __init__(self, world, doors_):
        self.pool_exits = {(e.room, e.out) for p in doors_ for e in p}
        self.outs = collections.defaultdict(set)
        self.locs = collections.defaultdict(set)
        for r in world.rooms.values():
            for (w, t), alts in r.table.items():
                if alts and t[0] == "out": self.outs[(r.name, w[0])].add(t[1])
                elif alts and t[0] == "loc": self.locs[(r.name, w[0])].add((t[1], t[2]))
        self.fixed = collections.defaultdict(set)
        for (rm, out), to in world.conn.links.items(): self.fixed[(rm, out)].add(to)
        for (rm, out), lst in world.conn.links_st.items():
            for st, to in lst: self.fixed[(rm, out)].add(to)
        self.ends = {(e.room, e.out): e for p in doors_ for e in p}

    def grow(self, nodes, seen, part, free, frontier, places=None):
        """reaches on from nodes (added to seen): the free ends whose exits it gets to go in frontier, the places it gets
        to in places; through a paired end, on to its partner's way in"""
        stack = list(nodes)
        while stack:
            u = stack.pop()
            if places is not None: places |= self.locs.get(u, set())
            for out in self.outs.get(u, ()):
                e = self.ends.get((u[0], out))
                if e is not None:
                    if e in part: nxt = [(part[e].room, part[e].back)]
                    else:
                        if e in free: frontier.add(e)
                        continue
                elif (u[0], out) in self.pool_exits: continue
                else: nxt = self.fixed.get((u[0], out), ())
                for v in nxt:
                    if v not in seen: seen.add(v); stack.append(v)


def shuffle(doors_, rng, ways, start):
    """{end: its new partner end} for a mode's doors, made out from the start: an end whose exit what's reached gets to
    is joined to an end whose way in isn't reached yet, till every end's way in is (an end that leads on to others first
    while it's the last one to go on from, so it doesn't stop at a dead end); the ends left are paired at random. None if
    it couldn't be done"""
    ends = [e for p in doors_ for e in p]
    rng.shuffle(ends)
    free = set(ends)
    part = {}
    seen, frontier, places = {start}, set(), set()
    ways.grow([start], seen, part, free, frontier, places)
    def fanout(e):
        s, f = {(e.room, e.back)} | seen, set()
        ways.grow([(e.room, e.back)], s, part, free - {e}, f)
        return len(f - frontier)
    # an end whose way in leads somewhere new (a room not reached, or ways or places that aren't) has to be joined to
    # what's reached; one that doesn't is covered (seen only grows: it stays so)
    covered = set()
    def new_ground(e):
        if e.room not in {v[0] for v in seen}: return True
        s, f, pl = set(seen), set(), set()
        s.add((e.room, e.back))
        ways.grow([(e.room, e.back)], s, part, free - {e}, f, pl)
        return len(s) - len(seen) > 1 or bool(f - frontier) or bool(pl - places)
    while True:
        # (a random end not joined yet whose way in isn't reached: covered ones found as they come up. It's joined to an
        # end of the frontier whose Metroid door needs the same, door_class)
        pending = [e for e in ends if e in free and (e.room, e.back) not in seen and e not in covered]
        rng.shuffle(pending)
        u = None
        fr = [e for e in frontier if e in free]
        for e in pending:
            if not new_ground(e): covered.add(e); continue
            frc = [x for x in fr if x is not e and x.cls == e.cls]
            if not frc: continue
            if len(fr) == 1 and any(x is not e and x not in covered for x in pending[pending.index(e) + 1:]) and fanout(e) == 0:
                continue
            u = e; break
        if u is None:
            if any(e in free and (e.room, e.back) not in seen and e not in covered for e in ends): return None
            break
        f = rng.choice(sorted([e for e in fr if e is not u and e.cls == u.cls], key=lambda x: x.i))
        part[f] = u; part[u] = f; free.discard(f); free.discard(u)
        frontier.discard(f); frontier.discard(u)
        new = [v for v in ((u.room, u.back), (f.room, f.back)) if v not in seen]
        for v in new: seen.add(v)
        ways.grow(new, seen, part, free, frontier, places)
    rest = [e for e in ends if e in free]
    rng.shuffle(rest)
    for c in sorted({e.cls for e in rest}):
        rc = [e for e in rest if e.cls == c]
        for k in range(0, len(rc) - 1, 2): part[rc[k]] = rc[k + 1]; part[rc[k + 1]] = rc[k]
    return part


# ---------------------------------------------------------------- what the items reach (with a door shuffle)
class World:
    """the rooms, connections, events and the overrides, ready for working out what a set of items reaches"""
    def __init__(self):
        self.rooms = solve.load_rooms(); self.conn = solve.load_connections()
        solve.load_overrides(self.rooms, self.conn)
        self.events = solve.load_events()
        self.groups = [g for g, v in self.conn.carried]
        self.start_gs = tuple(v for g, v in self.conn.carried)
        self.scopes = collections.OrderedDict()
        for i, g in enumerate(self.groups):
            if g in self.conn.scope: self.scopes.setdefault(self.conn.scope[g], []).append(i)
        # each room's rows by way: (room, (inid, st)) -> [(target, [alternative])], an alternative (items, keys, events)
        self.by_way = collections.defaultdict(list)
        for r in self.rooms.values():
            for (w, t), alts in r.table.items():
                self.by_way[(r.name, w)].append((t, [self.alt(a) for a in alts]))
        self.loc_room = {}
        for r in self.rooms.values():
            for key in r.locs: self.loc_room.setdefault(key, r.name)
        # events: name -> [(kind, what, [alternative])] (as without Instrument Randomization); ev_modes: every line, with
        # its mode (solve.load_events: 0 always, 1 without it, 2 with it), for erflat's tables
        self.ev = {name: [(k, w, [self.alt(a) for a in ex]) for k, w, ex in ways] for name, ways in self.events.items()}
        self.ev_modes = {name: [(k, w, [self.alt(a) for a in ex], m) for k, w, ex, m in ways]
                         for name, ways in solve.load_events(modes=True).items()}

    def alt(self, need):
        items = {solve.ITEMS[i]: n for i, n in enumerate(need.c) if n}
        return (items, frozenset(need.k), frozenset(o[6:] for o in need.o if o.startswith("event:")))


class Reach:
    """what a set of items reaches from the start, with doors shuffled (part: {End: End}, ends: {(room, out): End}),
    worked out step by step as items are added (add): rows that can't be gone through yet wait (blocked) till something
    added lets them"""
    def __init__(self, world, part, ends):
        self.w = world; self.part = part; self.ends = ends
        self.have = collections.Counter(); self.keys = set(); self.evs = set()
        self.nodes = set(); self.places = set(); self.spots = set(); self.rooms_in = set()
        self.parked = {sc: {tuple(world.start_gs[i] for i in ix)} for sc, ix in world.scopes.items()}
        self.crossings = {sc: set() for sc in world.scopes}
        self.blocked = []
        self.queue = collections.deque()
        st = (world.conn.start[0], world.conn.start[1], self.outside(world.conn.start[0], world.start_gs))
        self.reach_node(st)
        self.run()

    def outside(self, name, gs):
        for sc, ix in self.w.scopes.items():
            if not name.startswith(sc): gs = tuple("*" if i in ix else v for i, v in enumerate(gs))
        return gs

    def ok(self, alts):
        for items, keys, evs in alts:
            if all(self.have[i] >= n for i, n in items.items()) and keys <= self.keys and evs <= self.evs: return True
        return False

    def reach_node(self, node):
        if node in self.nodes: return
        self.nodes.add(node); self.rooms_in.add(node[0]); self.queue.append(node)

    def dest(self, room, out, st):
        """where an exit leads (room, in) with the door shuffle, and what going through needs on top (alternatives)"""
        e = self.ends.get((room, out))
        if e is not None and e in self.part:
            p = self.part[e]; to = (p.room, p.back)
        else:
            to = solve.link_of(self.w.conn, room, out, st)
        if not to: return None, None
        extra = [({}, frozenset(), frozenset())]
        conn = self.w.conn
        if to[0] != room and to[0] in conn.boss: extra = [self.w.alt(a) for a in conn.boss[to[0]]]
        elif to[0] != room and self.w.rooms.get(to[0]) is not None and self.w.rooms[to[0]].boss: extra = [self.w.alt(a) for a in solve.ATTACK]
        if (room, out) in conn.via: extra = [self.w.alt(a) for a in conn.via_need.get((room, out), solve.ATTACK)]
        if (room, out) in conn.need: extra = [self.w.alt(a) for a in conn.need[(room, out)]]
        return to, extra

    def expand(self, node):
        room, inid, gs = node
        r = self.w.rooms.get(room)
        if r is None: return
        if r.resets: gs = tuple(r.resets.get(g, v) for g, v in zip(self.w.groups, gs))
        st = tuple(sorted((g, v) for g, v in zip(self.w.groups, gs) if g in r.carried))
        for target, alts in self.w.by_way.get((room, (inid, st)), []):
            if not alts: continue
            self.try_row(node, gs, target, alts)

    def try_row(self, node, gs, target, alts):
        room = node[0]
        if target[0] == "out":
            to, extra = self.dest(room, target[1], target[2])
            if to is None or to[0] not in self.w.rooms: return
            if not (self.ok(alts) and self.ok(extra)): self.blocked.append((node, gs, target, alts)); return
            d = dict(target[2]); g2 = tuple(d.get(g, v) for g, v in zip(self.w.groups, gs))
            nexts = [g2]
            for sc, ix in self.w.scopes.items():
                a_in, b_in = room.startswith(sc), to[0].startswith(sc)
                if a_in and not b_in:
                    vals = tuple(g2[i] for i in ix)
                    if vals not in self.parked[sc]:
                        self.parked[sc].add(vals)
                        for c in self.crossings[sc]: self.queue.append(c)
                    nexts = [tuple("*" if i in ix else v for i, v in enumerate(g)) for g in nexts]
                elif b_in and not a_in:
                    self.crossings[sc].add(node)
                    nexts = [tuple(dict(zip(ix, vals)).get(i, v) for i, v in enumerate(g)) for g in nexts for vals in self.parked[sc]]
            for g in nexts: self.reach_node((to[0], to[1], g))
            return
        if not self.ok(alts): self.blocked.append((node, gs, target, alts)); return
        if target[0] == "loc": self.places.add((target[1], target[2]))
        elif target[0] == "spot": self.spots.add((room, target[1]))

    def run(self):
        while True:
            while self.queue: self.expand(self.queue.popleft())
            # events: an event's room reached and what else it takes there
            new = False
            for name, ways in self.w.ev.items():
                if name in self.evs: continue
                for kind, what, extra in ways:
                    if kind == "room": hit = what in self.rooms_in
                    else: hit = any(rn in self.rooms_in and str(self.w.rooms[rn].area_num) == what for rn in self.rooms_in)
                    if hit and self.ok(extra): self.evs.add(name); new = True; break
            for (rm, sp) in list(self.spots):
                if rm + "/" + sp not in self.evs: self.evs.add(rm + "/" + sp); new = True
            if not new and not self.queue: break
            if new: self.retry()

    def retry(self):
        b, self.blocked = self.blocked, []
        for node, gs, target, alts in b: self.try_row(node, gs, target, alts)

    def add(self, item, n=1):
        """one more of an item ("djump", "link"..., or ("key", n))"""
        if isinstance(item, tuple): self.keys.add(item[1])
        else: self.have[item] += n
        self.retry(); self.run()


def prog_item(ix):
    """a progression number (rndgen's prog_of) as the logic's item: its name, or ("key", objectNum)"""
    import rndgen
    if ix >= rndgen.KEY_BASE: return ("key", ix - rndgen.KEY_BASE)
    names = {v: k for k, v in rndgen.LOGIC_NAMES.items()}
    return names.get(ix)


def fill_er(world, rows, items, part, ends, rng, weapons=False, newest=0.7):
    """rndgen's fill_check (the game's rndGenerate) with what the items reach worked out from the rooms and the shuffled
    doors: the progression items one at a time, each one that opens something not reached yet if there is one (a kind
    that opens fewer likelier), at a free location they reach, the newest layer likelier. Returns [(layer, location,
    item)], or None when an item had nowhere to go"""
    import rndgen
    prog = [i for i, it in enumerate(items) if rndgen.prog_of(it) > 0]
    rng.shuffle(prog)
    total = collections.Counter(rndgen.prog_of(items[i]) for i in prog)
    have = collections.Counter()
    reach = Reach(world, part, ends)
    layer = [-1] * len(rows)
    filled = [False] * len(rows)
    armed = set()
    cur = 0
    def mark(lay):
        all_had = all(have[ix] >= n for ix, n in total.items())
        new = 0
        for i, r in enumerate(rows):
            if layer[i] >= 0: continue
            ok = all_had if r["req"] is rndgen.EVERYTHING else (r["type"], r["num"]) in reach.places
            if ok: layer[i] = lay; new += 1
        return new
    mark(0)
    placed, remaining = [], list(prog)
    while remaining:
        # (the items one more of which lets a row that waits through: each way through a room or exit short of just it)
        useful = collections.Counter()
        for node, gs, target, alts in reach.blocked:
            for items_, keys, evs in alts:
                if not evs <= reach.evs: continue
                short = [(it, n - reach.have[it]) for it, n in items_.items() if reach.have[it] < n] + \
                        [(("key", k), 1) for k in keys if k not in reach.keys]
                if len(short) == 1 and short[0][1] == 1:
                    it = short[0][0]
                    ix = rndgen.KEY_BASE + it[1] if isinstance(it, tuple) else rndgen.LOGIC_NAMES.get(it)
                    if ix is not None: useful[ix] += 1
        pool_ = remaining
        force = False
        if weapons and cur not in armed and any(not filled[i] for i in range(len(rows)) if layer[i] == cur):
            pool_ = [k for k in remaining if rndgen.prog_of(items[k]) in rndgen.WEAPONS]
            if pool_: force = True
            else: pool_ = remaining
        cand = [k for k in pool_ if useful[rndgen.prog_of(items[k])] > 0]
        if cand:
            kinds = sorted(set(rndgen.prog_of(items[c]) for c in cand))
            r = rng.random() * sum(1.0 / useful[ix] for ix in kinds)
            kind = kinds[-1]
            for ix in kinds:
                r -= 1.0 / useful[ix]
                if r <= 0: kind = ix; break
            cand = [c for c in cand if rndgen.prog_of(items[c]) == kind]
        else:
            cand = list(pool_)
        k = rng.choice(cand)
        if force: pick = cur
        else:
            layers = sorted({layer[i] for i in range(len(rows)) if layer[i] >= 0 and not filled[i]}, reverse=True)
            if not layers: return None
            pick = layers[-1]
            for lay in layers:
                if rng.random() < newest: pick = lay; break
        free = [i for i in range(len(rows)) if layer[i] == pick and not filled[i]]
        if not free: return None
        loc = rng.choice(free)
        filled[loc] = True
        placed.append((pick, loc, k))
        ix = rndgen.prog_of(items[k])
        if ix in rndgen.WEAPONS: armed.add(pick)
        remaining.remove(k)
        have[ix] += 1
        it = prog_item(ix)
        if it is not None: reach.add(it)
        if mark(cur + 1): cur += 1
    return placed


def all_items():
    """everything there is: ([item names with counts], keys)"""
    import rndgen
    names = {v: k for k, v in rndgen.LOGIC_NAMES.items()}
    have = {names[i]: rndgen.PMAX[i] for i in names}
    return have


def reach_with(world, part, ends, have, keys):
    r = Reach(world, part, ends)
    for it, n in have.items():
        if n: r.have[it] = n
    r.keys = set(keys)
    r.retry(); r.run()
    return r


def main():
    args = sys.argv[1:]
    modes = [args[0]] if args else list(MODES)
    seeds = int(args[1]) if len(args) > 1 else 20
    t0 = time.time()
    w = World()
    import rndgen
    allk = sorted({k for r in w.rooms.values() for alts in r.table.values() for a in alts for k in a.k})
    have = all_items()
    base = reach_with(w, {}, {}, have, allk)
    reach_all = set(base.rooms_in)
    print("the game's own doors, everything: %d rooms, %d places reached (%.1fs)" % (len(reach_all), len(base.places), time.time() - t0))
    pairs = doors(w.rooms, w.conn, reach_all)
    print("doors: %d" % len(pairs))
    for m in MODES: print("  %-10s %d doors" % (m, len(pool(pairs, m))))
    ends = {(e.room, e.out): e for p in pairs for e in p}
    import rndgen
    rows, items = rndgen.locations_items()[8:10]
    for m in modes:
        pl = pool(pairs, m)
        ways = Ways(w, pl)
        rng = random.Random(1)
        stats = collections.Counter()
        tries_all, t1 = [], time.time()
        for s in range(seeds):
            for t in range(1, 201):
                ok, why = make_seed(w, pl, ways, ends, base, have, allk, rows, items, rng)
                stats[why] += 1
                if ok: tries_all.append(t); break
            else: tries_all.append(None)
        done = [t for t in tries_all if t]
        print("%-10s %d of %d seeds made; tries %s; %s (%.0fs)" % (
            m, len(done), seeds, ("1-%d, average %.1f" % (max(done), sum(done) / len(done))) if done else "-",
            ", ".join("%s %d" % kv for kv in sorted(stats.items())), time.time() - t1))


GOAL_EVENTS = ("gateA", "gateB", "gateC", "gateD", "gateE", "gateF", "gateG")
GOAL_ROOMS = ("rWarshipZ_E2", "rMain_76")


def make_seed(w, pl, ways, ends, base, have, allk, rows, items, rng, weapons=False, newest=0.7):
    """one try at a seed: (True, "made") with the shuffle and the placement good, else (False, why)"""
    part = shuffle(pl, rng, ways, (w.conn.start[0], w.conn.start[1]))
    if part is None: return False, "shuffle stuck"
    r = reach_with(w, part, ends, have, allk)
    if not (base.places <= r.places and all(g in r.rooms_in for g in GOAL_ROOMS) and all(e in r.evs for e in GOAL_EVENTS)):
        return False, "not all reached"
    placed = fill_er(w, rows, items, part, ends, rng, weapons, newest)
    if placed is None: return False, "items stuck"
    if not playthrough(w, part, ends, placed, rows, items, base):
        raise SystemExit("a seed the fill made can't be played through: a bug in er.py")
    return True, "made"


def playthrough(w, part, ends, placed, rows, items, base):
    """an independent check of a made seed: from nothing, take every progression item the player can reach, over and over;
    it's good if that ends with all of them, every place the game's own doors reach, and the goal"""
    import rndgen
    at = {loc: items[k] for lay, loc, k in placed}
    r = Reach(w, part, ends)
    got = set()
    while True:
        new = [loc for loc in at if loc not in got and (rows[loc]["type"], rows[loc]["num"]) in r.places]
        if not new:
            # (the places that need everything: open once all the rest are got)
            if len(got) == len(at) - sum(1 for loc in at if rows[loc]["req"] is rndgen.EVERYTHING): break
            break
        for loc in new:
            got.add(loc)
            it = prog_item(rndgen.prog_of(at[loc]))
            if it is not None: r.add(it)
    if len(got) != len(at): return False
    return base.places <= r.places and all(g in r.rooms_in for g in GOAL_ROOMS) and all(e in r.evs for e in GOAL_EVENTS)


if __name__ == "__main__":
    main()
