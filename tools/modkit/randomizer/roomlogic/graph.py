"""
graph.py: the Randomizer's logic for the whole game as one directed graph, with permanent numbers for its ways in,
ways out and doors. It's made from what solve.py joins: the rooms' logic (rooms\\<room>.txt: RoomLogic.cs's moves inside
each room, from each way in on its own), connections.txt, overrides.txt, events.txt and bosses.txt. The old pipeline
(solve.py's roomlogic.txt, and erflat.py's tables for the mod, the trackers and the Archipelago world) still makes the
build: this is made beside it, and checked against it.

  graph.txt       the graph. Its nodes: each room's ways in (each with the states the room carries, "[rb 1]"), ways
                  out, places and spots; the events; the boss fights. Its edges, each one way and each with what it
                  takes: a way in to a way out, place or spot of its room (the room logic's moves, or a line of
                  overrides.txt: each edge says which, and what the room logic had where a line changed it); a way out
                  to the way in it leads to (connections.txt; with what going through takes on top: the fight going into
                  a boss's room, bosses.txt, and overrides.txt's require lines); a room or an area got into to an event
                  (events.txt). A way back is an edge of its own, from its own moves, or none (a drop, a one-way door)
  ids.txt         the ways in's, ways out's and doors' permanent numbers: kept from build to build, a new one numbered
                  after all the others, one gone kept and never numbered again. Numbered at first as the build's lists
                  were (erflat.py's entries, exits and ends: what a save's visit marks and door shuffle go by), so a
                  number is its place in them; a door's ends are 2n and 2n+1, in the order its line has them
  directions.txt  each room's doors two by two, each way on its own: where overrides.txt has a way otherwise than the
                  room logic (a playtest's correction: the simulation to look at), and the ways that go one way only
                  (normal: a drop, a one-way door, a room that only goes on)

It checks that solving graph.txt alone (solve.py's joining, nothing else read) gets what roomlogic.txt has, place by
place and room by room; and whether the build's lists still keep the numbers' order, which a save's marks and door
shuffle go by (one that doesn't needs rndgen.py's VISIT_LEGACY, erflat.py's ER_LEGACY or er.py's LATE_DOORS).

usage: python graph.py            make graph.txt, ids.txt and directions.txt, and check (roomlogic.py runs it)
       python graph.py --check    solve graph.txt alone and compare with roomlogic.txt
"""
import os, sys, copy, collections, itertools
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
sys.path.insert(0, os.path.dirname(HERE))
import solve

GRAPH = os.path.join(HERE, "graph.txt")
IDS = os.path.join(HERE, "ids.txt")
DIRECTIONS = os.path.join(HERE, "directions.txt")
WORK = os.path.join(HERE, "work")


# ---------------------------------------------------------------- where each edge comes from
def lines_of(path, first_word=None):
    """a file's lines with their numbers, comments and blank lines left out: [(line, text)]"""
    out = []
    if not os.path.exists(path): return out
    for ln, raw in enumerate(open(path, encoding="utf-8"), 1):
        line = raw.split("#", 1)[0].strip()
        if line: out.append((ln, line))
    return out


# ---------------------------------------------------------------- permanent numbers
KINDS = ("in", "out", "door")


def old_lists():
    """this build's lists as the old pipeline numbers them (erflat.export: what a save goes by): the ways in ((room,
    in)), the ways out ((room, out)), and the doors (er.py's: each its two ends' exits, in the ends' order)"""
    import er, erflat, rndgen
    rows = rndgen.locations_items()[8]
    w = er.World(checks=len(rows))
    base = er.reach_with(w, {}, {}, er.all_items(), er.all_keys(w))
    pairs = er.doors(w.rooms, w.conn, set(base.rooms_in))
    fol = er.follows(pairs, w.rooms, w.conn, set(base.rooms_in))
    f = erflat.export(w, pairs, rows, rndgen.boss_slots(rndgen.boss_list()), fol)
    ins = [(f.rnames[ri], i) for ri, i in f.entries]
    outs = [(f.rnames[ri], o) for ri, o in f.exits]
    doors = [(outs[f.ends[k]["exit"]], outs[f.ends[k + 1]["exit"]]) for k in range(0, len(f.ends), 2)]
    return ins, outs, doors


