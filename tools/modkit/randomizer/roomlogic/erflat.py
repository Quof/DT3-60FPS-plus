"""
erflat.py: the entrance randomizer as the mod runs it: the rooms' logic and the doors as flat tables of numbers
(export: rndgen writes them to the mod as rndER), and the seed maker over those tables (Reach, shuffle, fill), line for
line the mod's rnd ER scripts (rndERReach*, rndERShuffle, rndGenerateER), so what they do can be checked here (er.py's
own engine works it out from the room files: the two must agree).

The tables (all numbers; "first"/"count" index a flat list):
  groups      the carried states (connections.txt's carried: rb, water, crystal1-3), each with its values; a state of all
              of them is one number, gs (each group's value's place in its list, times the product of the lists before
              it; a crystal kept within the Forest Palace has one more value outside it: parked, P)
  rooms       each room's carried groups, resets, boss fight (what going in from another room takes) and scope
  entries     each way into a room (room, x, y): its ways, one a state of the room's own carried groups
  ways        each way's rows: what it gets to (an exit, a place, a spot) and what that takes (alternatives)
  exits       where each leads (an entry; one that goes by a crystal: one a value), and what going through takes on top
  events      what makes each happen (a room or an area got into, and what else it takes there)
  ends        the doors' ends (exit, way back in, the modes they're in, the game's own partner)
  everything  from each entry, with everything: the exits and places it gets to (for making a shuffle)
  bosses      Boss Rando: each of the mod's bosses' fight (what it takes) and places (its room, its via exit)
Requirements: a list of (number, count): a progression item (rndgen's prog_of numbers), a key (KEY_BASE+objectNum), or
an event (EV_BASE+event).
"""
import os, sys, collections, random
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
sys.path.insert(0, os.path.dirname(HERE))
import solve, er

PARKED = "P"
MODE_BITS = {"gates": 1, "overworld": 2, "chaos": 4}


class Flat:
    pass


