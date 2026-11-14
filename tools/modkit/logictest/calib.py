r"""
calib.py: the Randomizer logic's movement (RoomLogic.cs's Sim, a copy of the game's 30fps movement) against the real
game's, move by move. Each move is one of the logic's own (RoomLogic.cs Programs), on a flat floor. The simulation runs
it (RoomLogic.exe --move, at the game's own strength: --slack 1) and gives its input tick by tick; the game plays the
same input (LogicTest: the game running with LogicTest on, a game going) at 30, 60 and 120fps, with the input starting
on each frame of a 30fps tick (phases: 60fps has 2, 120fps 4). The paths are compared tick by tick.

  python calib.py run <game folder> [--moves ID,...] [--chars 0,1] [--fps 30,60,120] [--speed N] [--out NAME]
      runs the moves (all by default) and writes calib\<NAME>.txt (default: measured): the game's paths, the
      simulation's, and the comparison
  python calib.py report [<file>]      the comparison again from a measured file
  python calib.py check <game folder> [--moves ...]
                                       runs the moves again and compares the game's paths with the kept ones (did the
                                       game's movement change?), writing nothing
  python calib.py list                 the moves

Coordinates: the player's feet (x the middle of the body), as the room files have them; dx/dy from where the move
starts (dy up is negative). A tick is a 30th of a second; the game's position at the end of each tick is compared with
the simulation's after that tick.
"""
import os, re, sys, subprocess, argparse, time

HERE = os.path.dirname(os.path.abspath(__file__))
PROJ = os.path.normpath(os.path.join(HERE, "..", "..", ".."))
RL = os.path.join(PROJ, "tools", "modkit", "randomizer", "roomlogic")
EXE = os.path.join(RL, "work", "RoomLogic.exe")
ROOMS = os.path.join(RL, "work", "rooms.txt")
OUTDIR = os.path.join(HERE, "calib")
sys.path.insert(0, HERE)
import lt

# where the moves are made: Central City - North's long flat floor (standing y 289, x 700-1690, nothing low overhead),
# from x 900 (a running start runs from 720 to it); Gate 5's Lv0_A, where the High Jump Boots work, at the bottom of a
# shaft 450px high; Megapolis SigmaA3 (wall jumps), at the bottom of its shaft
FLAT = dict(room="rCCity_NorthA", x=900, y=288, runfrom=720, runup=25, items="jump dash airdash double")
# (the room's enemies taken away, but for the latch crystals: a melee hit on one in the air bounces the player too)
NO_FOES = ["exec with (oEnemyBase) {if object_index!=oLatchCrystal {instance_destroy()}}", "wait 2"]
GATE5 = dict(room="rSamus5_Lv0_A", x=190, y=496)
SHAFT = dict(room="rMega4_SigmaA3", x=300, y=2990, items="jump")
# Central City - Bridge's channel: water about 95px deep over a flat floor (standing y 431, x 904-1466)
WATER = dict(room="rCCity_Bridge", x=1100, y=425, items="jump double")


def M(mid, chs, fields, **kw):
    m = dict(FLAT)
    m.update(kw)
    m.update(id=mid, chs=chs, fields=fields)
    return m


