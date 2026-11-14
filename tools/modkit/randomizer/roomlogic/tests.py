"""
tests.py: overrides.txt's lines as tests of the room logic's own simulation (the rooms' files, rooms\\<room>.txt, before
any line of overrides.txt: graph.txt's edges from the room logic), door by door, each with its reason (the line's
comments: what it's for, the playtest it came from). roomlogic.py runs it after graph.py; tests.txt is the report.

  add <room> from <door> to <target> : <needs>   sufficient: from that way in (from each, for "from *"), with any one
                                                 of the alternatives, the target is got to. The simulation passes if it
                                                 gets there with that alternative (or with less)
  drop ... because <why>, then add ...           the add sufficient, as above, and necessary: nothing else gets there.
                                                 The simulation fails it where it gets there with less than every one of
                                                 the alternatives: a way it found that the drop line drops, the
                                                 simulation more lenient than the game as the lines have it
  drop ... because <why>, and no add after it    necessary: never. The simulation fails it where it gets there at all
  add <room or area> from * to *, after a drop   every way through the room (each room of the area), as above
  require <room> from <door> to <target> : ...   necessary: every way there takes that as well. The simulation passes
                                                 where its every way there already takes it (one of the alternatives)
  link <room> out <exit> -> <room> in <door>     the exit leads there: where connections.txt (the game's exit as
                                                 roomdata.py reads it) agrees, a test it passes; else the mod's own
                                                 change, a rule
  require <room> out <exit>, a require of what the simulation can't see (Air Upgrades, cursed equipment, events, options,
  chips), drop ... : <requirements> because, only, outoflogic
                                                 rules the simulation doesn't see (a chip or an event for an exit, air
                                                 under water, an add line leaving out what the simulation's ways take,
                                                 abilities a room takes away, a place left out): listed with their
                                                 reasons

A line the simulation passes is a regression test: the simulation already has it, and has to keep having it. One it
fails is either the simulation to fix, or something beyond it (a mechanism it doesn't model), kept as the line is; or
a line that looks wrong, a question for whoever wrote it. Also listed: bosses.txt's fights and events.txt's events (each
event's room got to with everything).

usage: python tests.py            write tests.txt and say how many pass and fail
"""
import os, sys, re, collections, textwrap
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import solve

TESTS = os.path.join(HERE, "tests.txt")
# (each room's mechanisms the room logic leaves out: roomdata.py's UNMODELLED and ROOM_UNMODELLED, written beside
# work\rooms.txt)
MECHANISMS = os.path.join(HERE, "work", "rooms_mechanisms.txt")
CMDS = r"(add|drop|require|link|only|outoflogic|set|room|area|need|also)\s"


def mechanisms():
    """{room: "the mechanisms in it the room logic leaves out"} (roomdata.py's, from its last run)"""
    if not os.path.exists(MECHANISMS): return {}
    out = {}
    for l in open(MECHANISMS, encoding="utf-8"):
        r, _, m = l.rstrip("\n").partition("\t")
        if m: out[r] = m
    return out


def le(a, b): return solve.le(a, b)


def covers(alts, need):
    """the simulation's alternatives get there with the items of need (one of them needs no more than it)"""
    return any(le(b, need) for b in alts)


class Line:
    """a line of overrides.txt: its number, command, text, and its reasons (its own comment, the comments right above
    its block of lines, and the part of the file it's in)"""
    def __init__(self, ln, cmd, text, note, block, section):
        self.ln, self.cmd, self.text, self.note, self.block, self.section = ln, cmd, text, note, block, section

    def reason(self):
        parts = [p for p in (self.note, self.block) if p]
        return " / ".join(parts) if parts else "(no comment)"


