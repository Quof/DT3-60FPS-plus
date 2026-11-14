"""
checks.py: the brief's automatic checks of the logic (Phase F), made after solve.py, graph.py and tests.py (roomlogic.py
runs it): checks.txt. Each check lists only what it finds wrong, and its counts.

  1. the story run: every boss fight in the story's order, with the abilities the story had given by then (the Boss
     Gallery's loadout for that fight, oBossGalleryDoor's Other_10: each gate's own kit, kept from gate to gate as
     abilSetRemove(0) keeps them), its room got to in the logic with no more. Keys, Program Chips and the bosses' shares
     (event:pctN) are taken as had: the story always has them by then. A fight the logic wants more for is the logic
     asking more than the story itself gave: too strict there (or the endgame world, which the Randomizer plays in,
     differs from the story's)

usage: python checks.py
"""
import os, re, sys, collections
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import solve

PROJ = os.path.normpath(os.path.join(HERE, "..", "..", "..", ".."))
GALLERY = os.path.join(PROJ, "objects", "oBossGalleryDoor.gml")
CHECKS = os.path.join(HERE, "checks.txt")
IX = {n: i for i, n in enumerate(solve.ITEMS)}
# hasAbilToken's slots: the Mario, Link, Belmont, Mega Man and Samus sets and Gate 6's two; a set's level is its token
# less one (token 2 its first item), no more than the logic counts
TOKEN_SET = ["mario", "link", "belmont", "megaman", "samus", "gamej", "gamec"]
SET_MAX = {"mario": 1, "link": 3, "belmont": 3, "megaman": 4, "samus": 7, "gamej": 2, "gamec": 2}


def gallery_loadouts(path=GALLERY):
    """[(types, name, {item: count})] in the gallery's order: each fight's abilities as oBossGalleryDoor gives them.
    hasShoes[2] the dash, [3] the air dash, canDoubleJump 2 the double jump (characterStepEvent); the Samus set's
    fights have the High Jump Boots and the suits too (its whole kit: the Super High Jump Boots at 2850, the Varia
    Suit's place before the Samus fights' end)"""
    text = open(path, encoding="utf-8", errors="replace").read()
    text = text[text.index("#define Other_10"):]
    out = []
    for m in re.finditer(r"(?:else )?if (type=\d+(?: or type=\d+)*) //([^\n]*)\n\{(.*?)\n\}", text, re.S):
        types = [int(t) for t in re.findall(r"type=(\d+)", m.group(1))]
        body = m.group(3)
        have = collections.Counter()
        if re.search(r"hasShoes\[2\]=2", body): have["gdash"] = 1
        if re.search(r"hasShoes\[3\]=2", body): have["adash"] = 1
        if re.search(r"canDoubleJump=2", body): have["djump"] = 1
        for slot, tok in re.findall(r"hasAbilToken\[(\d)\]=(\d+)", body):
            s = TOKEN_SET[int(slot)]
            have[s] = max(have[s], min(int(tok) - 1, SET_MAX[s]))
        if have["samus"] >= 7: have["hijump"] = 2; have["varia"] = 1
        out.append((types, m.group(2).strip(), have))
    return out


# the gallery's names that bosses.txt spells otherwise
ALIAS = {"blackmoor": "blackmore"}


def norm(s):
    return re.sub(r"[^a-z0-9]", "", s.lower())


def boss_rooms(path=solve.BOSSES):
    """[(normalised boss name, [(room, via exit or None, the line's number)])] from bosses.txt's comments (# N Name: ...),
    in its order (two bosses can share a name: the Vault's Hex and the Warship's); a via line with no name of its own is
    another way the fight on the line before it starts (Ridley's, the Parasitic Seed's)"""
    out = []
    pending = None   # (a "# N Name: ..." comment line before the line it's for)
    for ln, raw in enumerate(open(path, encoding="utf-8"), 1):
        line = raw.split("#", 1)
        if not line[0].strip():
            m = re.match(r"\s*(\d+)\s+([^:(]+)", line[1]) if len(line) > 1 else None
            pending = m if m else (pending if len(line) > 1 else None)
            continue
        m = re.match(r"\s*\d+\s+([^:(]+)", line[1]) if len(line) > 1 else None
        m = m or pending
        pending = None
        f = line[0].split()
        if not m and f[0] == "via" and out:
            out[-1][1].append((f[1], f[3], ln)); continue
        if not m: continue
        if m.re.groups == 2: m = re.match(r"\s*\d+\s+([^:(]+)", m.group(0))
        if f[0] == "via": out.append((norm(m.group(1)), [(f[1], f[3], ln)]))
        else: out.append((norm(m.group(1)), [(f[0], None, ln)]))
    return out