# the logic's moves (RoomLogic.cs Programs, Dir 1), by its names; the characters to try (the logic's own first); the
# fields are Prog's
MOVES = [
    ("walk", [0, 1], dict(h1=1, h2=1, maxT=30)),
    ("jumpup", [0, 1], dict(jumpAt=0, jumpHold=21, h1=0, h2=0)),
    ("jump2", [1, 0], dict(jumpAt=0, jumpHold=2, h1=1, h2=1)),
    ("jump6", [1, 0], dict(jumpAt=0, jumpHold=6, h1=1, h2=1)),
    ("jump21", [1, 0], dict(jumpAt=0, jumpHold=21, h1=1, h2=1)),
    ("runjump2", [1, 0], dict(run=1, jumpAt=0, jumpHold=2, h1=1, h2=1)),
    ("runjump6", [1, 0], dict(run=1, jumpAt=0, jumpHold=6, h1=1, h2=1)),
    ("runjump21", [1, 0], dict(run=1, jumpAt=0, jumpHold=21, h1=1, h2=1)),
    ("jumpup-side", [1, 0], dict(jumpAt=0, jumpHold=21, h1=0, h2=1, hDelay=8)),
    ("jumpup-late", [1, 0], dict(jumpAt=0, jumpHold=21, h1=0, h2=1, hDelay=14)),
    ("runjump-coast", [1, 0], dict(run=1, jumpAt=0, jumpHold=21, h1=1, h2=0, hDelay=2)),
    ("runjump-back", [1, 0], dict(run=1, jumpAt=0, jumpHold=21, h1=1, h2=-1, hDelay=6)),
    ("dj5", [1, 0], dict(jumpAt=0, jumpHold=21, djAt=5, h1=1, h2=1, need="dj")),
    ("dj10", [1, 0], dict(jumpAt=0, jumpHold=21, djAt=10, h1=1, h2=1, need="dj")),
    ("dj15", [1, 0], dict(jumpAt=0, jumpHold=21, djAt=15, h1=1, h2=1, need="dj")),
    ("djup", [1, 0], dict(jumpAt=0, jumpHold=21, djAt=12, h1=0, h2=1, hDelay=14, need="dj")),
    ("djup2", [1, 0], dict(jumpAt=0, jumpHold=21, djAt=14, h1=0, h2=0, hDelay=99, need="dj")),
    ("rundj", [1, 0], dict(run=1, jumpAt=0, jumpHold=21, djAt=10, h1=1, h2=1, need="dj")),
    ("ad4", [0, 1], dict(jumpAt=0, jumpHold=21, adAt=4, h1=1, h2=1, need="ad")),
    ("ad10", [0, 1], dict(jumpAt=0, jumpHold=21, adAt=10, h1=1, h2=1, need="ad")),
    ("ad16", [0, 1], dict(jumpAt=0, jumpHold=21, adAt=16, h1=1, h2=1, need="ad")),
    ("runad", [0, 1], dict(run=1, jumpAt=0, jumpHold=21, adAt=8, h1=1, h2=1, need="ad")),
    ("upad", [0, 1], dict(jumpAt=0, jumpHold=21, adAt=12, h1=0, h2=1, hDelay=12, need="ad")),
    ("djad", [0, 1], dict(jumpAt=0, jumpHold=21, djAt=10, adAt=18, h1=1, h2=1, need="dj,ad")),
    ("addj", [0, 1], dict(jumpAt=0, jumpHold=21, adAt=8, djAt=16, h1=1, h2=1, need="dj,ad")),
    ("dashjump1", [0], dict(gdAt=0, jumpAt=1, jumpHold=21, h1=1, h2=1, need="gd")),
    ("dashjump4", [0], dict(gdAt=0, jumpAt=4, jumpHold=21, h1=1, h2=1, need="gd")),
    ("dashjumpdj", [0], dict(gdAt=0, jumpAt=2, jumpHold=21, djAt=12, h1=1, h2=1, need="gd,dj")),
    ("dashjumpad", [0], dict(gdAt=0, jumpAt=2, jumpHold=21, adAt=12, h1=1, h2=1, need="gd,ad")),
    ("hopdash", [1], dict(gdAt=0, h1=1, h2=1, need="gd")),
    ("hopdashdj", [1], dict(gdAt=0, djAt=8, h1=1, h2=1, need="gd,dj")),
    ("hopdashad", [1], dict(gdAt=0, adAt=8, h1=1, h2=1, need="gd,ad")),
]
MOVES = [M(*m) for m in MOVES] + [
    # the High Jump Boots (Gate 5 only): straight up, and with a double jump; the plain jump there too
    M("g5jumpup", [1, 0], dict(jumpAt=0, jumpHold=40, h1=0, h2=0), items="jump double", **GATE5),
    M("hijumpup1", [1, 0], dict(jumpAt=0, jumpHold=40, h1=0, h2=0, hiJump=1), items="jump double hjb=1", **GATE5),
    M("hijumpup2", [1, 0], dict(jumpAt=0, jumpHold=40, h1=0, h2=0, hiJump=2), items="jump double hjb=2", **GATE5),
    M("hijumpdj1", [1, 0], dict(jumpAt=0, jumpHold=40, djAt=16, h1=0, h2=0, hiJump=1, need="dj"), items="jump double hjb=1", **GATE5),
    M("hijumpdj2", [1, 0], dict(jumpAt=0, jumpHold=40, djAt=16, h1=0, h2=0, hiJump=2, need="dj"), items="jump double hjb=2", **GATE5),
    # the Morph Ball (Claire with the Samus set's Morph Ball, Action C): rolling, and turning into it in a jump
    M("roll", [1], dict(h1=1, h2=1, maxT=30, morph=1), items="jump samus=2"),
    M("jumpmorph8", [1], dict(jumpAt=0, jumpHold=21, morphAt=8, h1=1, h2=1), items="jump samus=2"),
    M("jumpmorph14", [1], dict(jumpAt=0, jumpHold=21, morphAt=14, h1=1, h2=1), items="jump samus=2"),
    # wall jumps (Megapolis): up one wall, and between the two
    M("wallclimb", [1, 0], dict(jumpAt=0, jumpHold=21, h1=1, h2=1, wallMode=0, maxT=160), **SHAFT),
    M("wallzigzag", [1, 0], dict(jumpAt=0, jumpHold=21, h1=1, h2=1, wallMode=1, maxT=160), **SHAFT),
    # up and down Central City - North's slope (x 1690-1740, up to the floor at y 240)
    M("slope-up", [1, 0], dict(h1=1, h2=1, maxT=45), x=1560),
    M("slope-down", [1, 0], dict(dir=-1, h1=1, h2=1, maxT=45), x=1850, y=230),
    # off a Strike Chain point (Grand Rising's at 72,1880): the player is put hanging from it (grappleState 3, as the
    # chain's pull leaves them), then jumps off as the logic's hang moves do (RoomLogic.cs HangPrograms)
    M("hangjumpup", [1, 0], dict(fromHang=1, jumpAt=0, jumpHold=21, h1=0, h2=0), room="rMain_1", x=72, y=1880, items="jump double airdash mega=4", hang=True),
    M("hangjump", [1, 0], dict(fromHang=1, jumpAt=0, jumpHold=21, h1=1, h2=1), room="rMain_1", x=72, y=1880, items="jump double airdash mega=4", hang=True),
    M("hangjumpdj", [1, 0], dict(fromHang=1, jumpAt=0, jumpHold=21, djAt=12, h1=0, h2=1, hDelay=12, need="dj"), room="rMain_1", x=72, y=1880, items="jump double airdash mega=4", hang=True),
    M("hangdrop", [1, 0], dict(fromHang=1, hangDrop=1, h1=1, h2=1), room="rMain_1", x=72, y=1880, items="jump double airdash mega=4", hang=True),
    # a large spring scaled 1.5 (the Boss Gallery's at 320,1344: it keeps the player going up for round(7*1.5) ticks),
    # hopped onto from the floor beside it
    M("spring15", [1, 0], dict(jumpAt=0, jumpHold=2, h1=1, h2=1, maxT=120), room="rBossGallery", x=250, y=1370, items="jump"),
    # Gate 5's Morph Ball tunnel in Lv2_M (y 64-80, x 1584-1903) over a hole 16px wide (x 1792-1807): rolling over it
    # from the tunnel's start (rolled into from the floor below: the Metroid blocks taken away first)
    M("g5gap", [1], dict(h1=1, h2=1, hDelay=1, noInputTillAir=1, maxT=60, morph=1, open=1), room="rSamus5_Lv2_M",
      x=1582, y=81, items="jump samus=6", goto=("rSamus5_Lv2_M", 1560, 127),
      setup=["exec with (oBreakableMetroidWall) {instance_destroy()}", "exec with (oPlayer1) {x=1582; y=81; xVel=0; yVel=0}",
             "wait 10"]),
    # Gate 3's 6A: onto the large spring beside the ledge (736,561), then left and a double jump, for the platform at x
    # 650-710, y 353 (the logic's way up there at 30fps, with its 95% jumps: at the game's own strength it flies past
    # the platform at every frame rate)
    M("g3spring", [1], dict(dir=-1, jumpAt=0, jumpHold=2, h1=0, h2=1, afterBounce=1, djAt=18, need="dj", maxT=120),
      room="rBelmont3_6A", x=736, y=561, items="jump double"),
    # bouncing off latch crystals (Gate 6's City of Dreams F: a row of them over a pit, from the floor at 91,801): the
    # sword (Jerry with the Link set on), the whip (Claire, the Belmont set), the Blade Strike (Claire, Gate 6's set),
    # the attack pressed again each time it can be
    M("pogo-sword", [0], dict(jumpAt=0, jumpHold=21, h1=1, h2=1, weapon=0, atkAt=0, atkEvery=10, maxT=160),
      room="rGame6_CoDF", x=91, y=800, items="jump link=1", setup=["exec global.activeAbility[0]=1"] + NO_FOES),
    M("pogo-whip", [1], dict(jumpAt=0, jumpHold=21, h1=1, h2=1, weapon=1, atkAt=0, atkEvery=12, maxT=160),
      room="rGame6_CoDF", x=91, y=800, items="jump belmont=1", setup=["exec global.activeAbility[1]=1"] + NO_FOES),
    M("pogo-blade", [1], dict(jumpAt=0, jumpHold=21, h1=1, h2=1, weapon=2, atkAt=6, atkEvery=10, maxT=160),
      room="rGame6_CoDF", x=91, y=800, items="jump cgame=1", setup=["exec global.activeAbility[1]=3", "exec global.hudGame_WeaponEn[0]=150"] + NO_FOES),
    # under water
    M("water-walk", [1, 0], dict(h1=1, h2=1, maxT=30), **WATER),
    M("water-jumpup", [1, 0], dict(jumpAt=0, jumpHold=21, h1=0, h2=0), **WATER),
    M("water-jump21", [1, 0], dict(jumpAt=0, jumpHold=21, h1=1, h2=1), **WATER),
    M("water-dj10", [1, 0], dict(jumpAt=0, jumpHold=21, djAt=10, h1=1, h2=1, need="dj"), **WATER),
]
MOVE_BY_ID = {m["id"]: m for m in MOVES}
KEYNAME = {"L": "left", "R": "right", "J": "jump", "D": "down", "DL": "dashl", "DR": "dashr", "C": "c", "A": "a"}
SIM_EXTRA = []   # more RoomLogic.exe --move fields for every move (--sim-extra)
CHNAME = {0: "jerry", 1: "claire"}