def load_ids(path=IDS):
    """ids.txt: {kind: {key: [number, gone]}} (a door's key: its two ends' exits as a frozenset, and [number, gone,
    (exit, exit)] in its line's order), or None if there's no file"""
    if not os.path.exists(path): return None
    ids = {k: collections.OrderedDict() for k in KINDS}
    for ln, line in lines_of(path):
        f = line.split()
        gone = f[-1] == "gone"
        if gone: f = f[:-1]
        kind, n = f[0], int(f[1])
        if kind in ("in", "out") and len(f) == 4: ids[kind][(f[2], f[3])] = [n, gone]
        elif kind == "door" and len(f) == 6:
            ends = ((f[2], f[3]), (f[4], f[5]))
            ids[kind][frozenset(ends)] = [n, gone, ends]
        else: raise SystemExit("ids.txt line %d: %r" % (ln, line))
    for kind in KINDS:
        nums = [v[0] for v in ids[kind].values()]
        if len(set(nums)) != len(nums): raise SystemExit("ids.txt: a %s number twice" % kind)
    return ids


def update_ids(ids, ins, outs, doors):
    """numbers for this build's ways in, ways out and doors (ids from load_ids, or None: numbered as this build's lists
    are): the ones ids.txt has keep theirs (one it had as gone is back), a new one gets the next number; the ones it has
    that this build hasn't are gone. Returns (ids, [(what happened, kind, key)])"""
    changes = []
    if ids is None:
        ids = {k: collections.OrderedDict() for k in KINDS}
        changes.append(("numbered", "all", "as this build's lists"))
    for kind, cur in (("in", ins), ("out", outs), ("door", doors)):
        reg = ids[kind]
        nxt = max([v[0] for v in reg.values()], default=-1) + 1
        here = set()
        for key in cur:
            k = frozenset(key) if kind == "door" else key
            here.add(k)
            if k in reg:
                if reg[k][1]: reg[k][1] = False; changes.append(("back", kind, key))
            else:
                reg[k] = [nxt, False] + ([key] if kind == "door" else []); nxt += 1
                if changes[:1] != [("numbered", "all", "as this build's lists")]: changes.append(("new", kind, key))
        for k, v in reg.items():
            if not v[1] and k not in here:
                v[1] = True; changes.append(("gone", kind, v[2] if kind == "door" else k))
    return ids, changes


def write_ids(ids, path=IDS):
    L = ["# ids.txt: the Randomizer logic's permanent numbers, kept by graph.py: each way into a room, each way out of one",
         "# and each Entrance Rando door (its two ends, each by its exit: an end's way back in is where the other end's exit",
         "# leads). A new one is numbered after all the others; one that's gone stays, marked gone, and its number is never",
         "# given again. They were numbered at first as the build's lists were (erflat.py's entries, exits and ends, b124:",
         "# what a save's visit marks and door shuffle go by), so a number is its place in them; a door's ends are 2n and",
         "# 2n+1, in its line's order. Don't edit it by hand",
         "#   in <number> <room> <x,y>          out <number> <room> <exit>          door <number> <room> <exit> <room> <exit>"]
    for kind in KINDS:
        L.append("")
        for k, v in sorted(ids[kind].items(), key=lambda kv: kv[1][0]):
            key = v[2] if kind == "door" else k
            txt = " ".join(" ".join(e) for e in key) if kind == "door" else " ".join(key)
            L.append("%s %d %s%s" % (kind, v[0], txt, " gone" if v[1] else ""))
    with open(path, "w", encoding="utf-8", newline="\n") as fh: fh.write("\n".join(L) + "\n")