def counts_le(a, have):
    """an alternative needs no more items than have (keys, chips and events aside)"""
    return all(n <= have.get(solve.ITEMS[i], 0) for i, n in enumerate(a.c))


def story_run(rooms, conn, res):
    """the story run's findings: [(text)], and its counts"""
    found, n_ok, n_bad = [], 0, 0
    names = boss_rooms()
    kit = collections.Counter()
    unmatched, used, outside = [], set(), []
    for types, name, have in gallery_loadouts():
        for k, v in have.items(): kit[k] = max(kit[k], v)
        key = norm(re.sub(r"\(.*?\)|\s-\s.*", "", name))
        key = ALIAS.get(key, key)
        # (the names as bosses.txt has them: "Large Vampire Bat", "Advanced Combat Apparatus", "CHAOS Warmaster"; the
        # first not taken yet, in order)
        cand = [i for i, (k, v) in enumerate(names) if i not in used and (k == key or key in k or k in key)]
        if not cand: unmatched.append(name); continue
        i = next((i for i in cand if names[i][0] == key), cand[0])
        used.add(i)
        alts = []
        for room, via, ln in names[i][1]:
            if via:
                # (a via fight: got to the room, then the exit's line)
                alts += solve.room_needs(rooms, res, room)
            else:
                alts += [a for node, al in res.ways_in.items() if node[0] == room for a in al]
        room, via, ln = names[i][1][0]
        if not alts:
            # (a fight whose room the Randomizer's world never gets to, with everything: not one of its fights)
            outside.append(name); continue
        ok = any(counts_le(a, kit) for a in alts)
        if ok: n_ok += 1; continue
        n_bad += 1
        need = solve.alts_text([a for a in alts][:6]) if alts else "never"
        kit_text = ", ".join("%s:%d" % (k, v) if k not in solve.SINGLE else k for k, v in sorted(kit.items()) if v) or "nothing"
        found.append("%s (gallery type %s; bosses.txt line %d, %s): the logic gets there with %s; the story had %s"
                     % (name, "/".join(map(str, types)), ln, room, need, kit_text))
        # (where: on the way the logic needs least beyond the story's, the rooms' parts that need more than it had)
        # (a via fight's room too: its way in is the via room's)
        fight_rooms = {rm for rm, v, l in names[i][1]}
        nodes = [(node, a) for node, al in res.ways_in.items() if node[0] in fight_rooms for a in al]
        if nodes:
            node, a = min(nodes, key=lambda na: sum(max(0, n - kit.get(solve.ITEMS[i], 0)) for i, n in enumerate(na[1].c)))
            for prev, target, part in solve.chain_to(res, node, a):
                # (only a part no way through fits the story's items in: once the route has taken something more, its
                # later parts carry it along)
                own = [x for (w, t), al in rooms[prev[0]].table.items() if w[0] == prev[1] and t == target for x in al]
                if not counts_le(part, kit) and not any(counts_le(x, kit) for x in own):
                    found.append("    %s in %s -> out %s: %s" % (prev[0], solve.node_text(rooms, conn, prev), target[1], part))
    return found, n_ok, n_bad, unmatched, outside


def cost(alts):
    """how much an alternative list takes at least: its cheapest alternative's abilities (a set's level as one: the
    Strike Chain is one thing to have) and keys"""
    return min(sum(1 for x in a.c if x) + len(a.k) for a in alts) if alts else None


def asymmetry(rooms, conn):
    """2. each room's doors two by two (graph.py's pairs, as Entrance Rando pairs them), both ways in logic, where one
    way takes at least ASYM more items than the other (a way back the simulation hasn't seen, or a one-way part
    misread). [(text)], the pairs looked at"""
    import graph
    doors = graph.doorways(conn)
    found, n = [], 0
    for name in sorted(doors):
        r = rooms[name]
        for (oa, ia, ra), (ob, ib, rb) in __import__("itertools").combinations(sorted(doors[name]), 2):
            there, back = graph.way_needs(r, ia, ob), graph.way_needs(r, ib, oa)
            if not there or not back: continue
            n += 1
            ct, cb = cost(there), cost(back)
            if abs(ct - cb) >= ASYM:
                found.append("%s: from %s (the %s door) to %s (the %s door): %s; back: %s" % (
                    name, ia, ra, ob, rb, solve.alts_text(there), solve.alts_text(back)))
    return found, n


