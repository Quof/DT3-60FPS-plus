"""Phase F.8, the seed stress test: many seeds made as the mod makes them (erflat.py's shuffle, br_shuffle, fill, the
same random draws) for each of the build's option sets (rndgen.py's er_check list), each played through. For each seed,
the room logic's rows (one room part: a way in, in a state, to an exit, a place or an event) on the playthrough's way to
each progression item and to the goal are counted; then the rows used most are each taken away in turn from a sample of
the seeds, and the seed played through again: a row whose seed can't be finished without it is one it needed. The rows
ranked by that (and by how often they're used) say which room parts to check in the game first (Phase G).

    python stress.py [seeds per option set, default 200] [rows to test, default 150] [seeds per row test, default 40]

Writes stress.txt."""
import collections, os, random, sys, time

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE); sys.path.insert(0, os.path.dirname(HERE))
import erflat, rndgen

OUT = os.path.join(HERE, "stress.txt")

# (label, Entrance Rando mode bit, Boss Rando, Instrument Randomization, Chip Randomizer, Skip Tower Defense, Guarantee
# Early Weapons, Ability Spread): as rndgen.er_check's seed checks
OPTIONS = [
    ("default options", 0, False, False, False, False, False, 1),
    ("Guarantee Early Weapons", 0, False, False, False, False, True, 1),
    ("Ability Spread Near", 0, False, False, False, False, False, 0),
    ("Ability Spread Far", 0, False, False, False, False, False, 2),
    ("Gate Swap", 1, False, False, False, False, False, 1),
    ("Area", 2, False, False, False, False, False, 1),
    ("Chaos", 4, False, False, False, False, False, 1),
    ("Boss Rando", 0, True, False, False, False, False, 1),
    ("Instrument Randomization", 0, False, True, False, False, False, 1),
    ("Chaos with Boss Rando and Instrument Randomization", 4, True, True, False, False, False, 1),
    ("Chaos with Boss Rando, Ability Spread Far", 4, True, False, False, False, False, 2),
    ("Chip Randomizer", 0, False, False, True, False, False, 1),
    ("Gate Swap with Chip Randomizer", 1, False, False, True, False, False, 1),
    ("Area with Chip Randomizer, Boss Rando and Instrument Randomization", 2, True, True, True, False, False, 1),
    ("Chaos with Skip Tower Defense", 4, False, False, False, True, False, 1),
    ("Boss Rando with Skip Tower Defense", 0, True, False, False, True, False, 1),
]


class TracedReach(erflat.Reach):
    """erflat's reach, remembering how each way in and place was first got to (the row that did it), with some rows
    taken away (banned: never gone through)"""
    def __init__(self, f, part, have, fight=None, ir=False, au_at=None, banned=frozenset()):
        self.banned = banned
        self.parent = {}        # node -> the row instance that first got to it
        self.place_by = {}      # place -> the row instance that first got to it
        self.ev_by = {}         # event number -> the row instance that made it happen
        self.cur = None
        super().__init__(f, part, have, fight, ir, au_at)

    def go(self, e, gs):
        node = (e, gs)
        if node not in self.seen and self.cur is not None: self.parent[node] = self.cur
        super().go(e, gs)

    def try_row(self, e, gs, q):
        if q in self.banned: return
        n_places = len(self.places)
        before, self.cur = self.cur, (e, gs, q)
        super().try_row(e, gs, q)
        self.cur = before
        if len(self.places) > n_places:
            t = self.f.row_target[q]
            if t not in self.place_by: self.place_by[t] = (e, gs, q)


def trace(r, inst):
    """the rows from the start to a row instance (its own among them)"""
    out, seen = [], set()
    while inst is not None and inst not in seen:
        seen.add(inst)
        e, gs, q = inst
        out.append(q)
        inst = r.parent.get((e, gs))
    return out


def play(f, part, placed, rows, items, fight, ir, chips, banned=frozenset()):
    """erflat.playthrough with some rows taken away: (finished, the reach)"""
    at = {loc: items[k] for lay, loc, k in placed}
    r = TracedReach(f, part, erflat.start_have(f, chips), fight, ir, banned=banned)
    got = set()
    while True:
        new = [loc for loc in at if loc not in got and loc in r.places]
        if not new: break
        for loc in new:
            got.add(loc)
            r.add(rndgen.prog_of(at[loc], ir))
    done = len(got) == len(at)
    if done:
        done = all(r.have.get(f.EV_BASE + v, 0) for v in f.goal_ev) and all(ri in r.room_in for ri in f.goal_rooms)
    return done, r


def used_rows(f, r, placed):
    """the rows on the playthrough's way to each progression item's place, and to the goal's rooms"""
    used = set()
    for lay, loc, k in placed:
        if loc in r.place_by: used.update(trace(r, r.place_by[loc]))
    for ri in f.goal_rooms:
        node = next((n for n in r.parent if f.entries[n[0]][0] == ri), None)
        if node: used.update(trace(r, r.parent[node]))
    return used


def row_names(f, rows):
    """each row's text: room, way in, target"""
    of = {}
    for e, (ri, inid) in enumerate(f.entries):
        first, cnt = f.entry_ways[e]
        for wy in range(first, first + cnt):
            rf, rc = f.way_rows[wy]
            for q in range(rf, rf + rc): of.setdefault(q, (ri, inid))
    names = {}
    for q in range(len(f.row_kind)):
        ri, inid = of.get(q, (-1, "?"))
        room = f.rnames[ri] if ri >= 0 else "?"
        kind, t = f.row_kind[q], f.row_target[q]
        if kind == 1: target = "out %s" % f.exits[t][1] if t >= 0 else "out ?"
        elif kind == 2: target = "loc %s %s" % (rows[t]["type"], rows[t]["num"]) if t >= 0 else "spot"
        else: target = "event %d" % t
        names[q] = "%s from %s to %s" % (room, inid, target)
    return names