def sim(m, ch, slack=1, fps=30, dither=None):
    """the simulation's move m as character ch at that frame rate (above 30fps from that ditherCounter): its start, its
    path tick by tick, where it lands"""
    args = [EXE, "--move", PROJ, ROOMS, m["room"], str(m["x"]), str(m["y"]), "ch=%d" % ch, "dir=1"]
    for k, v in m["fields"].items():
        args.append("%s=%s" % (k, v))
    if fps != 30:
        args.append("fps=%d" % fps)
        if dither is not None:
            args.append("dither=%d" % dither)
    args += SIM_EXTRA
    args += ["--slack", str(slack)]
    out = subprocess.run(args, capture_output=True, text=True).stdout
    path, land, start = [], None, None
    frames = []
    for l in out.splitlines():
        f = l.split()
        if not f:
            continue
        if f[0] == "ERROR":
            raise SystemExit("RoomLogic.exe --move: " + l)
        if f[0] == "START":
            start = (int(f[1]), int(f[2]))
        elif f[0] == "T":
            path.append(dict(t=int(f[1]), x=int(f[2]), y=int(f[3]), xv=float(f[4]), yv=float(f[5]), st=int(f[6]), keys=f[7],
                             morph=int(f[8]) if len(f) > 8 else 0))
        elif f[0] == "F":
            frames.append(dict(t=int(f[1]), fr=int(f[2]), x=int(f[3]), y=int(f[4]), xv=float(f[5]), yv=float(f[6]), st=int(f[7]), dither=int(f[8])))
        elif f[0] == "LAND":
            land = (int(f[1]), int(f[2]), int(f[3]))
    sim.frames = frames
    return start, path, land


