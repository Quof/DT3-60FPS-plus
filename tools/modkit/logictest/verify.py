r"""
verify.py (Phase G): the room logic's ways through a room played in the real game, step by step. For a row of the logic
(a room's way in to an exit, a place or an event: ..\randomizer\roomlogic\stress.txt ranks them by how often seeds need
them), each of its needs' alternatives has its route in the room file (rooms\<room>.txt, "how in X,Y -> ...": the steps,
each a move from a standing place and where it gets the player). The game is given just that alternative's items, the
player put where each step starts (as the logic has it: a way within a standing place is walked), the step's input
played frame by frame as the simulation gives it (RoomLogic.exe --move, from the step's {move ...} fields), and where
the player ends up checked against the step's "->": standing on that place, hanging from that point, through that exit,
that place's item got. At 30, 60 and 120fps.

What it shows: that the alternative is enough (in the game, the logic's own moves get there). Not that each of its items
is needed: without one the same input simply doesn't do what it did, which says nothing about other ways; that part is
the simulation's search alone (simulator-only). "need" checks a part of it in the game: for each step of a verified
alternative that a movement item is for (djump, adash, gdash, hijump: the step's [ ]), the game without that item tries
a grid of moves (standing and running jumps of several lengths, walking off, and the other items' moves at several
timings) from across the step's standing place, toward its target. One that gets there says the item isn't needed for
that gap (a way the simulation's search missed); none says the game agrees with the search for the moves tried. Only
the step's own gap: another way round the room is the search's alone.

    python verify.py run <game> [--top N] [--rows TEXT;...] [--fps 30,60,120] [--speed N] [--exe NAME] [--fresh]
        the rows (the top N of stress.txt's ranking, default 40, or those whose text has one of TEXTs), each
        alternative at each frame rate; results kept in calib\verify.txt (a row done before is skipped unless --fresh, which plays these rows again)
    python verify.py need <game> [--rows TEXT;...] [--speed N] [--exe NAME] [--fresh]
        the item check above, for the verified rows (at 30fps); results kept in calib\verify_need.txt
    python verify.py report
        verify_report.txt: each row's status (verified, failed, simulator-only, needs a person) and the counts

The game: the test copy with LogicTest on and a Randomizer game going (started minimised and set up by this, as
roomdump.py does: tests\roomdump_start.txt, the new game's globals put back before each route).
"""
import os, re, sys, json, argparse, subprocess, time

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import lt, calib, roomdump

RL = calib.RL
STRESS = os.path.join(RL, "stress.txt")
RESULTS = os.path.join(HERE, "calib", "verify.txt")
REPORT = os.path.join(RL, "verify_report.txt")

# the logic's item words as LogicTest's items command has them
ITEM = {"djump": "double", "adash": "airdash", "gdash": "dash", "hijump": "hjb", "mario": "mario", "link": "link",
        "belmont": "belmont", "megaman": "mega", "samus": "samus", "gamej": "jgame", "gamec": "cgame", "varia": "varia",
        "air": "air", "key": "key", "chip": "chip"}
CH = {0: "jerry", 1: "claire"}
SPEC = re.compile(r"\{move ([^}]*)\}")
# the starts --move can't make: the route goes on from the next step, this one unchecked
NOT_MOVE = ("fade", "cannon", "fromCrystal", "fromFlyer", "lowBounce", "adClear")


def ranked(top, texts):
    """stress.txt's ranked rows: [(needed %, text)], text "room from IN to TARGET"""
    out, on = [], False
    for l in open(STRESS, encoding="utf-8"):
        if l.startswith("# ---- the ") and "used most" in l: on = True; continue
        if on and l.startswith("# ----"): break
        m = re.match(r"\s*([\d.]+)% needed \((\d+)/(\d+)\), used in\s+([\d.]+)%: (.*)$", l.rstrip("\n"))
        if on and m: out.append((float(m.group(1)), m.group(5)))
    if texts: return [r for r in out if any(t in r[1] for t in texts)]
    return out[:top]


def routes(room, inid, target):
    """the room file's routes from the way in to the target: [(needs text, [step dict])], one per alternative"""
    path = os.path.join(RL, "rooms", room + ".txt")
    if not os.path.exists(path): return None
    out, cur, step = [], None, None
    head = re.compile(r"^how in (.+?) -> (.+?): (.*)$")
    for l in open(path, encoding="utf-8"):
        l = l.rstrip("\n")
        m = head.match(l)
        if m:
            cur = None
            # (a room with states has a route for each: "in 48,288 [crystal1 0]")
            if bare(m.group(1)) == bare(inid) and bare(m.group(2)) == bare(target):
                cur = (m.group(3), []); out.append(cur)
            continue
        if cur is None: continue
        m = re.match(r"^\s+(\d+)\. (.*)$", l)
        if m:
            step = dict(n=int(m.group(1)), how=m.group(2), to=None); cur[1].append(step); continue
        m = re.match(r"^\s+-> (.*)$", l)
        if m and step is not None and cur[1] and cur[1][-1] is step: step["to"] = m.group(1)
    return out


