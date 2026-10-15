"""
The Randomizer's room logic for a shuffled layout (the options Entrance Rando, Boss Rando and Instrument Randomization):
what a set of items reaches from the start with the doors and the bosses as shuffled (Reach), and the shuffles (shuffle,
br_shuffle, everything_ok). Copied by tools/modkit/randomizer/rndgen.py from roomlogic/erflat.py, where they're the
mod's own (its rndERReach scripts, rndERShuffle, rndBRShuffle, rndEREverything): change erflat.py, not this. The tables
are erdata.json (load)
"""
import collections

DOOR_CLASSES = ['', 'attack', 'samus:4']


class Flat:
    pass


def load(data):
    """the tables (erdata.json, read) as erflat's Flat"""
    f = Flat()
    for k, v in data.items():
        setattr(f, k, v)
    f.base_places = set(f.base_places)
    f.hv = {ix: n for ix, n in f.hv}
    return f


class Reach:
    """the reach of a set of items with a door shuffle (part: end -> its partner end, -1 for the game's own), from the
    start, worked out as items are added. A row that can't be gone through yet waits under each requirement it lacks
    (wait), and is tried again only when one of them comes (add); single counts the rows one more of a requirement would
    let through (rndGenerate's choice of item). fight: Boss Rando's bosses, the boss fought at each boss's places (None:
    each its own). ir: Instrument Randomization (the events' ways for it)"""
    def __init__(self, f, part, have, fight=None, ir=False):
        self.f = f; self.part = part; self.have = have      # have: {number: count} (items, keys, events)
        self.fight = fight if fight is not None else list(range(f.boss_n))
        self.skip_mode = 1 if ir else 2
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
                for kind, what, (af, ac), mode in ways:
                    if mode == self.skip_mode: continue
                    hit = (what in self.room_in) if kind == 1 else any(f.room_area[ri] == what for ri in self.room_in)
                    if hit and self.ok(af, ac): self.have[k] = 1; self.ev_new.append(k); break
            if not self.ev_new: break
            todo, self.ev_new = self.ev_new, []
            for k in todo: self.retry_ix(k)

    def add(self, ix, n=1):
        self.have[ix] = self.have.get(ix, 0) + n
        self.retry_ix(ix); self.run()


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
    to a free end of its class (DOOR_CLASSES: the Metroid door in front of its exit) whose exit is reached, chosen at
    random"""
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
    cls = [e["cls"] for e in f.ends]
    while True:
        frl = sorted(d for d in frontier if part[d] == -1)
        u, needy = None, []
        for d in ends:
            if part[d] != -1 or covered[d] or f.ends[d]["back"] in seen: continue
            ne, nf, npl = local(d)
            if f.entries[f.ends[d]["back"]][0] in room_seen and not (ne or nf or npl):
                covered[d] = 1; continue
            needy.append(d)
            # (joined to an end to go on from of its class, not itself; with only one end left to go on from, one that
            # leads on to free ends, so the joining doesn't stop at a dead end with others still to join)
            nc = sum(1 for x in frl if x != d and cls[x] == cls[d])
            if nc > 0 and (len(frl) > 1 or nf): u = d; break
        if u is None:
            if not needy: break
            if len(needy) == 1 and any(x != needy[0] and cls[x] == cls[needy[0]] for x in frl): u = needy[0]
            else: return None
        fr2 = [d for d in frl if d != u and cls[d] == cls[u]]
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
    for c in range(len(DOOR_CLASSES)):
        rc = [d for d in rest if cls[d] == c]
        for k in range(0, len(rc) - 1, 2): part[rc[k]] = rc[k + 1]; part[rc[k + 1]] = rc[k]
    return part


def br_shuffle(f, rng):
    """the bosses shuffled: fight[boss] = the boss fought at its places (one left in its place: its own)"""
    sh = [i for i in range(f.boss_n) if f.boss_shuf[i]]
    order = list(sh)
    fy(order, rng)
    fight = list(range(f.boss_n))
    for s, b in zip(sh, order): fight[s] = b
    return fight


def everything_ok(f, part, hv, base_places, fight=None, ir=False):
    """with everything, the shuffle reaches every place the game's own doors do, and the goal"""
    r = Reach(f, part, dict(hv), fight, ir)
    return base_places <= r.places and all(r.have.get(f.EV_BASE + v, 0) for v in f.goal_ev) and all(ri in r.room_in for ri in f.goal_rooms)