# (an asymmetry worth a look: one way takes this many more items than the other)
ASYM = 2


def gate_key(room):
    """the gate a room is in: an Access Gate's number (solve.py's GATE_PREFIX), a Nightmare Gate's rooms' prefix
    (rExtGateA_...), or None (the main world)"""
    if room.startswith("rExtGate"): return room[:9]
    return solve.gate_of(room)


def teleports(rooms, conn):
    """5. softlocks. The pause menu's Teleport works anywhere but in a boss fight (whose needs, bosses.txt's, are in logic
    before it's gone into): in a gate it goes to the gate's own place by its portal (rndgen.py's TELEPORT_GATES), anywhere
    else to the start. So the player is never stuck while each gate's place gets out of the gate with nothing: from its
    nearest way in, an exit to a room outside the gate, by the room's own moves (rooms: before overrides.txt, whose
    lines for a whole gate, the Nightmare Gates' "area ... : mario", give the way out the gate's need too, though it's a
    walk). [(text)], the places looked at"""
    sys.path.insert(0, os.path.dirname(HERE))
    import rndgen
    found = []
    for area, room, x, y in rndgen.TELEPORT_GATES:
        r = rooms.get(room)
        if r is None: found.append("%s (area %d): not in the logic" % (room, area)); continue
        ins = sorted({w[0] for w, t in r.table}, key=lambda s: abs(int(s.split(",")[0]) - x) + abs(int(s.split(",")[1]) - y))
        w0 = ins[0]
        gate = gate_key(room)
        outs = []
        for (w, t), alts in r.table.items():
            if w[0] != w0 or t[0] != "out": continue
            to = solve.link_of(conn, room, t[1], t[2])
            if to and gate_key(to[0]) != gate and solve.NOTHING in [solve.Need(a.c, frozenset(), a.o) for a in alts if not a.k]:
                outs.append(t[1])
        if not outs:
            found.append("%s (area %d, Teleport to %d,%d: way in %s): no exit out of the gate with nothing" % (room, area, x, y, w0))
    return found, len(rndgen.TELEPORT_GATES)


def from_any_door(raw_rooms):
    """4. overrides.txt's "from *" add lines (every way in given the line's need) in rooms where the simulation gets to
    the target from some ways in and from others not at all: the line gives those a way they may not have (perdoor.py
    looks closer). [(text)], the lines looked at, the lines found"""
    import tests
    names = solve.place_names(raw_rooms)
    found, n_lines, n_bad = [], 0, 0
    for L in tests.read_lines():
        if L.cmd != "add": continue
        head = L.text.split(None, 1)[1].partition(":")[0]
        f = head.split()
        if len(f) < 4 or f[1] != "from" or f[2] != "*" or f[-1] == "*": continue
        where = "overrides.txt line %d" % L.ln
        n_lines += 1
        bad = []
        for r, inid, target in solve.override_way(raw_rooms, names, head, where):
            rows = solve.override_rows(r, inid, target)
            reach = {w: tests.sim_alts(r, w, t) for w, t in rows}
            some = [w for w, a in reach.items() if a]
            none_ = [w for w, a in reach.items() if not a]
            if some and none_:
                bad.append("%s: never from %s (the simulation gets there from %s)" % (
                    r.name, ", ".join(tests.way_text(w) for w in none_), ", ".join(tests.way_text(w) for w in some)))
        if bad:
            n_bad += 1
            found.append("line %d: %s" % (L.ln, L.text))
            found += ["    " + b for b in bad]
    return found, n_lines, n_bad


FPS_DIRS = {f: os.path.join(HERE, "work", "fps%d" % f, "rooms") for f in (30, 60, 120)}