def out_press(room, x, y):
    """the key an exit is gone through with, from the room file's "out" line ("the player presses up at it"): up,
    down or None (gone into, touched)"""
    for l in open(os.path.join(RL, "rooms", room + ".txt"), encoding="utf-8"):
        if l.startswith("out %d,%d " % (x, y)):
            if "presses up at it" in l: return "up"
            if "presses down at it" in l: return "down"
    return None


def out_here(room, x, y):
    """where an exit that leads back into its own room puts the player ("to this room at 368,608"), or None"""
    for l in open(os.path.join(RL, "rooms", room + ".txt"), encoding="utf-8"):
        m = re.match(r"out %d,%d .*to this room at (-?\d+),(-?\d+)" % (x, y), l)
        if m: return int(m.group(1)), int(m.group(2))
    return None


def bare(t):
    """a way in or target without the room's state after it"""
    return re.sub(r"\s*\[[^\]]*\]", "", t).strip()


def items_of(needs):
    """an alternative's needs as LogicTest items (None: one it can't give, an event or a crystal)"""
    out = ["jump"]
    if needs.strip() in ("-", ""): return out
    for w in needs.split(","):
        k, _, n = w.partition(":")
        if k not in ITEM: return None
        out.append(ITEM[k] + ("=" + n if n and k not in ("djump", "adash", "gdash", "mario", "varia") else ""))
    return out


def strip_state(t):
    """where a step gets the player, without the room's state in front ("[barrier 1 shut] standing at ...")"""
    return re.sub(r"^\[[^\]]*\]\s*", "", t or "")


def expect(to):
    """what a step's "->" says, as something to check: (kind, values)"""
    t = strip_state(to)
    m = re.match(r"standing at x (-?\d+)-(-?\d+), y (-?\d+)(?:-(-?\d+))?", t)
    if m:
        y0 = int(m.group(3)); y1 = int(m.group(4)) if m.group(4) else y0
        return ("stand", (int(m.group(1)), int(m.group(2)), y0, y1))
    m = re.match(r"(?:as the Morph Ball: )?rolling at x (-?\d+)-(-?\d+), y (-?\d+)(?:-(-?\d+))?", t)
    if m:
        y0 = int(m.group(3)); y1 = int(m.group(4)) if m.group(4) else y0
        return ("stand", (int(m.group(1)), int(m.group(2)), y0, y1))
    m = re.match(r"hanging from the Strike Chain point at (-?\d+),(-?\d+)", t)
    if m: return ("hang", (int(m.group(1)), int(m.group(2))))
    m = re.match(r"out (-?\d+),(-?\d+)", t)
    if m: return ("out", (int(m.group(1)), int(m.group(2))))
    m = re.match(r"loc (\d+) (\d+)", t)
    if m: return ("loc", (int(m.group(1)), int(m.group(2))))
    return ("other", t)


def sim_keys(room, x, y, fields, fps):
    """RoomLogic.exe --move's input for the move, tick by tick, its start and where it lands"""
    args = [calib.EXE, "--move", calib.PROJ, calib.ROOMS, room, str(x), str(y)] + ["%s=%s" % kv for kv in fields.items()]
    if fps != 30: args += ["fps=%d" % fps, "dither=0"]
    args += ["--slack", "1"]
    out = subprocess.run(args, capture_output=True, text=True).stdout
    start, path, land = None, [], None
    for l in out.splitlines():
        f = l.split()
        if not f: continue
        if f[0] == "ERROR": return None
        if f[0] == "START": start = (int(f[1]), int(f[2]))
        elif f[0] == "T": path.append(dict(keys=f[7], morph=int(f[8]) if len(f) > 8 else 0))
        elif f[0] == "LAND": land = (int(f[1]), int(f[2]), int(f[3]))
    return start, path, land


_movers = {}


def on_mover(room, x, y):
    """whether a standing place at x,y is on a moving platform's way (rooms.txt's N lines along a line): the platform
    is then put under the player before the move (or where the move lands), and held still for it. The logic has the
    player wait for it; the test doesn't time it"""
    if room not in _movers:
        _movers[room], cur = [], None
        for l in open(calib.ROOMS, encoding="utf-8"):
            f = l.rstrip("\n").split("\t")
            if f[0] == "R": cur = f[1]
            elif f[0] == "N" and cur == room and len(f) > 11 and f[7] == "line":
                x1, y1, x2, y2 = (float(v) for v in f[8:12])
                w = 16 * abs(float(f[4]))
                _movers[room].append((min(x1, x2) - 2, max(x1, x2) + w + 2, min(y1, y2) - 3, max(y1, y2) + 3))
    return any(a <= x <= b and c <= y - 1 <= d for a, b, c, d in _movers[room])