def order_report(ids, ins, outs, doors):
    """whether the build's lists keep the numbers' order (a save's marks and shuffle go by places in them): the problems"""
    out = []
    for kind, cur, what in (("in", ins, "the ways into rooms' list (a save's visit marks: rndgen.py's VISIT_LEGACY)"),
                            ("out", outs, "the exits' list (a save's exit marks: rndgen.py's VISIT_LEGACY)"),
                            ("door", doors, "the doors' ends (a save's door shuffle: er.py's LATE_DOORS, erflat.py's ER_LEGACY)")):
        nums = [ids[kind][frozenset(k) if kind == "door" else k][0] for k in cur]
        if nums != list(range(len(nums))):
            bad = next(i for i, n in enumerate(nums) if n != i)
            out.append("%s isn't in the numbers' order from its place %d (%s)" % (what, bad, cur[bad]))
    return out


# ---------------------------------------------------------------- the graph
def node_way(n, st):
    return "in %d%s" % (n, solve.state_text(st))


def build(write=True):
    """makes graph.txt, ids.txt and directions.txt from the room logic's files; returns what it found to tell"""
    raw_rooms = solve.load_rooms()
    rooms = copy.deepcopy(raw_rooms)
    conn = solve.load_connections()
    # (what each overrides.txt line changes, as solve.py applies them: each edge's source)
    rows_prov, exits_prov = collections.defaultdict(list), collections.defaultdict(list)
    solve.load_overrides(rooms, conn, touched=(rows_prov, exits_prov))
    ins, outs, doors = old_lists()
    ids, changes = update_ids(load_ids(), ins, outs, doors)
    problems = order_report(ids, ins, outs, doors)
    num_in = {k: v[0] for k, v in ids["in"].items()}
    num_out = {k: v[0] for k, v in ids["out"].items()}
    for r in rooms.values():
        for i in r.ins:
            if (r.name, i) not in num_in: raise SystemExit("graph: %s's way in %s has no number" % (r.name, i))
        for o in r.outs:
            if (r.name, o) not in num_out: raise SystemExit("graph: %s's way out %s has no number" % (r.name, o))
    boss_line = {}
    for ln, line in lines_of(solve.BOSSES):
        hf = line.partition(":")[0].split()
        boss_line[tuple(hf)] = ln
    L = ["# graph.txt: the Randomizer's logic for the whole game as one directed graph, made by graph.py from the rooms' logic",
         "# (rooms\\<room>.txt), connections.txt, overrides.txt, events.txt and bosses.txt: don't edit it (README.txt says how",
         "# to change the logic). Ways in and out by their numbers (ids.txt). An edge is one way, '<from> -> <to> : <what it",
         "# takes>' (alternatives separated by |; - nothing; never: no way), and says where it comes from: the room logic",
         "# (RoomLogic.cs's moves inside the room), a line of overrides.txt (and what the room logic had, where it changed it),",
         "# connections.txt. A way in's state, [rb 1], is the states the room carries as the player comes in; a way out's, as",
         "# they leave. solve.py's joining of this alone gets roomlogic.txt (graph.py checks it)",
         ""]
    st_room, st_in = conn.start
    L.append("start in %d   # %s %s" % (num_in[(st_room, st_in)], st_room, st_in))
    for g, v in conn.carried:
        L.append("carried %s %s%s" % (g, v, " within %s" % conn.scope[g] if g in conn.scope else ""))
    L.append("")
    L.append("# boss fights: going into the room from another (or through the via exit) takes this (bosses.txt; a boss room it")
    L.append("# doesn't name, any attack)")
    for room in sorted(conn.boss):
        L.append("fight %s : %s   # bosses.txt line %d" % (room, solve.alts_text(conn.boss[room]), boss_line.get((room,), 0)))
    for room in sorted(r.name for r in rooms.values() if r.boss and r.name not in conn.boss):
        L.append("fight %s : attack   # a boss room bosses.txt doesn't name" % room)
    for (room, o) in sorted(conn.via):
        need = conn.via_need.get((room, o))
        L.append("fight via %s out %d : %s   # %s" % (room, num_out[(room, o)], solve.alts_text(need if need is not None else solve.ATTACK),
                                                     "bosses.txt line %d" % boss_line.get(("via", room, "out", o), 0) if need is not None else "any attack"))
    L.append("")
    L.append("# events: each happens once the player's got into the room (or a room of the area) with what it takes there (events.txt;")
    L.append("# ir+ only with the new game's option Instrument Randomization, ir- only without it)")
    for ln, line in lines_of(solve.EVENTS):
        mode = ""
        if line.startswith(("ir+ ", "ir- ")): mode, line = line[:3] + " ", line[4:].strip()
        head, _, req = line.partition(":")
        f = head.split()
        L.append("event %s%s %s %s : %s   # events.txt line %d" % (mode, f[0], f[1], f[2], solve.alts_text(solve.parse(req) if req.strip() else [solve.NOTHING]), ln))
    n_edges = collections.Counter()
    for r in rooms.values():
        raw = raw_rooms[r.name]
        L.append("")
        flags = (["boss"] if r.boss else []) + (["map"] if r.map else [])
        flags += ["carries %s" % ",".join(r.carried)] if r.carried else []
        flags += ["resets %s" % ",".join("%s=%s" % gv for gv in sorted(r.resets.items()))] if r.resets else []
        L.append("room %s area %s%s   # %s" % (r.name, r.area_num if r.area_num is not None else "-", "".join(" " + x for x in flags), r.area))
        for i in r.ins: L.append("  in %d %s" % (num_in[(r.name, i)], i))
        for o in r.outs: L.append("  out %d %s" % (num_out[(r.name, o)], o))
        for l in r.locs: L.append("  loc %d %d%s" % (l[0], l[1], "   # " + r.loc_names[l] if l in r.loc_names else ""))
        for sp in r.spots: L.append("  spot %s" % sp)
        for (w, t), alts in r.table.items():
            frm = node_way(num_in[(r.name, w[0])], w[1])
            if t[0] == "out": to = "out %d%s" % (num_out[(r.name, t[1])], solve.state_text(t[2]))
            elif t[0] == "loc": to = "loc %d %d" % (t[1], t[2])
            else: to = "spot %s" % t[1]
            prov = rows_prov.get((r.name, w, t), [])
            had = raw.table.get((w, t))
            if not prov:
                if had is None or solve.alts_text(had) != solve.alts_text(alts):
                    raise SystemExit("graph: %s %s -> %s changed with no overrides.txt line" % (r.name, w, t))
                src = "room"
            else:
                src = "overrides.txt " + ", ".join("%d %s" % p for p in prov)
                if had is None: src += "; not in the room logic"
                elif solve.alts_text(had) != solve.alts_text(alts): src += "; the room logic had: " + solve.alts_text(had)
            L.append("  %s -> %s : %s   # %s" % (frm, to, solve.alts_text(alts), src))
            n_edges["room" if src == "room" else "override"] += 1
        # (its ways out, each to the way in it leads to: what going through takes on top, as solve.through_exit has it)
        for o in r.outs:
            on = num_out[(r.name, o)]
            src = ["connections.txt"] + ["overrides.txt %d %s" % p for p in exits_prov.get((r.name, o), [])]
            if (r.name, o) in conn.via: L.append("  via out %d   # connections.txt: the exit's going through starts a boss fight" % on)
            if (r.name, o) in conn.need: L.append("  need out %d : %s   # %s" % (on, solve.alts_text(conn.need[(r.name, o)]),
                                                                            ", ".join("overrides.txt %d %s" % p for p in exits_prov.get((r.name, o), []) if p[1] == "require")))
            dests = [((), conn.links[(r.name, o)])] if (r.name, o) in conn.links else []
            dests += [(st, to) for st, to in conn.links_st.get((r.name, o), [])]
            for st, to in dests:
                if to[0] not in rooms or to[1] not in rooms[to[0]].ins: continue
                link, extra = solve.through_exit(rooms, conn, r.name, o, st)
                if (to[0], to[1]) not in num_in: raise SystemExit("graph: %s's way in %s has no number" % to)
                fight = "; the fight going into %s" % to[0] if to[0] != r.name and (to[0] in conn.boss or rooms[to[0]].boss) else ""
                L.append("  out %d%s -> in %d : %s   # %s: %s %s%s" % (on, solve.state_text(st), num_in[(to[0], to[1])], solve.alts_text(extra),
                                                                    ", ".join(src), to[0], to[1], fight))
                n_edges["exit"] += 1
    if write:
        with open(GRAPH, "w", encoding="utf-8", newline="\n") as fh: fh.write("\n".join(L) + "\n")
        write_ids(ids)
        write_directions(raw_rooms, rooms, conn, rows_prov, num_in, num_out)
    return {"edges": n_edges, "changes": changes, "problems": problems, "ids": ids}