def diag(game, m, ch, fps, dither, t30, speed, after=6, before=6):
    """one move in the game and the simulation, frame by frame, side by side up to a few frames past where they part"""
    start, path, land = sim(m, ch, fps=fps, dither=dither)
    sframes = sim.frames if fps != 30 else [dict(t=p["t"], fr=0, x=p["x"], y=p["y"], xv=p["xv"], yv=p["yv"], st=p["st"], dither=0) for p in path]
    text = script([(m, ch, start, path, land)], fps, 0, speed, t30, dither if fps != 30 else None)
    cmd = os.path.join(OUTDIR, "diag_cmds.txt")
    open(cmd, "w", encoding="utf-8").write(text)
    lt.run(game, cmd, 600, quiet=True)
    out = open(os.path.join(lt.ltdir(game), "out.txt"), "rb").read().decode("cp1252", "replace")
    g = parse_game(out)[(m["id"], ch, fps, 0)]
    gf = [(x - g["x0"], y - g["y0"], xv, yv) for (f, x, y, xv, yv) in g["frames"] if f > g["f0"]]
    sx0, sy0 = start
    keys = [p["keys"] for p in path]
    print("%s %s %dfps (dither %s): frame tick | game x,y vel | sim x,y vel state dither | keys" % (m["id"], CHNAME[ch], fps, dither))
    rows, parted = [], None
    for i, sf in enumerate(sframes):
        if i >= len(gf):
            break
        gx, gy, gxv, gyv = gf[i]
        sx, sy = sf["x"] - sx0, sf["y"] - sy0
        # (parted: the place, or the speed, differs)
        same = (gx, gy) == (sx, sy) and abs(gxv - sf["xv"]) < 0.0015 and abs(gyv - sf["yv"]) < 0.0015
        if not same and parted is None:
            parted = i
        rows.append("%4d t%-3d | %5g,%-5g %7.3f,%-7.3f | %5d,%-5d %7.3f,%-7.3f st%d d%d | %s%s" % (i, sf["t"], gx, gy, gxv, gyv, sx, sy, sf["xv"], sf["yv"], sf["st"], sf["dither"], keys[sf["t"]] if sf["t"] < len(keys) else "", "" if same else "  <<"))
    if parted is None:
        print("  the same every frame (%d frames)" % len(rows))
    else:
        print("\n".join(rows[max(0, parted - before):parted + after + 1]))


def tick_keys(path, morph_start):
    """the input each tick: the simulation's, with Action C (turning into the Morph Ball and back) a tick before its
    morph changes: the game turns the player at the end of the step C is pressed in (playerTechStart, after the move),
    where the simulation's morph is on from the start of its tick"""
    keys = [p["keys"] for p in path]
    was = morph_start
    for t, p in enumerate(path):
        if p["morph"] != was and t > 0:
            k = keys[t - 1]
            keys[t - 1] = "C" if k == "-" else k + "+C"
        was = p["morph"]
    return keys