MOVERS = ("oMovingPlatform", "oG6_EarthPlat", "oVaultMovingPlat", "oMMEaglePlat")
MOVE_UNDER = "exec with (instance_nearest(%d,%d,%s)) {if point_distance(x,y,%d,%d)<256 {x+=%d-(bbox_left+bbox_right+1)/2; y+=%d-bbox_top; bCanMove=false; xVel=0; yVel=0}}"


def under(room, x, y, land):
    """the lines that put a moving platform under the player standing at x,y, and one under where the move lands"""
    out = []
    for p in [(x, y)] + ([land[:2]] if land else []):
        if on_mover(room, *p):
            out += [MOVE_UNDER % (p[0], p[1], o, p[0], p[1], p[0], p[1] - 1) for o in MOVERS]
    return out
OPEN = "exec with (instance_nearest(%d,%d,oMetroidDoorColor)) {myHolder.sprite_index=sNull; instance_destroy()}"
CALM = "exec with (oEnemyBase) {if object_index!=oLatchCrystal and object_index!=oRidDoorBeacon {instance_deactivate_object(id)}}; instance_deactivate_object(oEProjectileBase)"
PUT = "exec with (oPlayer1) {x=%g; y=%d; xVel=%s; yVel=0; xAcc=0; yAcc=0; canAirDash=1; doubleJumpCheck=1; state=%s}"