def make_seed(f, hv, bp, rows, items, opt, rng):
    """a seed made as the mod makes it with these options: (part, fight, placed) or None"""
    label, bit, br, ir, chips, td, wpn, spread = opt
    part = erflat.shuffle(f, bit, rng) if bit else [-1] * len(f.ends)
    if part is None: return None
    fight = erflat.br_shuffle(f, rng) if br else None
    if bit and not erflat.everything_ok(f, part, hv, bp, fight, ir): return None
    placed = erflat.fill(f, part, rows, items, rng, weapons=wpn, newest=rndgen.SPREAD[spread], fight=fight, ir=ir, chips=chips)
    if placed is None: return None
    return part, fight, placed


def main():
    n_seeds = int(sys.argv[1]) if len(sys.argv) > 1 else 200
    n_rows = int(sys.argv[2]) if len(sys.argv) > 2 else 150
    n_test = int(sys.argv[3]) if len(sys.argv) > 3 else 40
    t0 = time.time()
    rows, items = rndgen.locations_items()[8:10]
    f, w, pairs, digest, bp, hv = erflat.build_data(rows, os.path.join(HERE, "work", "stress_rndER.txt"),
                                                    rndgen.boss_slots(rndgen.boss_list()))
    names = row_names(f, rows)
    used_n = collections.Counter()           # row -> seeds whose playthrough used it
    used_by = collections.defaultdict(collections.Counter)    # row -> option set -> seeds
    seeds = []                               # (option index, part, fight, placed)
    report = []
    for oi, opt in enumerate(OPTIONS):
        label, bit, br, ir, chips, td, wpn, spread = opt
        its = rndgen.items_with_chips(items, chips)
        rws = rndgen.skip_td_rows(rows) if td else rows
        made, tries, bad, t1 = 0, 0, 0, time.time()
        while made < n_seeds and tries < n_seeds * 60:
            rng = random.Random(oi * 1000003 + tries)
            tries += 1
            s = make_seed(f, hv, bp, rws, its, opt, rng)
            if s is None: continue
            part, fight, placed = s
            ok, r = play(f, part, placed, rws, its, fight, ir, chips)
            made += 1
            if not ok: bad += 1; continue
            used = used_rows(f, r, placed)
            for q in used: used_n[q] += 1; used_by[q][oi] += 1
            seeds.append((oi, part, fight, placed))
        report.append("%s: %d seeds made in %d tries, %d can't be finished (%.0fs)" % (label, made, tries, bad, time.time() - t1))
        print(report[-1], flush=True)
    # the rows used most, each taken away from a sample of the seeds that used it
    rng = random.Random(7)
    by_opt = collections.defaultdict(list)
    for s in seeds: by_opt[s[0]].append(s)
    tested = []
    for q, n in used_n.most_common(n_rows):
        sample = [s for s in seeds if used_by[q][s[0]]]
        rng.shuffle(sample)
        need = tried = 0
        for oi, part, fight, placed in sample:
            if tried >= n_test: break
            label, bit, br, ir, chips, td, wpn, spread = OPTIONS[oi]
            its = rndgen.items_with_chips(items, chips)
            rws = rndgen.skip_td_rows(rows) if td else rows
            ok0, r0 = play(f, part, placed, rws, its, fight, ir, chips)
            if q not in used_rows(f, r0, placed): continue
            tried += 1
            ok, r = play(f, part, placed, rws, its, fight, ir, chips, banned=frozenset([q]))
            need += not ok
        tested.append((need / tried if tried else 0.0, n, q, need, tried))
    tested.sort(key=lambda x: (-x[0], -x[1]))
    total = len(seeds)
    out = ["# Phase F.8, the seed stress test (stress.py): %d option sets, %d seeds each asked for, %d finished seeds in all "
           "(%.0f minutes)" % (len(OPTIONS), n_seeds, total, (time.time() - t0) / 60),
           "# Every seed made as the mod makes it, played through. A row is one room part: a way in to an exit, a place or",
           "# an event. 'used': the seeds whose playthrough went through it on the way to a progression item or the goal;",
           "# 'needed': of a sample of those seeds, the ones that can't be finished with the row taken away.", ""]
    out += ["# ---- the option sets ----"] + report + [""]
    out.append("# ---- the %d rows used most, by how often a seed needs them (needed / tested, used in / all seeds) ----" % len(tested))
    for frac, n, q, need, tried in tested:
        out.append("%5.1f%% needed (%d/%d), used in %5.1f%%: %s" % (100 * frac, need, tried, 100.0 * n / max(1, total), names[q]))
    out += ["", "# ---- every row any seed used, by how often (%d rows) ----" % len(used_n)]
    for q, n in used_n.most_common():
        out.append("%6.2f%%  %s" % (100.0 * n / max(1, total), names[q]))
    with open(OUT, "w", encoding="utf-8", newline="\n") as fh: fh.write("\n".join(out) + "\n")
    print("stress.txt: %d seeds, %d rows used, %d tested (%.0f minutes)" % (total, len(used_n), len(tested), (time.time() - t0) / 60))


if __name__ == "__main__":
    main()