def segments(keys, extra, fps=30):
    """input tick by tick as LogicTest holdf lines (then holding nothing for extra ticks). Above 30fps a tick is several
    frames; Action C is pressed on its tick's last frame only (the morph comes at the end of that frame, as the
    simulation's comes at the start of the next tick)"""
    fpt = fps // 30
    frames = []
    for k in keys + ["-"] * extra:
        if "C" in k.split("+"):
            rest = "+".join(x for x in k.split("+") if x != "C") or "-"
            frames += [rest] * (fpt - 1) + [k]
        else:
            frames += [k] * fpt
    out, i = [], 0
    while i < len(frames):
        j = i
        while j < len(frames) and frames[j] == frames[i]:
            j += 1
        names = "none" if frames[i] == "-" else "+".join(KEYNAME[k] for k in frames[i].split("+"))
        out.append("holdf %s %d" % (names, j - i))
        i = j
    return out


def script(jobs, fps, phase, speed, t30=None, dither=None):
    """a LogicTest run: each job (move, ch, sim start, path, landing) from a standing (or running, or rolling) start,
    the path traced. t30: the game's 30fps timer (oGame.time30, which the 30fps rounding goes by: moveTo30) set to that
    as the move starts, so its rounding is the simulation's (VelInt, whose tick count starts at 0). dither: the same for
    the rounding above 30fps (the player's ditherCounter: pMoveTo)"""
    s = ["# calib.py: fps %d, input from frame %d of a tick" % (fps, phase), "god", "speed %d" % speed, "fps %d" % fps]
    for (m, ch, start, path, land) in jobs:
        f = m["fields"]
        run, morph = str(f.get("run", 0)) == "1", str(f.get("morph", 0)) == "1"
        s += ["log move %s ch %d fps %d phase %d" % (m["id"], ch, fps, phase), "items " + m["items"], "char " + CHNAME[ch]]
        if m.get("hang"):
            # (hanging from the point at x,y, 40px under it: grappleState 3 holds the player there)
            px, py = m["x"], m["y"]
            s += ["goto %s %d %d" % (m["room"], px, py + 40),
                  "exec with (oPlayer1) {grappleID=instance_nearest(%d,%d,oStrikeChainPoint); grappleState=3; x=%d; y=%d; xVel=0; yVel=0; xAcc=0; yAcc=0; canAirDash=1; doubleJumpCheck=1; state=FALLING}" % (px, py, px, py + 40),
                  "wait 10"]
        else:
            # (goto: somewhere else to go first, where the move's start can't be stood on: setup puts the player there)
            gr, gx, gy = m.get("goto", (m["room"], m["runfrom"] if run else m["x"], m["y"]))
            s += ["goto %s %d %d" % (gr, gx, gy), "wait 20"]
        if morph:
            s += ["hold c 1", "wait 10"]
        s += m.get("setup", [])
        if phase:
            s.append("waitf %d" % phase)
        if run:
            s.append("hold right %d" % m["runup"])
        s += ["get gDeltaTick", "pos", "tracef 1"]
        if t30 is not None:
            s.append("exec oGame.time30=%d" % t30)
        if dither is not None:
            s.append("exec oPlayer1.ditherCounter=%d" % dither)
        s += segments(tick_keys(path, 1 if morph else 0), 30 if land else 10, fps)
        s += ["tracef 0"]
    # (left on dry ground: in the water rooms the player drowns once the run, and its god mode, is over)
    s += ["goto %s %d %d" % (FLAT["room"], FLAT["x"], FLAT["y"]), "wait 5"]
    return "\n".join(s) + "\n"


POS = re.compile(r"(?:pos|t) f(\d+) (\S+) (-?[\d.]+),(-?[\d.]+)(?: v (-?[\d.]+),(-?[\d.]+))?")


def parse_game(out):
    """the game's paths: {(id, ch, fps, phase): dict(f0, x0, y0, dtick, frames=[(f, x, y, xv, yv)])}"""
    res, cur = {}, None
    for l in out.splitlines():
        m = re.match(r"log move (\S+) ch (\d+) fps (\d+) phase (\d+)", l)
        if m:
            cur = dict(key=(m.group(1), int(m.group(2)), int(m.group(3)), int(m.group(4))), frames=[], f0=None)
            res[cur["key"]] = cur
            continue
        if cur is None:
            continue
        if l.startswith("get gDeltaTick"):
            cur["dtick"] = float(l.split()[2])
            continue
        m = POS.match(l)
        if m:
            f, x, y = int(m.group(1)), float(m.group(3)), float(m.group(4))
            xv = float(m.group(5)) if m.group(5) else 0.0
            yv = float(m.group(6)) if m.group(6) else 0.0
            if l.startswith("pos"):
                cur.update(f0=f, x0=x, y0=y)
            elif cur["f0"] is not None:
                cur["frames"].append((f, x, y, xv, yv))
    return res


def game_ticks(g, fps):
    """the game's place at the end of each tick of the move: [(dx, dy)]"""
    fpt = fps // 30
    by = {f: (x, y) for (f, x, y, xv, yv) in g["frames"]}
    out, t = [], 0
    while True:
        f = g["f0"] + (t + 1) * fpt
        if f not in by:
            break
        x, y = by[f]
        out.append((x - g["x0"], y - g["y0"]))
        t += 1
    return out