def read_lines(path=solve.OVERRIDES):
    """overrides.txt's lines with their reasons: [Line]"""
    out, block, section, pending, last_cmd = [], [], "", [], False
    for ln, raw in enumerate(open(path, encoding="utf-8"), 1):
        s = raw.rstrip("\n")
        body, hsh, note = s.partition("#")
        body = body.strip()
        if not body:
            if s.strip().startswith("#"):
                txt = s.strip().lstrip("#").strip()
                m = re.match(r"-+\s*(.*?)\s*-+$", txt)
                if m: section, pending = m.group(1), []
                # (a line taken out, "#drop ...": it ends the comments above it as a line would)
                elif re.match(CMDS, txt):
                    last_cmd = True
                    continue
                elif last_cmd: pending = [txt]
                else: pending.append(txt)
                last_cmd = False
            else:
                pending, last_cmd = [], False
            continue
        if not last_cmd: block = " ".join(pending)
        f = body.split(None, 1)
        out.append(Line(ln, f[0].lower(), body, note.strip().strip("()") if hsh else "", block, section))
        last_cmd, pending = True, []
    return out


class Result:
    def __init__(self, line, kind, status, details):
        self.line, self.kind, self.status, self.details = line, kind, status, details   # status: pass, fail, drop, rule


def target_text(t):
    if t[0] == "out": return "out %s%s" % (t[1], solve.state_text(t[2]) if t[2] else "")
    if t[0] == "loc": return "loc %d %d" % (t[1], t[2])
    return "spot %s" % t[1]


def way_text(w):
    return "in %s%s" % (w[0], solve.state_text(w[1]))


def unseen(n):
    """an alternative that takes something the simulation never has a way of needing: Air Upgrades, the cursed
    equipment, an event, an option, a Program Chip"""
    return n.c[solve.ITEMS.index("air")] > 0 or n.c[solve.ITEMS.index("cursed")] > 0 or bool(n.o) or any(k > solve.CHIP_KEY for k in n.k)


def own_events(room, alts, ev):
    """alternatives with the room's own events (its spots: event:<room>/<spot>) put in by what reaching the spot takes
    from the same way in (ev, spot_events'), as solve.py puts every event in; other events kept"""
    out, pre = [], "event:%s/" % room.name
    for a in alts:
        mine = sorted(o for o in a.o if o.startswith(pre))
        if not mine: solve.add(out, a); continue
        base = [solve.Need(a.c, a.k, a.o - frozenset(mine))]
        for e in mine: base = solve.product(base, ev.get(e[6:], []))
        for b in base: solve.add(out, b)
    return out


def spot_events(room, w):
    """what reaching each of the room's spots takes from way in w, the spots' own events in it: {<room>/<spot>: alternatives}"""
    spots = [t for (ww, t) in room.table if ww == w and t[0] == "spot"]
    ev = {}
    for _ in range(len(spots) + 2):
        new = {"%s/%s" % (room.name, t[1]): own_events(room, room.table[(w, t)], ev) for t in spots}
        if new == ev: break
        ev = new
    return ev


def sim_alts(room, w, t):
    """the room's table for way in w to target t, its own events (spots it reaches) put in"""
    alts = room.table.get((w, t), [])
    if not any(o.startswith("event:%s/" % room.name) for a in alts for o in a.o): return alts
    return own_events(room, alts, spot_events(room, w))


def check_way(raw_room, final_room, w, t, need, replace):
    """one way in to one target: the line's needs (alternatives; [] never) against the simulation's (raw_room's, before
    overrides.txt), and what all of overrides.txt's lines leave (final_room's). Returns (status, detail): pass; fail
    (the simulation doesn't get there with an alternative of the line's); drop (replace: the simulation gets there with
    less than every one of the line's alternatives, and the logic, every line in, doesn't have that way any more);
    unseen (the same, but each of the line's alternatives takes something the simulation can't see: the line adds a
    requirement, as a require line would)"""
    #have = raw_room.table.get((w, t), [])
    #final = final_room.table.get((w, t), [])
    have = sim_alts(raw_room, w, t)
    final = sim_alts(final_room, w, t)
    short = [a for a in need if not covers(have, a)]
    dropped = [b for b in have if not any(le(a, b) for a in need)] if replace else []
    lost = [b for b in dropped if not covers(final, b)]
    sim = solve.alts_text(have)
    if lost:
        status = "unseen" if need and all(unseen(a) for a in need) else "drop"
        return status, "%s -> %s: the simulation: %s (the lines drop %s%s)" % (way_text(w), target_text(t), sim, solve.alts_text(lost),
                                                                             "; the logic has: " + solve.alts_text(final) if final != need else "")
    if short:
        return "fail", "%s -> %s: the simulation: %s (not with %s)" % (way_text(w), target_text(t), sim, solve.alts_text(short))
    return "pass", "%s -> %s: the simulation: %s%s" % (way_text(w), target_text(t), sim,
                                                        " (the lines drop %s, which another line gives back)" % solve.alts_text(dropped) if dropped else "")