def frame_rates():
    r"""6. what playing at 60 or 120fps costs: the logic (rooms\, each way needing what it needs at 30, 60 and 120fps:
    roomlogic.py with combine_fps.py) beside 30fps alone, from RoomLogic.exe's room files of each frame rate (work\fps30,
    work\fps60, work\fps120). The places that 30fps alone has in logic and the three together lose or need more for, each
    with the frame rate that does it. [(text)], a note (None: the folders aren't there)"""
    if not all(os.path.isdir(d) for d in FPS_DIRS.values()): return [], None
    other = {f: solve.load_rooms(d) for f, d in FPS_DIRS.items()}

    def solved(rates):
        rooms = solve.load_rooms(FPS_DIRS[30])
        for name, r in rooms.items():
            for key in list(r.table):
                alts = r.table[key]
                for f in rates:
                    o = other[f].get(name)
                    alts = solve.product(alts, o.table.get(key, []) if o else [])
                r.table[key] = alts
        conn = solve.load_connections()
        solve.load_overrides(rooms, conn)
        return solve.solve_events(rooms, conn)
    res30 = solved([])
    res = {"60fps": solved([60]), "120fps": solved([120]), "all three": solved([60, 120])}
    found, n_lost = [], 0
    for key, alts in res30.places.items():
        if not alts: continue
        comb = res["all three"].places.get(key, [])
        if all(tests_covers(comb, a) for a in alts): continue
        who = [f for f in ("60fps", "120fps") if not all(tests_covers(res[f].places.get(key, []), a) for a in alts)]
        if not comb: n_lost += 1
        found.append("%s %d %d (%s): 30fps %s; all three %s (%s)" % ("lost" if not comb else "needs more", key[0], key[1],
                     res30.place_room.get(key, "?"), solve.alts_text(alts), solve.alts_text(comb), ", ".join(who) or "together"))
    reached = sum(1 for a in res["all three"].places.values() if a)
    return found, "%d places in logic (30fps alone: %d), %d lost, %d need more" % (
        reached, sum(1 for a in res30.places.values() if a), n_lost, len(found) - n_lost)


def tests_covers(alts, need):
    """some alternative of alts needs no more than need"""
    return any(solve.le(a, need) for a in alts)


BASELINE = os.path.join(HERE, "checks_baseline.txt")


def regressions(accept=False):
    """11. overrides.txt's lines that the simulation passed when the baseline was taken (checks_baseline.txt) and doesn't
    now, and lines gone from overrides.txt since: listed till accepted (python checks.py --accept takes a new baseline),
    so a playtest's correction never comes undone unseen. Keyed by the line's text (its number moves). [(text)]"""
    import tests
    now = {r.line.text: r.status for r in tests.run()}
    if accept or not os.path.exists(BASELINE):
        with open(BASELINE, "w", encoding="utf-8", newline="\n") as f:
            f.write("# checks_baseline.txt: overrides.txt's lines and what the simulation made of them when it was taken "
                    "(checks.py --accept): checks.txt lists a line that passed then and doesn't now, or that's gone\n")
            for text, st in sorted(now.items()): f.write("%s\t%s\n" % (st, text))
        return [], "baseline taken"
    base = {}
    for l in open(BASELINE, encoding="utf-8"):
        if l.startswith("#") or "\t" not in l: continue
        st, text = l.rstrip("\n").split("\t", 1)
        base[text] = st
    found = []
    for text, st in sorted(base.items()):
        if text not in now: found.append("gone from overrides.txt (was %s): %s" % (st, text))
        elif st == "pass" and now[text] != "pass": found.append("passed, now %s: %s" % (now[text], text))
    return found, "%d lines in the baseline" % len(base)


def carried_states(rooms, conn, res):
    """7. the carried states (the red and blue switches, the Water Palace's water, the Forest Palace's crystals): each way
    in the logic gets to in a state its room's table has no rows for (so nothing from there: never, unseen). And the
    characters: swapping always works in a Randomizer game (the roomStart hook), so each way may use Jerry's and Claire's
    moves; the rooms that make the player another character (the CHAOS Warship's mech) have only lines. [(text)], the
    ways in looked at"""
    groups = [g for g, v in conn.carried]
    have = collections.defaultdict(set)
    for r in rooms.values():
        for (w, t) in r.table: have[r.name].add(w)
    found, n = [], 0
    for (room, inid, gs) in sorted(res.ways_in, key=str):
        r = rooms.get(room)
        if r is None or not r.carried or not res.ways_in[(room, inid, gs)]: continue
        if r.resets: gs = tuple(r.resets.get(g, v) for g, v in zip(groups, gs))
        st = tuple(sorted((g, v) for g, v in zip(groups, gs) if g in r.carried))
        n += 1
        if (inid, st) not in have[room] and any(w[0] == inid for w in have[room]):
            found.append("%s in %s%s: the logic gets there (%s), the room's table has no rows for it" % (
                room, inid, solve.state_text(st), solve.alts_text(res.ways_in[(room, inid, gs)][:3])))
    return found, n