def landing(ticks):
    """the first tick the path is back at its starting height after being above it, and dx there (None: no landing)"""
    up = False
    for t, (dx, dy) in enumerate(ticks):
        if dy < 0:
            up = True
        elif up and dy >= 0:
            return t, dx
    return None


def compare(sim_path, start, gt):
    """differences: apex (px, game minus sim), landing tick and dx, the path's largest |dx| and |dy| difference"""
    sx0, sy0 = start
    st = [(p["x"] - sx0, p["y"] - sy0) for p in sim_path]
    n = min(len(st), len(gt))
    s_apex = -min([0] + [dy for dx, dy in st])
    g_apex = -min([0] + [dy for dx, dy in gt])
    s_land, g_land = landing(st), landing(gt)
    mdx = max([abs(gt[i][0] - st[i][0]) for i in range(n)] or [0])
    mdy = max([abs(gt[i][1] - st[i][1]) for i in range(n)] or [0])
    return dict(s_apex=s_apex, g_apex=g_apex, s_land=s_land, g_land=g_land, mdx=mdx, mdy=mdy, n=n,
                s_end=st[n - 1] if n else (0, 0), g_end=gt[n - 1] if n else (0, 0))


def fmt_land(l):
    return "-" if l is None else "t%d dx %+d" % (l[0], l[1])


LOGIC_SLACK = 0.95   # RoomLogic.cs Sim.Slack: the logic's moves


def logic_paths():
    """each move's path as the logic has it (Sim.Slack 0.95): {(id, ch): (dx,dy) per tick}"""
    out = {}
    for m in MOVES:
        for ch in m["chs"]:
            start, path, land = sim(m, ch, slack=LOGIC_SLACK)
            out[(m["id"], ch)] = [(p["x"] - start[0], p["y"] - start[1]) for p in path]
    return out


def report(measured, logic=None):
    """one line a move, character, frame rate and phase: the game's apex and landing against the simulation's at the
    game's strength (sim) and the logic's (95%: logic, if given). "<<" marks a game path short of the logic's: the logic
    counts on more than the game does there"""
    lines = []
    ids = [m["id"] for m in MOVES]
    for key in sorted(measured, key=lambda k: (ids.index(k[0]) if k[0] in ids else 999, k[1], k[2], k[3])):
        e = measured[key]
        c = compare(e["sim"], e["start"], e["game"])
        mid, ch, fps, phase = key
        lg = ""
        flag = ""
        if logic is not None and (mid, ch) in logic:
            lp = logic[(mid, ch)]
            l_apex = -min([0] + [dy for dx, dy in lp])
            l_land = landing(lp)
            lg = "  logic apex %3d land %-12s" % (l_apex, fmt_land(l_land))
            if c["g_apex"] < l_apex or (l_land and c["g_land"] and c["g_land"][1] < l_land[1]):
                flag = "  << short of the logic"
        lines.append("%-14s %-6s %3dfps p%d  apex game %3d sim %3d (%+d)  land game %-12s sim %-12s%s  path max |dx| %3d |dy| %3d over %d ticks%s"
                     % (mid, CHNAME[ch], fps, phase, c["g_apex"], c["s_apex"], c["g_apex"] - c["s_apex"],
                        fmt_land(c["g_land"]), fmt_land(c["s_land"]), lg, c["mdx"], c["mdy"], c["n"], flag))
    return "\n".join(lines)


def save(path, measured):
    with open(path, "w", encoding="utf-8", newline="\n") as f:
        f.write("# calib.py: the game's paths and the simulation's (RoomLogic.exe --move --slack 1), each move from its own place (MOVES)\n")
        f.write("# move ID ch C fps F phase P start X,Y dtick D\n#   game dx,dy per tick\n#   sim dx,dy per tick ; land\n")
        for key, e in measured.items():
            mid, ch, fps, phase = key
            f.write("move %s ch %d fps %d phase %d start %g,%g dtick %s\n" % (mid, ch, fps, phase, e["gx0"], e["gy0"], e.get("dtick", "?")))
            f.write("  game " + " ".join("%g,%g" % p for p in e["game"]) + "\n")
            sx0, sy0 = e["start"]
            f.write("  sim " + " ".join("%d,%d" % (p["x"] - sx0, p["y"] - sy0) for p in e["sim"]) + " ; " + str(e["land"]) + "\n")
            f.write("  keys " + " ".join(p.get("keys", "?") for p in e["sim"]) + "\n")


def load(path):
    measured = {}
    cur = None
    for l in open(path, encoding="utf-8"):
        if l.startswith("#") or not l.strip():
            continue
        f = l.split()
        if f[0] == "move":
            key = (f[1], int(f[3]), int(f[5]), int(f[7]))
            gx0, gy0 = map(float, f[9].split(","))
            cur = measured[key] = dict(gx0=gx0, gy0=gy0, dtick=f[11])
        elif f[0] == "game":
            cur["game"] = [tuple(map(float, p.split(","))) for p in f[1:]]
        elif f[0] == "sim":
            semi = f.index(";")
            cur["sim"] = [dict(x=int(p.split(",")[0]), y=int(p.split(",")[1])) for p in f[1:semi]]
            cur["start"] = (0, 0)
            land = " ".join(f[semi + 1:])
            cur["land"] = None if land == "None" else tuple(int(v) for v in re.findall(r"-?\d+", land))
        elif f[0] == "keys":
            for p, k in zip(cur["sim"], f[1:]):
                p["keys"] = k
    return measured