def check_require(raw_room, w, t, need):
    """one way in to one target of a require line: does every one of the simulation's ways there take the requirement
    (one of its alternatives) already? pass, or drop (the simulation gets there without it)"""
    #have = raw_room.table.get((w, t), [])
    have = sim_alts(raw_room, w, t)
    without = [b for b in have if not any(le(a, b) for a in need)]
    if without:
        return "drop", "%s -> %s: the simulation: %s (without it: %s)" % (way_text(w), target_text(t), solve.alts_text(have), solve.alts_text(without))
    return "pass", "%s -> %s: the simulation: %s" % (way_text(w), target_text(t), solve.alts_text(have))


RANK = {"pass": 0, "fail": 1, "unseen": 2, "drop": 3}


def run(path=solve.OVERRIDES):
    import copy
    raw_rooms = solve.load_rooms()
    conn = solve.load_connections()
    names = solve.place_names(raw_rooms)
    final_rooms = copy.deepcopy(raw_rooms)
    solve.load_overrides(final_rooms, solve.load_connections(), path)
    results = []
    dropped = {}         # (room, row) -> the drop line that last dropped it
    drops = []           # (drop line, its rows, the rows an add line after it gives a way)
    for L in read_lines(path):
        where = "overrides.txt line %d" % L.ln
        rest = L.text.split(None, 1)[1] if " " in L.text else ""
        if L.cmd == "link":
            # (a link line sends an exit somewhere else than the game's own exit, roomdata.py's connections.txt: the mod's
            # own change, a rule; the same as connections.txt, a test it passes)
            hf = rest.split()
            have = conn.links.get((hf[0], hf[2]))
            st = "pass" if have == (hf[4], hf[6]) else "rule"
            results.append(Result(L, "link", st, [(st, "connections.txt: %s out %s -> %s" % (hf[0], hf[2], "%s in %s" % have if have else "nowhere"))]))
            continue
        if L.cmd in ("only", "outoflogic") or (L.cmd == "require" and rest.split()[1:2] == ["out"]):
            results.append(Result(L, L.cmd, "rule", []))
            continue
        if L.cmd == "drop":
            head, _, why = rest.partition(" because ")
            head, sep, req = head.partition(":")
            if sep:
                results.append(Result(L, "the add lines there leave out " + ", ".join(sorted(solve.gate_words(req, where))), "rule", []))
                continue
            rows = [(r, row) for r, inid, target in solve.override_way(raw_rooms, names, head, where)
                    for row in solve.override_rows(r, inid, target)]
            L.because = why.strip()
            drops.append((L, rows, set()))
            for r, row in rows: dropped[(r.name, row)] = drops[-1]
            continue
        head, _, req = rest.partition(":")
        need = solve.parse(req, where)
        spots = solve.override_way(raw_rooms, names, head, where)
        if L.cmd == "require":
            if need and all(unseen(a) for a in need):
                results.append(Result(L, "require", "rule", []))
                continue
            details, worst = [], "pass"
            for r, inid, target in spots:
                for w, t in solve.require_rows(r, inid, target):
                    st, d = check_require(r, w, t, need)
                    details.append((st, (r.name + " " if len(spots) > 1 else "") + d))
                    if RANK[st] > RANK[worst]: worst = st
            results.append(Result(L, "necessary", worst, details))
            continue
        # (an add line: sufficient; where a drop line before it dropped the way, necessary too)
        details, worst, after = [], "pass", set()
        for r, inid, target in spots:
            for row in solve.override_rows(r, inid, target):
                d = dropped.get((r.name, row))
                if d:
                    d[2].add((r.name, row)); after.add(d[0].ln)
                st, txt = check_way(r, final_rooms[r.name], row[0], row[1], need, bool(d))
                details.append((st, (r.name + " " if len(spots) > 1 else "") + txt))
                if RANK[st] > RANK[worst]: worst = st
        kind = "sufficient and necessary: line %s drops the rest" % ", ".join(str(x) for x in sorted(after)) if after else "sufficient"
        # (a line for every way through a room or an area that drops ways: a room whose mechanism the simulation doesn't
        # model, given its need wholesale)
        if after and head.split()[-4:] == ["from", "*", "to", "*"] and worst in ("drop", "unseen"): worst = "blanket"
        results.append(Result(L, kind, worst, details))
    # (a drop line's ways that no add line after it gives back: no way there, necessary: never)
    for L, rows, given in drops:
        rest = [(r, row) for r, row in rows if (r.name, row) not in given]
        if not rest: continue
        details, worst = [], "pass"
        for r, (w, t) in rest:
            st, d = check_way(r, final_rooms[r.name], w, t, [], True)
            details.append((st, d))
            if RANK[st] > RANK[worst]: worst = st
        results.append(Result(L, "necessary: never", worst, details))
    # (a line the simulation fails in a room whose mechanism it leaves out: beyond it, kept as the line is, the mechanism
    # to model; with the mechanism named)
    mech = mechanisms()
    for r in results:
        if r.status != "fail": continue
        rooms_ = {d.split()[0] if not d.startswith("in ") else r.line.text.split()[1] for st, d in r.details if st == "fail"}
        ms = [mech[x] for x in sorted(rooms_) if x in mech]
        if ms and len(ms) == len(rooms_):
            r.status = "beyond"; r.kind += "; not simulated in the room: " + "; ".join(sorted(set(ms)))
    results.sort(key=lambda r: r.line.ln)
    return results