# ---------------------------------------------------------------- reading it back (the check)
def read_graph(path=GRAPH):
    """graph.txt as solve.py's rooms, connections and events: (rooms, conn, events), for solve.solve_events"""
    rooms = collections.OrderedDict()
    conn = solve.Connections()
    events = collections.OrderedDict()
    lines = lines_of(path)
    # (the numbers first: an exit's edge may lead to a room further down)
    of_in, of_out, cur = {}, {}, None
    for ln, line in lines:
        f = line.split()
        if f[0] == "room": cur = f[1]
        elif f[0] == "in" and len(f) == 3 and cur: of_in[int(f[1])] = (cur, f[2])
        elif f[0] == "out" and len(f) == 3 and cur: of_out[int(f[1])] = (cur, f[2])
    cur = None
    for ln, line in lines:
        where = "graph.txt line %d" % ln
        f = line.split()
        head, _, req = line.partition(" : ")
        if f[0] == "start": conn.start = of_in[int(f[2])]
        elif f[0] == "carried":
            conn.carried.append((f[1], f[2]))
            if len(f) == 5 and f[3] == "within": conn.scope[f[1]] = f[4]
        elif f[0] == "fight":
            hf = head.split()
            if hf[1] == "via":
                rm, o = of_out[int(hf[4])]
                conn.via_need[(rm, o)] = solve.parse(req, where)
            else: conn.boss[hf[1]] = solve.parse(req, where)
        elif f[0] == "event":
            hf = head.split()
            mode = 0
            if hf[1] in ("ir+", "ir-"): mode = 2 if hf[1] == "ir+" else 1; hf = hf[:1] + hf[2:]
            if mode != 2: events.setdefault(hf[1], []).append((hf[2], hf[3], solve.parse(req, where)))
        elif f[0] == "room":
            r = solve.RoomLogic(f[1])
            r.area_num = None if f[3] == "-" else int(f[3])
            for x in f[4:]:
                if x == "boss": r.boss = True
                elif x == "map": r.map = True
            for i, x in enumerate(f):
                if x == "carries": r.carried = f[i + 1].split(",")
                elif x == "resets": r.resets = dict(p.split("=") for p in f[i + 1].split(","))
            rooms[r.name] = r; cur = r
        elif f[0] == "via" and cur: conn.via.add(of_out[int(f[2])])
        elif f[0] == "need" and cur: conn.need[of_out[int(f[2])]] = solve.parse(req, where)
        elif "->" in f and cur:
            left, right = [s.split() for s in head.split(" -> ")]
            if left[0] == "out":
                # (a way out to the way in it leads to: connections.txt's link, or one by a carried state)
                rm, o = of_out[int(left[1])]
                st, _rest = solve.split_state(left[2:])
                to = of_in[int(right[1])]
                if st: conn.links_st.setdefault((rm, o), []).append((st, to))
                else: conn.links[(rm, o)] = to
                continue
            inid = of_in[int(left[1])][1]
            st, _rest = solve.split_state(left[2:])
            if right[0] == "out":
                tst, _r2 = solve.split_state(right[2:])
                target = ("out", of_out[int(right[1])][1], tst)
            elif right[0] == "loc": target = ("loc", int(right[1]), int(right[2]))
            else: target = ("spot", right[1])
            cur.table[((inid, st), target)] = solve.parse(req, where)
        elif cur and f[0] == "in": cur.ins.append(f[2])
        elif cur and f[0] == "out": cur.outs.append(f[2])
        elif cur and f[0] == "loc": cur.locs.append((int(f[1]), int(f[2])))
        elif cur and f[0] == "spot": cur.spots.append(f[1])
        else: raise SystemExit("%s: %r" % (where, line))
    for r in rooms.values(): r.carried.sort()
    return rooms, conn, events