def export(w, pairs, rows, bosses=()):
    """the tables, from er.py's World (rooms, connections, overrides, bosses, events), the doors, rndgen's rows and its
    bosses (rndgen.boss_slots: the mod's boss numbers' type, room, via and whether it's the final boss)"""
    import rndgen
    f = Flat()
    KB = rndgen.KEY_BASE
    f.KEY_BASE = KB
    f.EV_BASE = KB + 64
    # groups and their values (a scoped group: one more value, parked)
    f.gnames = [g for g, v in w.conn.carried]
    gvals = {"rb": ["0", "1"], "water": ["1", "2", "3"]}
    for g in f.gnames:
        if g.startswith("crystal"): gvals[g] = ["0", "1"]
    f.gvals = [gvals[g] + ([PARKED] if g in w.conn.scope else []) for g in f.gnames]
    f.gmult = []
    m = 1
    for vals in f.gvals: f.gmult.append(m); m *= len(vals)
    f.gs_n = m
    f.scope = sorted(set(w.conn.scope.values()))
    f.scoped = [i for i, g in enumerate(f.gnames) if g in w.conn.scope]
    # (the start's state: each group's value as a new game starts)
    f.start_gs = sum(f.gvals[i].index(v) * f.gmult[i] for i, (g, v) in enumerate(w.conn.carried))
    # rooms
    f.rnames = sorted(w.rooms)
    rix = {n: i for i, n in enumerate(f.rnames)}
    f.room_area = [w.rooms[n].area_num if w.rooms[n].area_num is not None else -1 for n in f.rnames]
    f.room_carried = [[f.gnames.index(g) for g in w.rooms[n].carried] for n in f.rnames]
    f.room_resets = [[(f.gnames.index(g), f.gvals[f.gnames.index(g)].index(v)) for g, v in sorted(w.rooms[n].resets.items())] for n in f.rnames]
    f.room_scope = [1 if any(n.startswith(s) for s in f.scope) else 0 for n in f.rnames]
    # requirements and alternatives (flat)
    f.req_ix, f.req_c, f.alt_first, f.alt_count = [], [], [], []
    evnames = list(w.ev.keys())
    for r in w.rooms.values():
        for sp in r.spots: evnames.append(r.name + "/" + sp)
    f.evnames = evnames
    evix = {n: i for i, n in enumerate(evnames)}
    def alts(lst):
        """a list of alternatives (er.World.alt's (items, keys, events)) into the flat lists: (first, count)"""
        first = len(f.alt_first)
        for items, keys, evs in lst:
            f.alt_first.append(len(f.req_ix))
            n = 0
            for it, c in sorted(items.items()):
                f.req_ix.append(rndgen.LOGIC_NAMES[it]); f.req_c.append(c); n += 1
            for k in sorted(keys): f.req_ix.append(KB + k); f.req_c.append(1); n += 1
            for e in sorted(evs):
                if e not in evix: raise SystemExit("erflat: no event %r" % e)
                f.req_ix.append(f.EV_BASE + evix[e]); f.req_c.append(1); n += 1
            f.alt_count.append(n)
        return first, len(lst)
    attack = [w.alt(a) for a in solve.ATTACK]
    f.room_boss = []
    for n in f.rnames:
        if n in w.conn.boss: f.room_boss.append(alts([w.alt(a) for a in w.conn.boss[n]]))
        elif w.rooms[n].boss: f.room_boss.append(alts(attack))
        else: f.room_boss.append((-1, 0))
    # entries: every way into every room (x,y), and the start
    f.entries = []
    eix = {}
    for n in f.rnames:
        for i in w.rooms[n].ins:
            eix[(n, i)] = len(f.entries); f.entries.append((rix[n], i))
    sx = (w.conn.start[0], w.conn.start[1])
    if sx not in eix: raise SystemExit("erflat: the start isn't a way in")
    f.start = eix[sx]
    # exits
    f.exits = []
    xix = {}
    for n in f.rnames:
        for o in w.rooms[n].outs:
            xix[(n, o)] = len(f.exits); f.exits.append((rix[n], o))
    f.exit_dest, f.exit_sg, f.exit_sdest, f.exit_extra = [], [], [], []
    for (ri, o) in f.exits:
        n = f.rnames[ri]
        to = w.conn.links.get((n, o))
        f.exit_dest.append(eix.get(to, -1) if to else -1)
        st = w.conn.links_st.get((n, o))
        if st:
            g = st[0][0][0][0]
            gi = f.gnames.index(g)
            d = [-1] * len(f.gvals[gi])
            for cond, to2 in st:
                for gg, vv in cond: d[f.gvals[gi].index(vv)] = eix.get(to2, -1)
            f.exit_sg.append(gi); f.exit_sdest.append(d)
        else:
            f.exit_sg.append(-1); f.exit_sdest.append([])
        ex = [({}, frozenset(), frozenset())]
        if (n, o) in w.conn.via: ex = er_product(ex, [w.alt(a) for a in w.conn.via_need.get((n, o), solve.ATTACK)])
        if (n, o) in w.conn.need: ex = er_product(ex, [w.alt(a) for a in w.conn.need[(n, o)]])
        f.exit_extra.append(alts(ex) if ex != [({}, frozenset(), frozenset())] else (-1, 0))
    # ways and rows
    f.entry_ways = []     # (first, count) into f.way_*
    f.way_st, f.way_rows = [], []
    f.row_kind, f.row_target, f.row_leave, f.row_alts = [], [], [], []
    loc_index = {(r["type"], r["num"]): i for i, r in enumerate(rows)}
    for (ri, inid) in f.entries:
        n = f.rnames[ri]
        r = w.rooms[n]
        ws = [wy for wy in r.ways(inid)]
        first = len(f.way_st)
        for wy in ws:
            f.way_st.append(st_code(f, ri, wy[1]))
            rfirst = len(f.row_kind)
            for target, al in w.by_way.get((n, wy), []):
                if not al: continue
                if target[0] == "out":
                    f.row_kind.append(1); f.row_target.append(xix[(n, target[1])]); f.row_leave.append(st_code(f, ri, target[2]))
                elif target[0] == "loc":
                    f.row_kind.append(2); f.row_target.append(loc_index.get((target[1], target[2]), -1)); f.row_leave.append(-1)
                else:
                    f.row_kind.append(3); f.row_target.append(evix[n + "/" + target[1]]); f.row_leave.append(-1)
                f.row_alts.append(alts(al))
            f.way_rows.append((rfirst, len(f.row_kind) - rfirst))
        f.entry_ways.append((first, len(ws)))
    # events
    f.ev_ways = []
    for name in evnames:
        if name in w.ev:
            lst = []
            for kind, what, ex in w.ev[name]:
                lst.append((1 if kind == "room" else 2, rix[what] if kind == "room" else int(what), alts(ex)))
            f.ev_ways.append(lst)
        else:
            f.ev_ways.append([])      # (a spot: its row makes it)
    f.goal_ev = [evix[e] for e in er.GOAL_EVENTS]
    f.goal_rooms = [rix[n] for n in er.GOAL_ROOMS]
    # door ends
    f.ends = []
    for a, b in pairs:
        for e, p in ((a, b), (b, a)):
            f.ends.append({"exit": xix[(e.room, e.out)], "back": eix[(e.room, e.back)], "mode": 0, "pair": p.i, "obj": e.obj})
    for m in er.MODES:
        for a, b in er.pool(pairs, m):
            f.ends[a.i]["mode"] |= MODE_BITS[m]; f.ends[b.i]["mode"] |= MODE_BITS[m]
    f.exit_end = [-1] * len(f.exits)
    for d, e in enumerate(f.ends): f.exit_end[e["exit"]] = d
    # with everything, from each entry: the exits and places its ways get to (any state)
    f.ev_outs, f.ev_locs = [], []
    for (ri, inid) in f.entries:
        n = f.rnames[ri]
        outs, locs = set(), set()
        for wy in w.rooms[n].ways(inid):
            for target, al in w.by_way.get((n, wy), []):
                if not al: continue
                if target[0] == "out": outs.add(xix[(n, target[1])])
                elif target[0] == "loc" and (target[1], target[2]) in loc_index: locs.add(loc_index[(target[1], target[2])])
        f.ev_outs.append(sorted(outs)); f.ev_locs.append(sorted(locs))
    f.loc_n = len(rows)
    # Boss Rando: each of the mod's bosses (its boss numbers), what its fight takes (going into its room from another,
    # bosses.txt), and the places it's fought: its room, and for one the story went into another way its via exit (the
    # fight going through it starts). A shuffled boss's places take the fight of the boss fought there instead (Reach's
    # fight); the final boss isn't shuffled
    def content(fc):
        first, cnt = fc
        return sorted(tuple(sorted((f.req_ix[k], f.req_c[k]) for k in range(f.alt_first[a], f.alt_first[a] + f.alt_count[a])))
                      for a in range(first, first + cnt))
    f.boss_n = len(bosses)
    f.boss_req, f.boss_shuf = [], []
    f.room_slot = [-1] * len(f.rnames)
    f.exit_slot = [-1] * len(f.exits)
    for i, (t, room, via, final) in enumerate(bosses):
        req = None
        if room in rix and f.room_boss[rix[room]][0] >= 0: req = f.room_boss[rix[room]]
        vx = None
        if via:
            for (rm, o), to in w.conn.links.items():
                if rm == via[0] and to[0] == via[1] and (rm, o) in w.conn.via:
                    if (rm, o) in w.conn.need: raise SystemExit("erflat: boss %d's via exit (%s out %s) needs more than the fight" % (t, rm, o))
                    vx = xix[(rm, o)]
            if vx is None: raise SystemExit("erflat: boss %d's via exit (%s to %s) isn't a via in connections.txt" % (t, via[0], via[1]))
            if req is None: req = f.exit_extra[vx]
            elif content(req) != content(f.exit_extra[vx]):
                raise SystemExit("erflat: boss %d's room and its via exit need different things (bosses.txt)" % t)
        if req is None:
            raise SystemExit("erflat: boss %d (%s): its room isn't a boss room in the logic and it has no via" % (t, room))
        f.boss_req.append(req)
        f.boss_shuf.append(0 if final else 1)
        if not final:
            if room in rix: f.room_slot[rix[room]] = i
            if vx is not None: f.exit_slot[vx] = i
    return f