def plan(room, inid, needs, steps, fps):
    """the LogicTest lines for one alternative's route, each step after a "log step N" line, and what each should end
    in: (lines, [(n, kind, values, note)]) or (None, why)"""
    its = items_of(needs)
    if its is None: return None, "needs something the test can't give (%s)" % needs
    first = next((SPEC.search(s["how"]) for s in steps if SPEC.search(s["how"])), None)
    ch = int(re.search(r"ch=(\d)", first.group(1)).group(1)) if first else 0
    ix, iy = (int(v) for v in inid.split()[0].split(","))
    fpt = fps // 30
    s = ["log route %s from %s fps %d" % (room, inid, fps), "restore", "fps %d" % fps, "items " + " ".join(its),
         "char " + CH[ch], "god", "goto %s %d %d" % (room, ix, iy), "wait 20"]
    checks, morph = [], False
    for st in steps:
        how, n = st["how"], st["n"]
        m0 = re.match(r"out (-?\d+),(-?\d+)", strip_state(st["to"]))
        st["to_xy"] = (int(m0.group(1)), int(m0.group(2))) if m0 else None
        kind, val = expect(st["to"])
        # (an exit into its own room has no room change: where it puts the player is checked instead)
        here = out_here(room, *val) if kind == "out" else None
        if here: kind, val = "here", here
        s.append("log step %d" % n)
        # (the logic leaves enemies out: their hits would push the player off the simulation's path. Latch crystals are
        # the logic's, and the beacon a door's)
        s.append(CALM)
        m = SPEC.search(how)
        note = ""
        # (a Metroid door the route goes through: the logic has it shot open with the alternative's weapon, which is
        # the logic's part; the test opens it)
        for dx, dy in re.findall(r"Metroid door at (-?\d+),(-?\d+)", how):
            s.append(OPEN % (int(dx), int(dy)))
        if how.startswith("coming in"):
            s.append("pos")
        elif m:
            fields = dict(kv.split("=", 1) for kv in m.group(1).split())
            if any(k in fields for k in NOT_MOVE) or "entering" in fields:
                checks.append((n, "skip", None, "a start the test can't make (%s)" % how.split(",")[0])); continue
            sx, sy = (int(v) for v in re.search(r"from (-?\d+),(-?\d+)", how).groups())
            c = int(fields["ch"])
            if c != ch:
                s += ["hold swap 1", "wait 15"]; ch = c
            want = fields.get("morph") == "1"
            if want != morph:
                s += ["hold c 1", "wait 10"]; morph = want
            sim = sim_keys(room, sx, sy, fields, fps)
            if sim is None or sim[0] is None:
                checks.append((n, "skip", None, "the simulation can't play it again")); continue
            (px, py), path, land = sim
            if fields.get("fromHang") == "1":
                s += ["exec with (oPlayer1) {grappleID=instance_nearest(%d,%d,oStrikeChainPoint); grappleState=3; x=%d; y=%d; xVel=0; yVel=0; xAcc=0; yAcc=0; canAirDash=1; doubleJumpCheck=1; state=FALLING}" % (sx, sy, sx, sy + 40), "wait 3"]
            elif fields.get("fromWall") == "1":
                s += [PUT % (px, py, "0", "FALLING")]
            else:
                s += under(room, px, py, land)
                run = fields.get("run") == "1"
                d = int(fields.get("dir", 1))
                v = d * (7.6 if morph else (6.6 if c == 0 else 7.3)) if run else 0
                if run:
                    # (the run as the simulation starts it: at full speed, the direction held 5 ticks already. Without
                    # the held count the game's next frame halves xVel, as it does for a run just started)
                    k = "Right" if d > 0 else "Left"
                    s.append(PUT[:-1] % (px, py, v, "RUNNING") + "; facing=%s; k%s=1; k%sPushedSteps=5}" % (k.upper(), k, k))
                else:
                    s += [PUT % (px, py, v, "STANDING"), "waitf 1"]
            if fps == 30: s.append("exec oGame.time30=-1")
            else: s.append("exec oPlayer1.ditherCounter=0")
            keys = calib.tick_keys([dict(keys=p["keys"], morph=p["morph"]) for p in path], 1 if morph else 0)
            if land and kind == "stand":
                # (landed: the logic has the player stand where they land, so the run's slide is pushed back on for 3
                # ticks, as a player stops it; the moves' own direction is the one they hold)
                last = (keys[-1] if keys else "").split("+")
                back = "L" if "R" in last else ("R" if "L" in last else None)
                if back: keys = keys + [back] * 3
                s += calib.segments(keys, 12, fps)
            else:
                s += [l + (" room" if kind == "out" else "") for l in calib.segments(keys, 15 if land else 5, fps)]
            # (an exit that's pressed up or down at: the move touches it, then the key, as a player does)
            if kind == "out" and out_press(room, *val):
                s.append("hold %s 10 room" % out_press(room, *val))
            elif kind == "here":
                s.append("hold %s 10" % (out_press(room, *st["to_xy"]) or "down"))
                s.append("wait 40")
            elif kind == "loc" and val[0] == 2:
                # (a treasure chest opens to up pressed while touching it: pressed where the move ends)
                s += ["hold up 2", "wait 10"]
            if path: morph = path[-1]["morph"] == 1
            # (where the simulation itself lands at the game's strength: the logic's moves are 0.95 of it, which can
            # end elsewhere, a jump that bumps a ceiling at full strength)
            if land and kind == "stand" and not (val[0] <= land[0] <= val[1] and val[2] <= land[1] <= val[3]):
                note = "the simulation at the game's strength lands at %d,%d too" % (land[0], land[1])
            elif not land and kind == "stand":
                note = "the simulation at the game's strength doesn't land there either"
        else:
            m4 = re.match(r"walk from (-?\d+),(-?\d+) to (-?\d+),(-?\d+)( into the)?", how)
            m5 = re.match(r"as the Morph Ball, standing at (-?\d+),(-?\d+), goes into it", how)
            if m5 and not morph:
                s += [PUT % (int(m5.group(1)), int(m5.group(2)), "0", "STANDING"), "waitf 1", "hold c 1", "wait 10"]; morph = True
            m2 = re.match(r"(?:as the Morph Ball: |as the Morph Ball, )?standing at (-?\d+),(-?\d+), (goes into it|presses up at it|presses down at it|touches it)", how)
            m3 = re.match(r"turn (into|back from) the Morph Ball at (-?\d+),(-?\d+)", how)
            if m4 and m4.group(5):
                # (walked into a door: from where it starts, the direction held till the room changes)
                x, y, x2 = int(m4.group(1)), int(m4.group(2)), int(m4.group(3))
                s += [PUT % (x, y, "0", "STANDING"), "waitf 1", "hold %s 60 room" % ("right" if x2 >= x else "left")]
            elif m4:
                # (a walk within a standing place, which the logic takes as given: put at its end)
                s += [PUT % (int(m4.group(3)), int(m4.group(4)), "0", "STANDING"), "waitf 1"]
            elif m2:
                x, y = int(m2.group(1)), int(m2.group(2))
                s += [PUT % (x, y, "0", "STANDING"), "waitf 1"]
                act = m2.group(3)
                if act == "goes into it":
                    ex = val[0] if kind == "out" else (st["to_xy"][0] if st["to_xy"] else x)
                    s.append("hold %s 60 room" % ("right" if ex >= x else "left"))
                elif act == "presses up at it": s += ["hold up 10 room"] if kind != "here" else ["hold up 10", "wait 40"]
                elif act == "presses down at it": s += ["hold down 10 room"] if kind != "here" else ["hold down 10", "wait 40"]
                else: s.append("wait 5")
            elif m3:
                x, y = int(m3.group(2)), int(m3.group(3))
                s += [PUT % (x, y, "0", "STANDING"), "waitf 1", "hold c 1", "wait 10"]
                morph = m3.group(1) == "into"
            else:
                checks.append((n, "skip", None, "a step the test can't play (%s)" % how[:60])); continue
        s.append("pos")
        checks.append((n, kind, val, note))
    s.append("log route end")
    return s, checks


POS = re.compile(r"^pos f\d+ (\S+) (-?[\d.]+),(-?[\d.]+) v (-?[\d.]+),(-?[\d.]+)")