def boss_and_event_lines():
    """bosses.txt's fights and events.txt's events, each with what the logic has for it (roomlogic.txt: its room got to
    from the start), as rules"""
    out = []
    room_need = {}
    if os.path.exists(solve.OUT):
        for line in open(solve.OUT, encoding="utf-8"):
            f = line.split(None, 2)
            if len(f) == 3 and f[0] == "room": room_need[f[1]] = f[2].strip()
    for ln, raw in enumerate(open(solve.BOSSES, encoding="utf-8"), 1):
        line = raw.split("#", 1)[0].strip()
        if not line: continue
        note = raw.split("#", 1)[1].strip() if "#" in raw else ""
        head = line.partition(":")[0].split()
        room = head[0] if len(head) == 1 else head[1]
        out.append("bosses.txt line %d: %s   # %s  (its room from the start: %s)" % (ln, line, note, room_need.get(room, "?")))
    for ln, raw in enumerate(open(solve.EVENTS, encoding="utf-8"), 1):
        line = raw.split("#", 1)[0].strip()
        if not line: continue
        f = line.split()
        if f[0] in ("ir+", "ir-"): f = f[1:]
        where = room_need.get(f[2], "?") if f[1] == "room" else "(area %s)" % f[2]
        out.append("events.txt line %d: %s  (its room from the start: %s)" % (ln, line, where))
    return out