def verify(game, ids, chars, fps_list, dither, t30, speed):
    """the moves in the game and in the simulation, frame by frame up to where the simulation stops (its landing frame
    included): the moves where any frame differs, and where it first does"""
    bad, total = [], 0
    for fps in fps_list:
        jobs, frames = [], {}
        for m in MOVES:
            if ids and m["id"] not in ids:
                continue
            for ch in m["chs"]:
                if ch in chars:
                    start, path, land = sim(m, ch, fps=fps, dither=dither)
                    sf = sim.frames if fps != 30 else [dict(x=p["x"], y=p["y"]) for p in path]
                    jobs.append((m, ch, start, path, land))
                    frames[(m["id"], ch)] = (start, sf)
        text = script(jobs, fps, 0, speed, t30, dither if fps != 30 else None)
        cmd = os.path.join(OUTDIR, "verify_cmds.txt")
        open(cmd, "w", encoding="utf-8").write(text)
        lt.run(game, cmd, 3600, quiet=True)
        out = open(os.path.join(lt.ltdir(game), "out.txt"), "rb").read().decode("cp1252", "replace")
        got = parse_game(out)
        for (m, ch, start, path, land) in jobs:
            total += 1
            g = got.get((m["id"], ch, fps, 0))
            if not g or g["f0"] is None:
                bad.append("%s %s %dfps: no game path" % (m["id"], CHNAME[ch], fps))
                continue
            gf = [(x - g["x0"], y - g["y0"]) for (f, x, y, xv, yv) in g["frames"] if f > g["f0"]]
            (sx0, sy0), sf = frames[(m["id"], ch)]
            n = min(len(gf), len(sf))
            worst, first = 0, None
            for i in range(n):
                d = max(abs(gf[i][0] - (sf[i]["x"] - sx0)), abs(gf[i][1] - (sf[i]["y"] - sy0)))
                if d > 0 and first is None:
                    first = i
                worst = max(worst, d)
            if worst > 0:
                bad.append("%s %s %dfps: up to %gpx, from frame %d (of %d)" % (m["id"], CHNAME[ch], fps, worst, first, n))
    return bad, total


def stand(game, room, x0, x1, ytop, step=1):
    """where the player stands at each x from x0 to x1, dropped from ytop: the game's against the simulation's standing
    places (its regions: RoomLogic.exe --move's START), for checking the room's shapes (a slope's pixels)"""
    s = ["# calib.py stand: %s x %d-%d" % (room, x0, x1), "god"]
    for x in range(x0, x1 + 1, step):
        s += ["goto %s %d %d" % (room, x, ytop), "wait 25", "pos"]
    s += ["goto %s %d %d" % (FLAT["room"], FLAT["x"], FLAT["y"]), "wait 5"]
    cmd = os.path.join(OUTDIR, "stand_cmds.txt")
    open(cmd, "w", encoding="utf-8").write("\n".join(s) + "\n")
    lt.run(game, cmd, 3600, quiet=True)
    out = open(os.path.join(lt.ltdir(game), "out.txt"), "rb").read().decode("cp1252", "replace")
    got = [tuple(float(v) for v in m.groups()) for m in re.finditer(r"^pos f\d+ \S+ (-?[\d.]+),(-?[\d.]+)", out, re.M)]
    rows = []
    for (gx, gy) in got:
        o = subprocess.run([EXE, "--move", PROJ, ROOMS, room, str(int(gx)), str(ytop), "ch=0", "dir=1", "h1=0", "h2=0", "maxT=1"],
                           capture_output=True, text=True).stdout
        m = re.search(r"START (-?\d+) (-?\d+)", o)
        sy = int(m.group(2)) if m else None
        rows.append((int(gx), int(gy), sy))
    return rows