def judge(out, room, checks):
    """the game's results for one route: (ok, [problem])"""
    steps, cur = {}, None
    for l in out.splitlines():
        m = re.match(r"log step (\d+)", l)
        if m: cur = int(m.group(1)); steps[cur] = []; continue
        if l.startswith("log route end"): cur = None
        if cur is not None: steps[cur].append(l)
    probs, skipped = [], 0
    for n, kind, val, note in checks:
        ls = steps.get(n, [])
        if kind == "skip": skipped += 1; probs.append("step %d not played: %s" % (n, note)); continue
        pos = [POS.match(l) for l in ls if POS.match(l)]
        exits = [l for l in ls if l.startswith("exit ")]
        gots = [l for l in ls if l.startswith("got loc ")]
        dead = [l for l in ls if l.startswith("dead")]
        hits = sorted(set(l.split()[2] for l in ls if l.startswith("hit ")))
        n0 = len(probs)
        if dead: probs.append("step %d: the player died" % n); continue
        if kind == "out":
            want = "exit %s %d,%d" % (room, val[0], val[1])
            if not any(l.startswith(want) for l in exits):
                probs.append("step %d: not through out %d,%d (%s)" % (n, val[0], val[1], (exits[0] if exits else "ended at " + _at(pos))))
        elif kind == "here":
            p = pos[-1] if pos else None
            if not p or p.group(1) != room or abs(float(p.group(2)) - val[0]) > 24 or abs(float(p.group(3)) - val[1]) > 48:
                probs.append("step %d: not put at %d,%d by the exit (ended at %s)" % (n, val[0], val[1], _at(pos)))
        elif kind == "loc":
            if not any(l.startswith("got loc %d %d" % val) for l in gots):
                probs.append("step %d: loc %d %d not got (ended at %s)" % (n, val[0], val[1], _at(pos)))
        elif kind == "stand":
            if not pos: probs.append("step %d: no place" % n); continue
            p = pos[-1]
            x, y = float(p.group(2)), float(p.group(3))
            if p.group(1) != room or not (val[0] - 8 <= x <= val[1] + 8 and val[2] - 2 <= y <= val[3] + 2):
                probs.append("step %d: ended at %s, not standing at x %d-%d, y %d-%d%s" % (n, _at(pos), val[0], val[1], val[2], val[3], (" (" + note + ")") if note else ""))
        elif kind == "hang":
            if not pos: probs.append("step %d: no place" % n); continue
            p = pos[-1]
            x, y = float(p.group(2)), float(p.group(3))
            if abs(x - val[0]) > 4 or abs(y - (val[1] + 40)) > 4:
                probs.append("step %d: ended at %s, not hanging from %d,%d" % (n, _at(pos), val[0], val[1]))
        if hits and len(probs) > n0: probs[-1] += " (hit by %s)" % ", ".join(hits)
    played = [c for c in checks if c[1] != "skip"]
    hard = [p for p in probs if "not played" not in p]
    return (not hard), probs, skipped, len(played)


def _at(pos):
    if not pos: return "?"
    p = pos[-1]
    return "%s %s,%s" % (p.group(1), p.group(2), p.group(3))


def load():
    if not os.path.exists(RESULTS): return {}
    return json.load(open(RESULTS, encoding="utf-8"))


def save(res):
    json.dump(res, open(RESULTS, "w", encoding="utf-8"), indent=1, sort_keys=True)


def run(game, rows, fps_list, speed, exe, fresh):
    res = load()
    roomdump.restart(game, exe)
    for pct, text in rows:
        if text in res and not fresh: continue
        m = re.match(r"(\S+) from (.+?) to (.+)$", text)
        room, inid, target = m.groups()
        entry = dict(needed=pct, alts=[])
        rs = routes(room, inid, target)
        if not rs:
            entry["status"] = "needs a person"
            entry["why"] = "no simulated route in the room file (an overrides.txt line, a map or an event): to be played by hand or recorded"
            res[text] = entry; save(res); print("%s: %s" % (text, entry["status"])); continue
        for needs, steps in rs:
            alt = dict(needs=needs, fps={})
            for fps in fps_list:
                lines, checks = plan(room, inid, needs, steps, fps)
                if lines is None:
                    alt["fps"][str(fps)] = dict(ok=None, probs=[checks]); continue
                cmd = os.path.join(HERE, "calib", "verify_cmds.txt")
                open(cmd, "w", encoding="utf-8").write("\n".join(["speed %d" % speed] + lines) + "\n")
                rc = lt.run(game, cmd, 300, quiet=True)
                if rc == 2:
                    alt["fps"][str(fps)] = dict(ok=None, probs=["the game stopped answering"]); roomdump.restart(game, exe); continue
                out = open(os.path.join(lt.ltdir(game), "out.txt"), "rb").read().decode("cp1252", "replace")
                err = [l for l in out.splitlines() if l.startswith("error")]
                if err:
                    alt["fps"][str(fps)] = dict(ok=None, probs=err[:2]); continue
                ok, probs, skipped, played = judge(out, room, checks)
                r = dict(ok=ok, probs=probs, skipped=skipped, played=played)
                if not ok and any("(hit by " in p for p in probs):
                    # (a hit pushed the player off the path: played again with nothing hurting them, for whether the
                    # moves get there without the hazards the logic leaves out)
                    open(cmd, "w", encoding="utf-8").write("\n".join(["speed %d" % speed] + [l if l != "god" else "god\nnohit" for l in lines]) + "\n")
                    if lt.run(game, cmd, 300, quiet=True) == 2: roomdump.restart(game, exe)
                    else:
                        out2 = open(os.path.join(lt.ltdir(game), "out.txt"), "rb").read().decode("cp1252", "replace")
                        r["nohit"], r["nohit_probs"] = judge(out2, room, checks)[:2]
                alt["fps"][str(fps)] = r
            entry["alts"].append(alt)
        entry["status"] = status(entry)
        res[text] = entry
        save(res)
        print("%s: %s" % (text, entry["status"]), flush=True)
    return res