def write(results, path=TESTS):
    cnt = collections.Counter(r.status for r in results)
    ways = collections.Counter(st for r in results for st, d in r.details)
    L = ["# tests.txt: overrides.txt's lines as tests of the room logic's own simulation (rooms\\<room>.txt, before any of",
         "# overrides.txt's lines), door by door, each with its reasons (its comments): made by tests.py, don't edit",
         "#   %d lines: %d pass (the simulation agrees: a regression test); %d drop (it gets somewhere with less than the" % (
             len(results), cnt["pass"], cnt["drop"]),
         "#   lines say, and the logic, every line in, has lost that way: the simulation more lenient than the game as the",
         "#   lines have it); %d blanket (a room's or an area's every way, given its need wholesale, dropping some); %d unseen" % (cnt["blanket"], cnt["unseen"]),
         "#   (a line that adds what the simulation can't see: Air Upgrades, cursed equipment, events); %d fail (the" % cnt["fail"],
         "#   simulation doesn't get somewhere a line says is got to: a gap of its to look at); %d beyond (the same, in a" % cnt["beyond"],
         "#   room with a mechanism it leaves out: roomdata.py's UNMODELLED); %d rules (what the simulation doesn't see)." % cnt["rule"],
         "#   Door by door: %d ways pass, %d fail, %d drop, %d unseen" % (ways["pass"], ways["fail"], ways["drop"], ways["unseen"]),
         ""]
    for status, title in (("drop", "the simulation gets there with less than the lines say (it's more lenient than the game as the lines have\n# it: the simulation to look at first, or a line that drops what it shouldn't)"),
                          ("blanket", "a room's or an area's every way given one need (its mechanism not modelled), dropping some of the simulation's"),
                          ("unseen", "lines that add what the simulation can't see (Air Upgrades, cursed equipment, events)"),
                          ("fail", "the simulation doesn't get there with what the line says (a way it misses: the simulation to look at, or\n# something beyond it, kept as the line is)"),
                          ("beyond", "the same, in a room with a mechanism the simulation leaves out (kept as the line is: the mechanism to model)"),
                          ("pass", "the simulation agrees (the line stays as a regression test)"),
                          ("rule", "rules the simulation doesn't see (kept as they are)")):
        rs = [r for r in results if r.status == status]
        L += ["", "# ---- %s: %d ----" % (title, len(rs))]
        last = None
        for r in rs:
            key = (r.line.section, r.line.block)
            if key != last:
                L.append("")
                L += textwrap.wrap("[%s] %s" % (r.line.section or "-", r.line.block or "(no comment above)"), 116,
                                   initial_indent="# ", subsequent_indent="#   ")
                last = key
            L.append("line %d (%s): %s%s" % (r.line.ln, r.kind, r.line.text, "   # " + r.line.note if r.line.note else ""))
            want = {"drop": ("drop", "unseen", "fail"), "unseen": ("unseen", "fail"), "blanket": ("drop", "unseen"), "fail": ("fail",), "beyond": ("fail",)}.get(status, ())
            shown = [d for st, d in r.details if st in want]
            for d in shown[:12]: L.append("    " + d)
            if len(shown) > 12: L.append("    ... and %d more ways" % (len(shown) - 12))
            if r.kind == "link": L.append("    " + r.details[0][1])
    L += ["", "# ---- bosses.txt's fights and events.txt's events (rules: what the room logic can't see) ----"]
    L += boss_and_event_lines()
    with open(path, "w", encoding="utf-8", newline="\n") as fh: fh.write("\n".join(L) + "\n")
    return cnt, ways


def main():
    results = run()
    cnt, ways = write(results)
    print("tests.txt: overrides.txt's %d lines as tests of the simulation: %d pass, %d drop, %d blanket, %d unseen, %d fail, %d beyond, %d rules"
          " (door by door: %d pass, %d fail, %d drop, %d unseen)" % (
        len(results), cnt["pass"], cnt["drop"], cnt["blanket"], cnt["unseen"], cnt["fail"], cnt["beyond"], cnt["rule"],
        ways["pass"], ways["fail"], ways["drop"], ways["unseen"]))


if __name__ == "__main__":
    main()