def check(path=GRAPH, against=solve.OUT):
    """solves graph.txt alone and compares it with roomlogic.txt: the lines that differ ([] if none)"""
    rooms, conn, events = read_graph(path)
    res = solve.solve_events(rooms, conn, events=events)
    out = os.path.join(WORK, "graph_check.txt")
    os.makedirs(WORK, exist_ok=True)
    solve.write_result(rooms, res, out)
    a = [l.rstrip("\n") for l in open(against, encoding="utf-8") if not l.startswith("#")]
    b = [l.rstrip("\n") for l in open(out, encoding="utf-8") if not l.startswith("#")]
    if a == b: return []
    sa, sb = set(a), set(b)
    return ["roomlogic.txt: " + l for l in a if l not in sb] + ["graph.txt's: " + l for l in b if l not in sa]


# ---------------------------------------------------------------- each way on its own
def doorways(conn):
    """each room's doors as Entrance Rando pairs a door's two exits (er.py's doors, leaving none out): an exit, and the
    way in beside it (within er.PAIR_DIST) that the room on the other side leads back to: {room: [(out, in, other)]}"""
    import er
    by_pair = collections.defaultdict(list)
    for (ra, oa), (rb, ib) in conn.links.items():
        if ra != rb: by_pair[(ra, rb)].append((oa, ib))
    cands = []
    for (ra, rb), ls in by_pair.items():
        if ra > rb: continue
        for oa, ib in ls:
            for ob, ia in by_pair.get((rb, ra), []):
                p = [er.xy(s) for s in (oa, ia, ob, ib)]
                if None in p: continue
                d1 = abs(p[0][0] - p[1][0]) + abs(p[0][1] - p[1][1])
                d2 = abs(p[2][0] - p[3][0]) + abs(p[2][1] - p[3][1])
                if d1 <= er.PAIR_DIST and d2 <= er.PAIR_DIST: cands.append((d1 + d2, ra, oa, ia, rb, ob, ib))
    used, out = set(), collections.defaultdict(list)
    for d, ra, oa, ia, rb, ob, ib in sorted(cands):
        if (ra, oa) in used or (rb, ob) in used: continue
        used.add((ra, oa)); used.add((rb, ob))
        out[ra].append((oa, ia, rb)); out[rb].append((ob, ib, ra))
    return out