def status(entry):
    """a row's status: verified (an alternative played through in the game at every frame rate, every step played),
    failed (an alternative's steps went elsewhere in the game), 95% jump (failed only where the game's full-strength jump
    doesn't do what the logic's 0.95 one does, and for hits that played again with nothing hurting the player got there),
    hazard (failed only for hits, and got there with nothing hurting the player), simulator-only (none could be played
    whole), needs a person (no simulated route)"""
    if entry.get("status") == "needs a person" and not entry["alts"]: return "needs a person"
    def weak(probs):
        # (every miss a move the game's full strength doesn't make as the logic's 0.95 does: the logic takes those as a
        # player's)
        hard = [p for p in probs if "not played" not in p]
        return bool(hard) and all("game's strength" in p for p in hard)
    def how(r):
        if r.get("ok"): return "ok"
        if r.get("ok") is None: return "none"
        if weak(r.get("probs", [])): return "weak"
        if "nohit" in r and (r["nohit"] or weak(r.get("nohit_probs", []))):
            return "weak" if not r["nohit"] else "hazard"
        return "fail"
    kinds = [set(how(r) for r in a["fps"].values()) for a in entry["alts"] if a["fps"]]
    if any("fail" in k for k in kinds): return "failed"
    if any("weak" in k for k in kinds): return "95% jump"
    if any("hazard" in k for k in kinds): return "hazard"
    if any(k == {"ok"} and all(not r.get("skipped") for r in a["fps"].values())
           for k, a in zip(kinds, [a for a in entry["alts"] if a["fps"]])): return "verified"
    return "simulator-only"


def report():
    res = load()
    order = sorted(res.items(), key=lambda kv: -kv[1]["needed"])
    cnt = {}
    out = ["# Phase G (verify.py): the logic's rows played in the game, in stress.txt's order. verified: an alternative's",
           "# route played through, every step, at each frame rate; failed: a step went elsewhere in the game (below);",
           "# 95% jump: an alternative failed only where the game's full-strength jump doesn't do what the logic's 0.95 one",
           "# does (a ceiling bumped: the logic takes those as a player's);",
           "# hazard: an alternative failed only for a hit the logic leaves out (Gate C's shadows, a trap) and got there with",
           "# nothing hurting the player; simulator-only: no route could be played whole (a start the test can't make: listed); needs a person: no",
           "# simulated route (an overrides.txt line, a map, an event): to be played by hand. That each item of an",
           "# alternative is needed is the simulation's search alone: the game can only show an alternative is enough.", ""]
    body = []
    for text, e in order:
        st = e["status"] = status(e); cnt[st] = cnt.get(st, 0) + 1
        body.append("%-15s %5.1f%%  %s" % (st, e["needed"], text))
        if st == "needs a person": body.append("      " + e.get("why", ""))
        for a in e["alts"]:
            for fps, r in sorted(a["fps"].items(), key=lambda kv: int(kv[0])):
                if r.get("ok") and not r.get("probs"): continue
                for p in r.get("probs", []): body.append("      [%s] %sfps: %s" % (a["needs"], fps, p))
                if "nohit" in r:
                    body.append("      [%s] %sfps with nothing hurting the player: %s" % (a["needs"], fps, "got there" if r["nohit"] else "; ".join(r["nohit_probs"][:2])))
    out.append("counts: " + ", ".join("%s %d" % kv for kv in sorted(cnt.items())) + " (of %d rows)" % len(res))
    out.append("")
    open(REPORT, "w", encoding="utf-8").write("\n".join(out + need_report() + body) + "\n")
    print(out[-2])