def er_product(a, b):
    out = []
    for x in a:
        for y in b:
            items = dict(x[0])
            for k, v in y[0].items(): items[k] = max(items.get(k, 0), v)
            out.append((items, x[1] | y[1], x[2] | y[2]))
    return out


def st_code(f, ri, st):
    """a room's own state (its carried groups' values, (name, value) pairs) as a number"""
    d = dict(st)
    c, m = 0, 1
    for gi in f.room_carried[ri]:
        c += f.gvals[gi].index(d[f.gnames[gi]]) * m
        m *= len(f.gvals[gi])
    return c


# ---------------------------------------------------------------- what items reach (the mod's rndERReach scripts)
class Reach:
    """the reach of a set of items with a door shuffle (part: end -> its partner end, -1 for the game's own), from the
    start, worked out as items are added. A row that can't be gone through yet waits under each requirement it lacks
    (wait), and is tried again only when one of them comes (add); single counts the rows one more of a requirement would
    let through (rndGenerate's choice of item). fight: Boss Rando's bosses, the boss fought at each boss's places (None:
    each its own)"""
    def __init__(self, f, part, have, fight=None):
        self.f = f; self.part = part; self.have = have      # have: {number: count} (items, keys, events)
        self.fight = fight if fight is not None else list(range(f.boss_n))
        self.seen = set(); self.queue = collections.deque()
        self.room_in = set(); self.places = set(); self.parked = set()
        self.cross = []
        self.wait = collections.defaultdict(list)    # requirement number -> [(row instance, its filing number)]
        self.single = collections.Counter()          # requirement number -> rows one more of it lets through
        self.filing = {}                             # row instance -> (its filing number, [(number, single)])
        self.done = set()                            # row instances gone through
        self.ev_new = []                             # events (spots) that happened, for run to try their rows again
        # (the start is outside the scope: its crystals parked; their values as a new game starts are a parked set)
        self.parked.add(self.scoped_code(f.start_gs))
        self.go(f.start, self.park(f.start_gs))
        self.run()

    @property
    def blocked(self):
        return [inst for inst in self.filing]

    def lacks(self, first, count):
        """what a list of alternatives lacks: None if one of them is met, else [(numbers it lacks, shortfall)] an
        alternative (an event lacking counts as more than one)"""
        if first < 0: return None
        f = self.f
        out = []
        for a in range(first, first + count):
            nums, short = [], 0
            for k in range(f.alt_first[a], f.alt_first[a] + f.alt_count[a]):
                s = f.req_c[k] - self.have.get(f.req_ix[k], 0)
                if s > 0:
                    nums.append(f.req_ix[k])
                    short += 2 if f.req_ix[k] >= f.EV_BASE else s
            if not nums: return None
            out.append((nums, short))
        return out

    def unfile(self, inst):
        old = self.filing.pop(inst, None)
        if old:
            for ix, s in old[1]: self.single[ix] -= s

    def block(self, inst, lack, alone):
        """files a row instance under what it lacks (alone: the only part of its needs it lacks)"""
        old = self.filing.get(inst)
        n = old[0] + 1 if old else 1
        self.unfile(inst)
        fl = []
        for nums, short in lack:
            for ix in nums:
                s = 1 if alone and short == 1 else 0
                fl.append((ix, s)); self.single[ix] += s
                self.wait[ix].append((inst, n))
        self.filing[inst] = (n, fl)

    def passed(self, inst):
        self.unfile(inst)
        self.done.add(inst)

    def retry_ix(self, ix):
        """the rows waiting under a requirement, tried again"""
        lst = self.wait.pop(ix, [])
        tried = set()
        for inst, n in lst:
            if inst in self.done or inst in tried: continue
            cur = self.filing.get(inst)
            if cur is None or cur[0] != n: continue
            tried.add(inst)
            self.try_row(*inst)

    def scoped_code(self, gs):
        c, m = 0, 1
        for gi in self.f.scoped:
            c += self.gval(gs, gi) * m; m *= len(self.f.gvals[gi])
        return c

    def gval(self, gs, gi): return (gs // self.f.gmult[gi]) % len(self.f.gvals[gi])

    def gset(self, gs, gi, v): return gs + (v - self.gval(gs, gi)) * self.f.gmult[gi]

    def park(self, gs):
        for gi in self.f.scoped: gs = self.gset(gs, gi, len(self.f.gvals[gi]) - 1)
        return gs

    def unpark(self, gs, code):
        for gi in self.f.scoped:
            n = len(self.f.gvals[gi])
            gs = self.gset(gs, gi, code % n); code //= n
        return gs

    def ok(self, first, count):
        if first < 0: return True
        f = self.f
        for a in range(first, first + count):
            good = True
            for k in range(f.alt_first[a], f.alt_first[a] + f.alt_count[a]):
                if self.have.get(f.req_ix[k], 0) < f.req_c[k]: good = False; break
            if good: return True
        return False

    def go(self, e, gs):
        node = (e, gs)
        if node in self.seen: return
        self.seen.add(node); self.room_in.add(self.f.entries[e][0]); self.queue.append(node)

    def expand(self, node):
        f = self.f
        e, gs = node
        ri = f.entries[e][0]
        for gi, v in f.room_resets[ri]: gs = self.gset(gs, gi, v)
        stc, m = 0, 1
        for gi in f.room_carried[ri]:
            stc += self.gval(gs, gi) * m; m *= len(f.gvals[gi])
        first, cnt = f.entry_ways[e]
        for wy in range(first, first + cnt):
            if f.way_st[wy] != stc: continue
            rf, rc = f.way_rows[wy]
            for q in range(rf, rf + rc): self.try_row(e, gs, q)

    def dest(self, x, gs):
        f = self.f
        d = f.exit_end[x]
        if d >= 0 and self.part[d] >= 0: return f.ends[self.part[d]]["back"]
        if f.exit_sg[x] >= 0: return f.exit_sdest[x][self.gval(gs, f.exit_sg[x])]
        return f.exit_dest[x]

    def try_row(self, e, gs, q):
        f = self.f
        inst = (e, gs, q)
        if inst in self.done: return
        ri = f.entries[e][0]
        kind, t = f.row_kind[q], f.row_target[q]
        af, ac = f.row_alts[q]
        if kind == 1:
            g2 = gs
            m = 1
            leave = f.row_leave[q]
            for gi in f.room_carried[ri]:
                n = len(f.gvals[gi]); g2 = self.gset(g2, gi, leave % n); leave //= n
            to = self.dest(t, g2)
            if to < 0: return
            tr = f.entries[to][0]
            # (a boss's room come into, or its via exit: the fight of the boss fought there)
            bf, bc = -1, 0
            if tr != ri:
                s = f.room_slot[tr]
                bf, bc = f.boss_req[self.fight[s]] if s >= 0 else f.room_boss[tr]
            s = f.exit_slot[t]
            xf, xc = f.boss_req[self.fight[s]] if s >= 0 else f.exit_extra[t]
            l1, l2, l3 = self.lacks(af, ac), self.lacks(bf, bc), self.lacks(xf, xc)
            parts = [l for l in (l1, l2, l3) if l is not None]
            if parts:
                self.block(inst, [x for l in parts for x in l], len(parts) == 1); return
            self.passed(inst)
            # (the Forest Palace's crystals: left with, parked; gone back into, each value they were left with)
            a_in, b_in = f.room_scope[ri], f.room_scope[tr]
            if a_in and not b_in:
                c = self.scoped_code(g2)
                if c not in self.parked:
                    self.parked.add(c)
                    for to2, g3 in self.cross: self.go(to2, self.unpark(g3, c))
                self.go(to, self.park(g2))
            elif b_in and not a_in:
                self.cross.append((to, g2))
                for c in sorted(self.parked): self.go(to, self.unpark(g2, c))
            else: self.go(to, g2)
            return
        l1 = self.lacks(af, ac)
        if l1 is not None: self.block(inst, l1, True); return
        self.passed(inst)
        if kind == 2:
            if t >= 0: self.places.add(t)
        else:
            k = f.EV_BASE + t
            if self.have.get(k, 0) < 1: self.have[k] = 1; self.ev_new.append(k)

    def run(self):
        """goes on from what's queued; then the events that now happen (and the spots got to), each letting the rows that
        waited for it try again, till nothing new happens"""
        f = self.f
        while True:
            while self.queue: self.expand(self.queue.popleft())
            for v, ways in enumerate(f.ev_ways):
                k = f.EV_BASE + v
                if self.have.get(k, 0) >= 1 or not ways: continue
                for kind, what, (af, ac) in ways:
                    hit = (what in self.room_in) if kind == 1 else any(f.room_area[ri] == what for ri in self.room_in)
                    if hit and self.ok(af, ac): self.have[k] = 1; self.ev_new.append(k); break
            if not self.ev_new: break
            todo, self.ev_new = self.ev_new, []
            for k in todo: self.retry_ix(k)

    def add(self, ix, n=1):
        self.have[ix] = self.have.get(ix, 0) + n
        self.retry_ix(ix); self.run()


# ---------------------------------------------------------------- making a shuffle (the mod's rndERShuffle)
# (each random number as the mod draws it: random(x) is rng.random()*x, irandom(n) int(rng.random()*(n+1)); a seed
# here makes the same shuffle and placement as the mod's scripts run on the same numbers)
def fy(lst, rng):
    """a list put in a random order, as the mod does it"""
    for i in range(len(lst) - 1, 0, -1):
        j = int(rng.random() * (i + 1))
        lst[i], lst[j] = lst[j], lst[i]


def grow(f, nodes, seen, part, inpool, frontier, places, stamp_new=None):
    """with everything, on from entries (seen: entries reached); a free end of the mode's pool whose exit it gets to goes
    in frontier, the places it gets to in places; through a paired end, on to its partner's way back in. stamp_new: a
    list the entries it adds go in too"""
    stack = list(nodes)
    while stack:
        e = stack.pop()
        for p in f.ev_locs[e]: places.add(p)
        for x in f.ev_outs[e]:
            d = f.exit_end[x]
            if d >= 0 and inpool[d]:
                if part[d] >= 0: nxt = [f.ends[part[d]]["back"]]
                else: frontier.add(d); continue
            else:
                nxt = [f.exit_dest[x]] if f.exit_sg[x] < 0 else list(f.exit_sdest[x])
            for v in nxt:
                if v >= 0 and v not in seen:
                    seen.add(v); stack.append(v)
                    if stamp_new is not None: stamp_new.append(v)


def shuffle(f, mode_bit, rng):
    """er.py's shuffle over the tables (the mod's rndERShuffle): part[end] = its new partner (-1: the game's own, an end
    not in the mode's pool), or None. The pool's ends in one random order; each step the first one in it whose way back
    in isn't reached and leads somewhere new (a room not reached, or entries, free ends or places that aren't) is joined
    to a free end whose exit is reached, chosen at random"""
    n = len(f.ends)
    inpool = [1 if f.ends[d]["mode"] & mode_bit else 0 for d in range(n)]
    ends = [d for d in range(n) if inpool[d]]
    fy(ends, rng)
    part = [-1] * n
    seen, frontier, places = {f.start}, set(), set()
    room_seen = set()
    def mark_new(lst):
        for e in lst: room_seen.add(f.entries[e][0])
    new0 = [f.start]
    grow(f, [f.start], seen, part, inpool, frontier, places, new0)
    mark_new(new0)
    covered = [0] * n
    def local(d):
        """an end's way back in: whether what it gets to has new entries, free ends of the pool, or places"""
        b = f.ends[d]["back"]
        vis = {b}
        stack = [b]
        new_e = new_f = new_p = 0
        while stack:
            e = stack.pop()
            for p in f.ev_locs[e]:
                if p not in places: new_p = 1
            for x in f.ev_outs[e]:
                dd = f.exit_end[x]
                if dd >= 0 and inpool[dd]:
                    if dd == d: continue
                    if part[dd] >= 0: nxt = [f.ends[part[dd]]["back"]]
                    else:
                        if dd not in frontier: new_f = 1
                        continue
                else:
                    nxt = [f.exit_dest[x]] if f.exit_sg[x] < 0 else list(f.exit_sdest[x])
                for v in nxt:
                    if v < 0 or v in vis or v in seen: continue
                    vis.add(v); stack.append(v); new_e = 1
        return new_e, new_f, new_p
    while True:
        frl = sorted(d for d in frontier if part[d] == -1)
        u, needy = None, []
        for d in ends:
            if part[d] != -1 or covered[d] or f.ends[d]["back"] in seen: continue
            ne, nf, npl = local(d)
            if f.entries[f.ends[d]["back"]][0] in room_seen and not (ne or nf or npl):
                covered[d] = 1; continue
            needy.append(d)
            # (joined to an end to go on from, not itself; with only one of those left, one that leads on to free ends,
            # so the joining doesn't stop at a dead end with others still to join)
            if frl and frl != [d] and (len(frl) > 1 or nf): u = d; break
        if u is None:
            if not needy: break
            if len(needy) == 1 and frl and frl != needy: u = needy[0]
            else: return None
        fr2 = sorted(d for d in frl if d != u)
        fsel = fr2[int(rng.random() * len(fr2))]
        part[fsel] = u; part[u] = fsel
        frontier.discard(fsel); frontier.discard(u)
        new = [b for b in (f.ends[u]["back"], f.ends[fsel]["back"]) if b not in seen]
        for b in new: seen.add(b)
        added = list(new)
        grow(f, new, seen, part, inpool, frontier, places, added)
        mark_new(added)
    rest = [d for d in ends if part[d] == -1]
    fy(rest, rng)
    for k in range(0, len(rest) - 1, 2): part[rest[k]] = rest[k + 1]; part[rest[k + 1]] = rest[k]
    return part


# ---------------------------------------------------------------- Boss Rando (the mod's rndBRShuffle)
def br_shuffle(f, rng):
    """the bosses shuffled: fight[boss] = the boss fought at its places (the final boss: its own)"""
    sh = [i for i in range(f.boss_n) if f.boss_shuf[i]]
    order = list(sh)
    fy(order, rng)
    fight = list(range(f.boss_n))
    for s, b in zip(sh, order): fight[s] = b
    return fight


# ---------------------------------------------------------------- the items (the mod's rndGenerate)
def fill(f, part, rows, items, rng, weapons=False, newest=0.7, fight=None):
    """the progression items placed as the mod's rndGenerate does with the room logic's reach (Entrance Rando, Boss
    Rando: each step as it is there, the reach worked out with the doors and the bosses): [(layer, location, item)] or
    None"""
    import rndgen
    N = len(rows)
    nreq = rndgen.KEY_BASE + 64
    prog = [i for i, it in enumerate(items) if rndgen.prog_of(it) > 0]
    pix = [rndgen.prog_of(items[i]) for i in prog]
    done = [0] * len(prog)
    reach = Reach(f, part, {}, fight)
    layer = [-1] * N
    fill_ = [-1] * N
    layw = set()
    every = [False]
    def mark(lay):
        new = 0
        for i in range(N):
            if layer[i] < 0:
                ok = every[0] if rows[i]["req"] is rndgen.EVERYTHING else (i in reach.places)
                if ok: layer[i] = lay; new += 1
        return new
    mark(0)
    cur = 0
    for placed in range(len(prog)):
        useful = [reach.single[ix] for ix in range(nreq)]
        pool_ = [1 - d for d in done]
        force = False
        if weapons and cur not in layw:
            free_n = sum(1 for i in range(N) if layer[i] == cur and fill_[i] < 0)
            wpn_n = sum(1 for k in range(len(prog)) if done[k] == 0 and pix[k] in rndgen.WEAPONS)
            if free_n > 0 and wpn_n > 0:
                force = True
                for k in range(len(prog)):
                    if pix[k] not in rndgen.WEAPONS: pool_[k] = 0
        cand = [k for k in range(len(prog)) if pool_[k] == 1 and useful[pix[k]] > 0]
        if cand:
            seen, w = set(), 0.0
            for k in cand:
                if pix[k] not in seen: seen.add(pix[k]); w += 1 / useful[pix[k]]
            r = rng.random() * w
            kind = pix[cand[-1]]
            seen = set()
            for k in cand:
                if pix[k] not in seen:
                    seen.add(pix[k])
                    r -= 1 / useful[pix[k]]
                    if r <= 0: kind = pix[k]; break
            cand = [k for k in cand if pix[k] == kind]
        else:
            cand = [k for k in range(len(prog)) if pool_[k] == 1]
        k = cand[int(rng.random() * len(cand))]
        if force: pick = cur
        else:
            pick, last = -1, -1
            for lay in range(cur, -1, -1):
                if any(layer[i] == lay and fill_[i] < 0 for i in range(N)):
                    last = lay
                    if rng.random() < newest: pick = lay; break
            if pick < 0: pick = last
            if pick < 0: return None
        free = [i for i in range(N) if layer[i] == pick and fill_[i] < 0]
        loc = free[int(rng.random() * len(free))]
        fill_[loc] = prog[k]
        done[k] = 1
        reach.add(pix[k])
        if pix[k] in rndgen.WEAPONS: layw.add(pick)
        if placed == len(prog) - 1: every[0] = True
        if mark(cur + 1) > 0: cur += 1
    return [(layer[i], i, fill_[i]) for i in range(N) if fill_[i] >= 0]


def everything_ok(f, part, hv, base_places, fight=None):
    """with everything, the shuffle reaches every place the game's own doors do, and the goal"""
    r = Reach(f, part, dict(hv), fight)
    return base_places <= r.places and all(r.have.get(f.EV_BASE + v, 0) for v in f.goal_ev) and all(ri in r.room_in for ri in f.goal_rooms)


def playthrough(f, part, placed, rows, items, fight=None):
    """from nothing, take every progression item reachable, over and over: all of them got"""
    import rndgen
    at = {loc: items[k] for lay, loc, k in placed}
    r = Reach(f, part, {}, fight)
    got = set()
    while True:
        new = [loc for loc in at if loc not in got and loc in r.places]
        if not new: break
        for loc in new:
            got.add(loc)
            r.add(rndgen.prog_of(at[loc]))
    return len(got) == len(at)


# ---------------------------------------------------------------- the mod's data file (data\rndER.txt, rndERLoad reads it)
def xy_of(s):
    """an exit's or entry's id "x,y" as numbers (an id that isn't one: -99999, which no exit in a room is at)"""
    try:
        a, b = s.split(",")
        return int(a), int(b)
    except ValueError:
        return -99999, -99999


def write_data(f, path, base_places, room_label, hv):
    """the tables, one number (or name) a line, in the order rndERLoad reads them (hv: everything, {number: count}).
    Returns the data's hash (a save made with a shuffle keeps it, so a mod built with other doors can tell)"""
    import hashlib
    L = []
    def put(*vals): L.extend(str(v) for v in vals)
    h = hashlib.md5()
    for d, e in enumerate(f.ends):
        x = f.exits[e["exit"]]
        h.update(("%s|%s|%s|%d;" % (f.rnames[x[0]], x[1], f.entries[e["back"]][1], e["mode"])).encode())
    digest = h.hexdigest()[:12]
    L.append("RNDER"); put(1); L.append(digest)
    put(len(f.gnames))
    for gi in range(len(f.gnames)): put(len(f.gvals[gi]), f.gmult[gi], 1 if gi in f.scoped else 0)
    put(f.start_gs, f.gs_n, f.KEY_BASE, f.EV_BASE)
    put(len(f.rnames))
    for ri, n in enumerate(f.rnames):
        L.append(n); L.append(room_label.get(n, n))
        put(f.room_area[ri], f.room_scope[ri], len(f.room_carried[ri]), *f.room_carried[ri])
        put(len(f.room_resets[ri]))
        for gi, v in f.room_resets[ri]: put(gi, v)
        put(*f.room_boss[ri])
    put(len(f.entries))
    for e, (ri, inid) in enumerate(f.entries):
        x, y = xy_of(inid)
        put(ri, x, y, *f.entry_ways[e])
    put(len(f.way_st))
    for wy in range(len(f.way_st)): put(f.way_st[wy], *f.way_rows[wy])
    put(len(f.row_kind))
    for q in range(len(f.row_kind)): put(f.row_kind[q], f.row_target[q], f.row_leave[q], *f.row_alts[q])
    put(len(f.alt_first))
    for a in range(len(f.alt_first)): put(f.alt_first[a], f.alt_count[a])
    put(len(f.req_ix))
    for k in range(len(f.req_ix)): put(f.req_ix[k], f.req_c[k])
    put(len(f.exits))
    for xi, (ri, o) in enumerate(f.exits):
        x, y = xy_of(o)
        put(ri, x, y, f.exit_dest[xi], f.exit_sg[xi], len(f.exit_sdest[xi]), *f.exit_sdest[xi])
        put(*f.exit_extra[xi]); put(f.exit_end[xi])
    put(len(f.ev_ways))
    for v, ways in enumerate(f.ev_ways):
        put(len(ways))
        for kind, what, (af, ac) in ways: put(kind, what, af, ac)
    put(len(f.goal_ev), *f.goal_ev); put(len(f.goal_rooms), *f.goal_rooms)
    put(len(f.ends))
    for e in f.ends: put(e["exit"], e["back"], e["mode"], e["pair"])
    put(f.start)
    put(f.loc_n)
    for i in range(f.loc_n): put(1 if i in base_places else 0)
    put(len(hv))
    for ix, n in sorted(hv.items()): put(ix, n)
    for e in range(len(f.entries)):
        put(len(f.ev_outs[e]), *f.ev_outs[e]); put(len(f.ev_locs[e]), *f.ev_locs[e])
    # Boss Rando: each boss's fight's needs and whether it's shuffled; each room's and exit's boss (-1: none)
    put(f.boss_n)
    for i in range(f.boss_n): put(f.boss_req[i][0], f.boss_req[i][1], f.boss_shuf[i])
    for ri in range(len(f.rnames)): put(f.room_slot[ri])
    for xi in range(len(f.exits)): put(f.exit_slot[xi])
    L.append("END")
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="ascii", newline="\r\n") as fh: fh.write("\n".join(L) + "\n")
    return digest