def way_needs(r, inid, out):
    """what getting from a way in to a way out of a room takes, in any state: alternatives"""
    alts = []
    for (w, t), a in r.table.items():
        if w[0] == inid and t[0] == "out" and t[1] == out:
            for x in a: solve.add(alts, x)
    return alts


def write_directions(raw_rooms, rooms, conn, rows_prov, num_in, num_out, path=DIRECTIONS):
    doors = doorways(conn)
    differ, one_way, counts = [], [], collections.Counter()
    for name in sorted(doors):
        r, raw = rooms[name], raw_rooms[name]
        ds = sorted(doors[name])
        for (oa, ia, ra), (ob, ib, rb) in itertools.combinations(ds, 2):
            dirs = []
            for (inid, frm), (out, to) in (((ia, ra), (ob, rb)), ((ib, rb), (oa, ra))):
                fin, had = way_needs(r, inid, out), way_needs(raw, inid, out)
                lines = sorted({p for (rn, w, t), ps in rows_prov.items() if rn == name and w[0] == inid and t[0] == "out" and t[1] == out for p in ps})
                dirs.append((inid, frm, out, to, fin, had, lines))
            for inid, frm, out, to, fin, had, lines in dirs:
                if bool(fin) != bool(had) or (fin and had and solve.alts_text(fin) != solve.alts_text(had)):
                    differ.append((name, inid, frm, out, to, fin, had, lines))
            fa, fb = bool(dirs[0][4]), bool(dirs[1][4])
            counts["both ways" if fa and fb else "one way" if fa or fb else "neither way"] += 1
            if fa != fb:
                d = dirs[0] if fa else dirs[1]
                one_way.append((name, d[0], d[1], d[2], d[3], d[4], dirs[1][4] if fa else dirs[0][4]))
    def door(name, inid=None, out=None, other=None):
        return "%s (to %s)" % ("in %d %s" % (num_in[(name, inid)], inid) if inid is not None else "out %d %s" % (num_out[(name, out)], out), other)
    L = ["# directions.txt: each room's doors two by two (an exit and the way in beside it, as Entrance Rando pairs a door's",
         "# exits), each way on its own, made by graph.py: from a door's way in to the other door's way out. A way back is its",
         "# own simulation (rooms\\<room>.txt, from that way in), never the way there turned round; a way one way only is",
         "# normal (a drop, a one-way door, a room that only goes on)",
         "#   %d pairs of doors: %d both ways, %d one way, %d neither way (each needing what the room doesn't have from there)" % (
             sum(counts.values()), counts["both ways"], counts["one way"], counts["neither way"]),
         "",
         "# where overrides.txt has a way otherwise than the room logic (its lines: a playtest's correction, the room logic's",
         "# simulation to look at; or what it can't see):  <room>: from <way in> to <way out>: <as the logic has it>  (the room",
         "# logic: <its own>; overrides.txt lines)"]
    for name, inid, frm, out, to, fin, had, lines in differ:
        L.append("%s: from %s to %s: %s  (the room logic: %s; overrides.txt %s)" % (
            name, door(name, inid, other=frm), door(name, out=out, other=to), solve.alts_text(fin), solve.alts_text(had),
            ", ".join("%d %s" % p for p in lines) or "-"))
    L += ["", "# one way only (as the logic has it, overrides.txt's lines in):  <room>: from <way in> to <way out>: <what it takes>; back:",
          "# never"]
    for name, inid, frm, out, to, fin, back in one_way:
        L.append("%s: from %s to %s: %s" % (name, door(name, inid, other=frm), door(name, out=out, other=to), solve.alts_text(fin)))
    with open(path, "w", encoding="utf-8", newline="\n") as fh: fh.write("\n".join(L) + "\n")
    return counts, len(differ), len(one_way)


def main():
    if "--check" in sys.argv:
        diffs = check()
        print("graph.txt solved alone: " + ("the same as roomlogic.txt" if not diffs else "%d line(s) differ from roomlogic.txt" % len(diffs)))
        for d in diffs[:20]: print("  " + d)
        if diffs: raise SystemExit(1)
        return
    info = build()
    e = info["edges"]
    print("graph.txt: %d edges in rooms from the room logic, %d from overrides.txt lines, %d ways out to ways in" % (e["room"], e["override"], e["exit"]))
    for what, kind, key in info["changes"]:
        print("ids.txt: %s %s %s" % (what, kind, key))
    for p in info["problems"]: print("ids.txt: " + p)
    diffs = check()
    print("graph.txt solved alone: " + ("the same as roomlogic.txt" if not diffs else "%d line(s) differ from roomlogic.txt" % len(diffs)))
    for d in diffs[:20]: print("  " + d)
    if diffs: raise SystemExit("the graph's check failed: graph.txt doesn't get what roomlogic.txt has")


if __name__ == "__main__":
    main()