def regression(old, new):
    """the game's paths of a new run against a kept one (the game's movement changed?): the moves whose paths differ"""
    out = []
    for key in sorted(new):
        if key not in old:
            continue
        a, b = old[key]["game"], new[key]["game"]
        n = min(len(a), len(b))
        worst = max([max(abs(a[i][0] - b[i][0]), abs(a[i][1] - b[i][1])) for i in range(n)] or [0])
        if worst > 0 or len(a) != len(b):
            out.append("%s %s %dfps p%d: the game's path moved up to %gpx (%d ticks against %d)" % (key[0], CHNAME[key[1]], key[2], key[3], worst, len(b), len(a)))
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("what", choices=["run", "report", "list", "check", "diag", "verify", "stand"])
    ap.add_argument("game", nargs="?")
    ap.add_argument("--moves", default="")
    ap.add_argument("--chars", default="0,1")
    ap.add_argument("--fps", default="30,60,120")
    ap.add_argument("--speed", type=int, default=8)
    ap.add_argument("--out", default="measured")
    ap.add_argument("--t30", type=int, default=None, help="the game's 30fps timer as each move starts (oGame.time30)")
    ap.add_argument("--dither", type=int, default=None, help="the player's ditherCounter as each move starts (above 30fps)")
    ap.add_argument("--phases", default="1", help="how many of a tick's frames the input starts on above 30fps: 1, or all")
    ap.add_argument("--sim-extra", default="", help="more RoomLogic.exe --move fields for every move, e.g. oldexe=1")
    a = ap.parse_args()
    if a.what == "list":
        for m in MOVES:
            print(m["id"], m["chs"], m["room"], m["fields"])
        return
    os.makedirs(OUTDIR, exist_ok=True)
    if a.what == "report":
        print(report(load(a.game or os.path.join(OUTDIR, a.out + ".txt")), logic_paths()))
        return
    want = set(a.moves.split(",")) if a.moves else None
    chars = [int(c) for c in a.chars.split(",")]
    if a.sim_extra:
        SIM_EXTRA[:] = a.sim_extra.split()
    if a.what == "diag":
        for mid in a.moves.split(","):
            for ch in chars:
                for fps in [int(x) for x in a.fps.split(",")]:
                    diag(a.game, MOVE_BY_ID[mid], ch, fps, a.dither, a.t30, a.speed)
        return
    if a.what == "stand":
        # --moves ROOM,X0,X1,YTOP: where the player stands across that stretch, game and simulation
        room, x0, x1, ytop = a.moves.split(",")
        rows = stand(a.game, room, int(x0), int(x1), int(ytop))
        for gx, gy, sy in rows:
            print("x %5d  game y %5d  sim y %5s%s" % (gx, gy, sy, "" if gy == sy else "  <<"))
        return
    if a.what == "verify":
        bad, total = verify(a.game, want, chars, [int(x) for x in a.fps.split(",")], a.dither, a.t30, a.speed)
        print("\n".join(bad))
        print("%d of %d moves the same in every frame" % (total - len(bad), total))
        raise SystemExit(1 if bad else 0)
    measured = {}
    t0 = time.time()
    for fps in [int(x) for x in a.fps.split(",")]:
        # (the simulation at the game's frame rate, its input for the game: a move's input can depend on where it is,
        # a wall jump's for one)
        jobs = []
        for m in MOVES:
            if want and m["id"] not in want:
                continue
            for ch in m["chs"]:
                if ch in chars:
                    start, path, land = sim(m, ch, fps=fps, dither=a.dither)
                    jobs.append((m, ch, start, path, land))
        if fps == 30 or a.phases == "1":
            phases = [0]
        else:
            phases = range(fps // 30)
        print("%d move(s) to run at %dfps" % (len(jobs), fps))
        for phase in phases:
            text = script(jobs, fps, phase, a.speed, a.t30, a.dither if fps != 30 else None)
            cmd = os.path.join(OUTDIR, "run_cmds.txt")
            open(cmd, "w", encoding="utf-8").write(text)
            d = lt.ltdir(a.game)
            for fn in ("done.txt", "out.txt"):
                if os.path.exists(os.path.join(d, fn)):
                    os.remove(os.path.join(d, fn))
            rc = lt.run(a.game, cmd, 3600, quiet=True)
            out = open(os.path.join(d, "out.txt"), "rb").read().decode("cp1252", "replace")
            if rc != 0:
                print(out[-2000:])
                raise SystemExit("the game's run failed (fps %d phase %d)" % (fps, phase))
            got = parse_game(out)
            for (m, ch, start, path, land) in jobs:
                g = got.get((m["id"], ch, fps, phase))
                if not g or g["f0"] is None:
                    print("no game path for", m["id"], ch, fps, phase)
                    continue
                measured[(m["id"], ch, fps, phase)] = dict(game=game_ticks(g, fps), sim=path, start=start, land=land,
                                                           gx0=g["x0"], gy0=g["y0"], dtick=g.get("dtick", "?"))
            print("fps %d phase %d done (%.0f s so far)" % (fps, phase, time.time() - t0))
    path = os.path.join(OUTDIR, a.out + ".txt")
    if a.what == "check":
        # the kept paths (calib\<out>.txt) against this run's: nothing written
        diffs = regression(load(path), measured)
        print("\n".join(diffs) if diffs else "the game's paths are as kept (%d)" % len(measured))
        raise SystemExit(1 if diffs else 0)
    # (added to what the file had: a run of some moves replaces only theirs)
    old = load(path) if os.path.exists(path) else {}
    old.update(measured)
    save(path, old)
    rep = report(load(path), logic_paths())
    open(os.path.join(OUTDIR, a.out + "_report.txt"), "w", encoding="utf-8", newline="\n").write(rep + "\n")
    print(rep)


if __name__ == "__main__":
    main()