def build_data(rows, path, bosses=()):
    """everything rndgen needs for the mod: the tables written to path (data\\rndER.txt); returns (Flat, World, the
    ends' doors, the hash, the base places, everything's numbers). bosses: rndgen.boss_slots"""
    import rndgen
    w = er.World()
    have = er.all_items()
    allk = sorted({k for r in w.rooms.values() for alts in r.table.values() for a in alts for k in a.k})
    base = er.reach_with(w, {}, {}, have, allk)
    pairs = er.doors(w.rooms, w.conn, set(base.rooms_in))
    f = export(w, pairs, rows, bosses)
    hv = {rndgen.LOGIC_NAMES[it]: n for it, n in have.items()}
    for k in allk: hv[rndgen.KEY_BASE + k] = 1
    bp = Reach(f, [-1] * len(f.ends), dict(hv)).places
    label = {n: w.rooms[n].area.split(" (area")[0] for n in w.rooms}
    digest = write_data(f, path, bp, label, hv)
    return f, w, pairs, digest, bp, hv


# ---------------------------------------------------------------- the check: the flat tables against er.py's own engine
def main():
    import rndgen
    w = er.World()
    have = er.all_items()
    allk = sorted({k for r in w.rooms.values() for alts in r.table.values() for a in alts for k in a.k})
    base = er.reach_with(w, {}, {}, have, allk)
    pairs = er.doors(w.rooms, w.conn, set(base.rooms_in))
    rows, items = rndgen.locations_items()[8:10]
    f = export(w, pairs, rows, rndgen.boss_slots(rndgen.boss_list()))
    print("tables: %d rooms, %d entries, %d ways, %d rows, %d alternatives, %d requirements, %d exits, %d events, %d ends; gs %d"
          % (len(f.rnames), len(f.entries), len(f.way_st), len(f.row_kind), len(f.alt_first), len(f.req_ix), len(f.exits),
             len(f.ev_ways), len(f.ends), f.gs_n))
    # everything, the game's own doors: the same places as er.py's
    hv = {}
    for it, n in have.items(): hv[rndgen.LOGIC_NAMES[it]] = n
    for k in allk: hv[rndgen.KEY_BASE + k] = 1
    part = [-1] * len(f.ends)
    r = Reach(f, part, dict(hv))
    loc_index = {(row["type"], row["num"]): i for i, row in enumerate(rows)}
    mine = {i for i in r.places}
    theirs = {loc_index[p] for p in base.places if p in loc_index}
    print("everything, the game's doors: %d places (er.py: %d), %s" % (len(mine), len(theirs), "the same" if mine == theirs else "DIFFERENT: %s" % sorted(mine ^ theirs)[:10]))
    # each mode: a few shuffles of er.py's, the same reach with everything
    for m in er.MODES:
        pl = er.pool(pairs, m)
        ways = er.Ways(w, pl)
        ends = {(e.room, e.out): e for p in pairs for e in p}
        rng = random.Random(3)
        same, tried = 0, 0
        while tried < 5:
            sh = er.shuffle(pl, rng, ways, (w.conn.start[0], w.conn.start[1]))
            if sh is None: continue
            tried += 1
            r1 = er.reach_with(w, sh, ends, have, allk)
            part = [-1] * len(f.ends)
            for a, b in sh.items(): part[a.i] = b.i
            r2 = Reach(f, part, dict(hv))
            p1 = {loc_index[p] for p in r1.places if p in loc_index}
            same += (p1 == r2.places)
        print("%-10s 5 shuffles: the flat reach the same as er.py's in %d" % (m, same))
    # each mode: seeds made the flat way, each checked by a playthrough
    import time
    base_places = set(mine)
    for m in er.MODES:
        rng = random.Random(11)
        t0 = time.time()
        tries, made, why = 0, 0, collections.Counter()
        while made < 10:
            tries += 1
            part = shuffle(f, MODE_BITS[m], rng)
            if part is None: why["shuffle stuck"] += 1; continue
            if not everything_ok(f, part, hv, base_places): why["not all reached"] += 1; continue
            placed = fill(f, part, rows, items, rng)
            if placed is None: why["items stuck"] += 1; continue
            if not playthrough(f, part, placed, rows, items): raise SystemExit("%s: a made seed can't be played through" % m)
            made += 1
        print("%-10s 10 seeds made the flat way in %d tries (%s), each played through (%.1fs)" % (
            m, tries, ", ".join("%s %d" % kv for kv in sorted(why.items())) or "none failed", time.time() - t0))
    # Boss Rando, the game's own doors: seeds made, each played through
    rng = random.Random(13)
    t0 = time.time()
    tries, made = 0, 0
    while made < 10:
        tries += 1
        fight = br_shuffle(f, rng)
        placed = fill(f, [-1] * len(f.ends), rows, items, rng, fight=fight)
        if placed is None: continue
        if not playthrough(f, [-1] * len(f.ends), placed, rows, items, fight): raise SystemExit("Boss Rando: a made seed can't be played through")
        made += 1
    print("Boss Rando: %d bosses shuffled; 10 seeds made in %d tries, each played through (%.1fs)" % (sum(f.boss_shuf), tries, time.time() - t0))


if __name__ == "__main__":
    main()