def main():
    rooms = solve.load_rooms(); conn = solve.load_connections()
    solve.load_overrides(rooms, conn)
    res = solve.solve_events(rooms, conn)
    out = ["# checks.txt: the logic's automatic checks (checks.py, which roomlogic.py runs): only what each finds wrong",
           "# (the brief's Phase F), with its counts. Don't edit: made again each run", ""]
    found, n_ok, n_bad, unmatched, outside = story_run(rooms, conn, res)
    out.append("# ---- 1. the story run: each boss fight, in the story's order, with what the story had given by then "
               "(the Boss Gallery's loadouts, kept gate to gate): %d fights in logic with it, %d not (under each, the "
               "rooms' parts on its way that need more than the story had) ----" % (n_ok, n_bad))
    out += found
    if unmatched: out.append("(gallery fights with no line in bosses.txt: %s)" % ", ".join(unmatched))
    if outside: out.append("(gallery fights in rooms the Randomizer's world doesn't get to: %s)" % ", ".join(outside))
    out.append("")
    found, n_pairs = asymmetry(rooms, conn)
    out.append("# ---- 2. door pairs both ways in logic where one way takes %d or more items than the other: %d of %d "
               "pairs (for review: not wrong in itself) ----" % (ASYM, len(found), n_pairs))
    out += found
    out.append("")
    raw_rooms = solve.load_rooms()
    found5, n_tp = teleports(raw_rooms, conn)
    found, n_lines, n_bad4 = from_any_door(raw_rooms)
    out.append("# ---- 4. overrides.txt's \"from *\" add lines (every way in given the same need) where the simulation gets "
               "to the target from some ways in and never from others: %d of %d lines (the build already stops on a line "
               "that leaves out a weapon, key, chip or event silently) ----" % (n_bad4, n_lines))
    out += found
    out.append("")
    out.append("# ---- 5. softlocks: the Teleport works anywhere but in a boss fight (its needs in logic before it), to each "
               "gate's place by its portal or to the start; each gate's place gets out of the gate with nothing: %d of %d "
               "not ----" % (len(found5), n_tp))
    out += found5
    out.append("")
    found6, fps_note = frame_rates()
    if fps_note is None:
        out.append("# ---- 6. frame rates: work\\fps30, work\\fps60 and work\\fps120 aren't there (roomlogic.py makes them), "
                   "so not checked ----")
    else:
        out.append("# ---- 6. frame rates: the logic (each way needing what it needs at 30, 60 and 120fps) beside 30fps alone "
                   "(work\\fps30, work\\fps60, work\\fps120): %s; the places that 60 or 120fps lose or need more for (and the "
                   "frame rate that does it: for review, the game plays differently there) ----" % fps_note)
        out += found6
    out.append("")
    found7, n_st = carried_states(rooms, conn, res)
    out.append("# ---- 7. carried states and characters: the ways in the logic gets to in a carried state (rb, water, crystals) "
               "their room's table has no rows for: %d of %d (swapping characters always works in a Randomizer game, so "
               "each way may use Jerry's and Claire's moves) ----" % (len(found7), n_st))
    out += found7
    out.append("")
    found11, base_note = regressions("--accept" in sys.argv)
    out.append("# ---- 11. regressions: overrides.txt's lines the simulation passed at the baseline (checks_baseline.txt, "
               "%s) and doesn't now, or gone since: %d (python checks.py --accept takes a new baseline) ----" % (base_note, len(found11)))
    out += found11
    out.append("")
    with open(CHECKS, "w", encoding="utf-8", newline="\r\n") as f: f.write("\n".join(out))
    print("checks.txt: story run %d fights in logic, %d not" % (n_ok, n_bad))


if __name__ == "__main__":
    main()