NEED_RESULTS = os.path.join(HERE, "calib", "verify_need.txt")
# the movement items a step's [ ] can name, which "need" takes away
MOVE_ITEMS = ("djump", "adash", "gdash", "hijump")


def counted(needs):
    """an alternative's needs as {word: count} ("-": none)"""
    out = {}
    if needs.strip() in ("-", ""): return out
    for w in needs.split(","):
        k, _, n = w.partition(":")
        out[k if not n or n.isdigit() else w] = int(n) if n.isdigit() else 1
    return out


def as_needs(have):
    return ",".join(k if k in ("djump", "adash", "gdash", "mario", "varia") else "%s:%d" % (k, n) for k, n in have.items() if n > 0) or "-"


def grid(ch, dirs, have, xs, y):
    """the moves tried from a standing place with the items in have: [(x, fields)]"""
    out = []
    holds = (2, 6, 13, 21) + ((40,) if have.get("hijump") else ())
    for x in xs:
        for d in dirs:
            base = dict(ch=str(ch), dir=str(d))
            if have.get("hijump"): base["hiJump"] = str(have["hijump"])
            out.append((x, dict(base, noInputTillAir="1")))
            for run in ("0", "1"):
                for h in holds:
                    out.append((x, dict(base, run=run, jumpAt="0", jumpHold=str(h))))
                for t in ((6, 12) if have.get("djump") else ()):
                    out.append((x, dict(base, run=run, jumpAt="0", djAt=str(t))))
                for t in ((4, 10, 16) if have.get("adash") else ()):
                    out.append((x, dict(base, run=run, jumpAt="0", adAt=str(t))))
            for t in ((1, 4) if have.get("gdash") else ()):
                out.append((x, dict(base, jumpAt=str(t), gdAt="0")))
    return out


def need_trials(room, needs, steps):
    """for each step of an alternative that a movement item is for: (step n, item, its target (kind, values), the
    player's start place (x0, x1, y), the items left, the moves to try)"""
    out, prev = [], None
    if items_of(needs) is None: return out
    for st in steps:
        tag = re.search(r"\]\s*$", st["how"]) and re.search(r"\[([^\]]*)\]\s*$", st["how"]).group(1)
        m = SPEC.search(st["how"])
        kind, val = expect(st["to"])
        src = prev
        prev = val if kind == "stand" else None
        if not (tag and m and src and kind in ("stand", "out", "loc")): continue
        fields = dict(kv.split("=", 1) for kv in m.group(1).split())
        if any(k in fields for k in NOT_MOVE) or "entering" in fields or "fromHang" in fields or "fromWall" in fields: continue
        have = counted(needs)
        tx = val[0] if kind != "stand" else (val[0] + val[1]) // 2
        sx0, sx1, sy = src[0], src[1], src[2]
        dirs = [d for d in (1, -1) if (d > 0 and tx > sx0) or (d < 0 and tx < sx1)]
        # (start places every 8 pixels, up to 12, across the standing place)
        n = max(1, min(12, (sx1 - sx0) // 8 + 1))
        xs = sorted(set(sx0 + (sx1 - sx0) * i // max(1, n - 1) for i in range(n)))
        for w in counted(tag):
            if w not in MOVE_ITEMS or w not in have: continue
            left = dict(have); left[w] -= 1
            out.append((st["n"], w, (kind, val), (sx0, sx1, sy), left, grid(int(fields["ch"]), dirs, left, xs, sy)))
    return out


def need(game, rows, speed, exe, fresh):
    res, nres = load(), (json.load(open(NEED_RESULTS, encoding="utf-8")) if os.path.exists(NEED_RESULTS) else {})
    restarted = False
    for text, e in sorted(res.items(), key=lambda kv: -kv[1]["needed"]):
        if e["status"] != "verified" or (rows and not any(t in text for t in rows)): continue
        if text in nres and not fresh: continue
        if not restarted: roomdump.restart(game, exe); restarted = True
        room, inid, target = re.match(r"(\S+) from (.+?) to (.+)$", text).groups()
        ok_alts = [a["needs"] for a in e["alts"] if a["fps"] and all(r.get("ok") and not r.get("skipped") for r in a["fps"].values())]
        entry = []
        for needs, steps in routes(room, inid, target) or []:
            if needs not in ok_alts: continue
            for n, w, (kind, val), src, left, moves in need_trials(room, needs, steps):
                its = items_of(as_needs(left))
                s = ["speed %d" % speed, "restore", "fps 30", "items " + " ".join(its), "char " + CH[int(moves[0][1]["ch"])],
                     "god", "goto %s %s" % (room, " ".join(inid.split()[0].split(","))), "wait 20"]
                checks, tried = [], []
                for i, (x, f) in enumerate(moves, 1):
                    sim = sim_keys(room, x, src[2], f, 30)
                    if sim is None or sim[0] is None or not sim[1]: continue
                    (px, py), path, land = sim
                    keys = calib.tick_keys([dict(keys=p["keys"], morph=p["morph"]) for p in path], 0)
                    # (landed: the slide pushed back on, as in run's routes. Else the simulation's input stops where its
                    # move does, a hazard or no landing yet: the direction kept held a while after, as the move would)
                    if land: keys += [("L" if int(f["dir"]) > 0 else "R")] * 3
                    else: keys += [("R" if int(f["dir"]) > 0 else "L")] * 10
                    s += ["log step %d" % i, CALM]
                    s += under(room, px, py, land)
                    if f.get("run") == "1":
                        k = "Right" if int(f["dir"]) > 0 else "Left"
                        v = int(f["dir"]) * (6.6 if f["ch"] == "0" else 7.3)
                        s.append(PUT[:-1] % (px, py, v, "RUNNING") + "; facing=%s; k%s=1; k%sPushedSteps=5}" % (k.upper(), k, k))
                    else:
                        s += [PUT % (px, py, "0", "STANDING"), "waitf 1"]
                    s.append("exec oGame.time30=-1")
                    s += [l + (" room" if kind == "out" else "") for l in calib.segments(keys, 12, 30)]
                    if kind == "loc" and val[0] == 2: s += ["hold up 2", "wait 10"]
                    s.append("pos")
                    # (back in the room for the next move, if this one left it)
                    if kind == "out": s += ["goto %s %s" % (room, " ".join(inid.split()[0].split(","))), "wait 10"]
                    # (and the place's item not got, for the next)
                    if kind == "loc": s += ["restore", "items " + " ".join(its), "goto %s %s" % (room, " ".join(inid.split()[0].split(","))), "wait 20"]
                    checks.append((i, kind, val, "")); tried.append((x, f))
                cmd = os.path.join(HERE, "calib", "verify_cmds.txt")
                open(cmd, "w", encoding="utf-8").write("\n".join(s) + "\n")
                rc = lt.run(game, cmd, 900, quiet=True)
                if rc == 2:
                    entry.append(dict(needs=needs, step=n, item=w, error="the game stopped answering")); roomdump.restart(game, exe); continue
                out = open(os.path.join(lt.ltdir(game), "out.txt"), "rb").read().decode("cp1252", "replace")
                probs = judge(out, room, checks)[1]
                bad = set(int(re.match(r"step (\d+)", p).group(1)) for p in probs if re.match(r"step (\d+)", p))
                hit = set()
                cur = None
                for l in out.splitlines():
                    m = re.match(r"log step (\d+)", l)
                    if m: cur = int(m.group(1))
                    elif cur and l.startswith("hit "): hit.add(cur)
                got = [(x, " ".join("%s=%s" % kv for kv in f.items())) for i, (x, f) in enumerate(tried, 1) if i not in bad and i not in hit]
                entry.append(dict(needs=needs, step=n, item=w, tried=len(tried), got=got[:5], ngot=len(got)))
                print("%s [%s] step %d without %s: %d moves, %d get there" % (text, needs, n, w, len(tried), len(got)), flush=True)
        nres[text] = entry
        json.dump(nres, open(NEED_RESULTS, "w", encoding="utf-8"), indent=1, sort_keys=True)
    return nres


def need_report():
    """the item check's lines for verify_report.txt"""
    if not os.path.exists(NEED_RESULTS): return []
    nres = json.load(open(NEED_RESULTS, encoding="utf-8"))
    out, ok, gaps = [], 0, 0
    for text, entry in sorted(nres.items()):
        for t in entry:
            if t.get("error") or t["ngot"]:
                gaps += 1
                out.append("  %s [%s] step %d without %s: %s" % (text, t["needs"], t["step"], t["item"], t.get("error") or
                           "%d of %d moves get there, e.g. from x %s: %s" % (t["ngot"], t["tried"], t["got"][0][0], t["got"][0][1])))
            else: ok += 1
    head = ["# ---- need (the items' check): %d steps' items needed for the moves tried in the game, %d not ----" % (ok, gaps)]
    return head + out + [""]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("what", choices=["run", "need", "report"])
    ap.add_argument("game", nargs="?")
    ap.add_argument("--top", type=int, default=40)
    ap.add_argument("--rows", default="")
    ap.add_argument("--fps", default="30,60,120")
    ap.add_argument("--speed", type=int, default=4)
    ap.add_argument("--exe", default="DT3_LogicTest_b.exe")
    ap.add_argument("--fresh", action="store_true")
    a = ap.parse_args()
    if a.what == "run":
        rows = ranked(a.top, [t for t in a.rows.split(";") if t])
        run(a.game, rows, [int(v) for v in a.fps.split(",")], a.speed, os.path.join(a.game, a.exe), a.fresh)
    elif a.what == "need":
        need(a.game, [t for t in a.rows.split(";") if t], a.speed, os.path.join(a.game, a.exe), a.fresh)
    report()


if __name__ == "__main__":
    main()
