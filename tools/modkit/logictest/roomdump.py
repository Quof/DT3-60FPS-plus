r"""
roomdump.py: the rooms as the game makes them, against the room logic's view of them. The game (LogicTest) goes into
each room the logic has, by each of its ways in (the room files' "in X,Y"), waits a moment and writes every instance
(LogicTest's dump: what the rooms' code, their objects' Create, Step and Alarm events and the Randomizer's own changes
have left there); compare reads those and roomdata.py's work\rooms.txt and lists what differs, kind by kind: exits
(made by code, taken away, leading elsewhere), solids and gates, platforms, hazards, water, springs, Strike Chain
points, places. A thing only some ways in have is marked with them.

  python roomdump.py run <game> [--rooms R,...] [--frames N] [--batch N] [--speed N] [--exe NAME] [--resume]
                     the dumps (the game running a LogicTest game: tests\roomdump_start.txt), into
                     <game>\Mods\LogicTest\dumps. A way in where the game stops answering (an error message) goes in
                     calib\roomdump_errors.txt, and the game is started again (--exe); --resume: the ways in not dumped yet
  python roomdump.py compare <game> [--rooms R,...] [--out FILE]
                     the differences (default ..\randomizer\roomlogic\work\roomdump_compare.txt)
"""
import os, re, sys, time, argparse, collections
HERE = os.path.dirname(os.path.abspath(__file__))
RL = os.path.normpath(os.path.join(HERE, "..", "randomizer", "roomlogic"))
sys.path.insert(0, os.path.dirname(RL)); sys.path.insert(0, RL); sys.path.insert(0, HERE)
import lt

ROOMS_DIR = os.path.join(RL, "rooms")
ROOMS_TXT = os.path.join(RL, "work", "rooms.txt")
# (the rooms as roomdata.py reads their code, without gamestate.txt: what the game's are compared with, so the digest is
# every difference, not what's left after the last one)
BASE_TXT = os.path.join(RL, "work", "rooms_base.txt")


def make_base():
    """roomdata.py --base into BASE_TXT"""
    import subprocess
    print("the rooms as their code reads (roomdata.py --base)...")
    env = dict(os.environ, PYTHONIOENCODING="utf-8")
    r = subprocess.run([sys.executable, os.path.join(RL, "roomdata.py"), BASE_TXT, "--base"], capture_output=True, text=True, env=env)
    if r.returncode != 0: raise SystemExit("roomdata.py --base failed:\n" + r.stdout[-2000:] + r.stderr[-2000:])


def ways_in():
    """{room: [(x, y)]}: each room file's ways in"""
    out = {}
    for fn in sorted(os.listdir(ROOMS_DIR)):
        if not fn.endswith(".txt"): continue
        ws = []
        for l in open(os.path.join(ROOMS_DIR, fn), encoding="utf-8"):
            m = re.match(r"^in (-?\d+),(-?\d+)\b", l)
            if m: ws.append((int(m.group(1)), int(m.group(2))))
        out[fn[:-4]] = ws
    return out


def dump_name(room, x, y):
    return "%s@%d_%d" % (room, x, y)


# rooms the game can't be in (an error message every frame): rBT_ZeroC's timed barrier at 1120,272 looks for its ten
# switches by GID 468857-468866, but only the last switch's creation code sets one, so its Draw event reads noone.x
SKIP = {"rBT_ZeroC"}
START = os.path.join(HERE, "tests", "roomdump_start.txt")
ERRORS = os.path.join(HERE, "calib", "roomdump_errors.txt")


# the globals each room is come into with: as the new game has them (LogicTest's snap and restore), so what one room's
# code sets (the boss gallery's bBossGallery, a party split, the red and blue switches, abilities a room takes away...)
# isn't there in the next one's. Every one the game's code or the Randomizer's sets, but handles (data structures,
# surfaces, sounds), the test's and the mod framework's own, the input, the options, where the player's sent (goto sets
# it) and the area (from the room before, as in a game). Arrays: the elements the rooms' code sets, all made by a new
# game (initGameVars)
SNAP_ARRAYS = [("activeAbility", 2), ("charScan", 2), ("hasShoes", 4), ("hasAbilToken", 7), ("metCheckpoint", 3),
               ("mySegmentCheck", 3)]
SNAP_SKIP_PREFIX = ("lt", "mod", "gp", "ss", "snd", "msc", "opt")
SNAP_SKIP = {"newMapX", "newMapY", "gamePaused", "location", "saveDir", "paraString", "objectIDMap"}


def snap_names():
    import roomdata as rd
    files = []
    for sub in ("rooms", "objects", "scripts"):
        for dp, dn, fn in os.walk(os.path.join(rd.PROJ, sub)):
            files += [os.path.join(dp, f) for f in fn if f.endswith(".gml")]
    for dp, dn, fn in os.walk(os.path.join(os.path.dirname(RL), "mod")):
        files += [os.path.join(dp, f) for f in fn if f.endswith(".gml")]
    names, handles = set(), set()
    assign = re.compile(r"global\.([A-Za-z_]\w*)\s*(?:\+=|-=|\*=|/=|=)(?!=)")
    handle = re.compile(r"global\.([A-Za-z_]\w*)\s*=\s*\w+_(?:create|add|duplicate)\s*\(")
    for p in files:
        t = open(p, encoding="utf-8", errors="replace").read()
        names.update(assign.findall(t)); handles.update(handle.findall(t))
    out = sorted(n for n in names - handles - SNAP_SKIP if not n.startswith(SNAP_SKIP_PREFIX))
    return out + ["%s[%d]" % (n, i) for n, k in SNAP_ARRAYS for i in range(k)]


def snap(game):
    """snap.txt written, and the game's globals as they are now taken (after a new game)"""
    open(os.path.join(lt.ltdir(game), "snap.txt"), "w", encoding="cp1252", newline="\r\n").write("\n".join(snap_names()) + "\n")
    cmd = os.path.join(HERE, "calib", "roomdump_cmds.txt")
    open(cmd, "w", encoding="utf-8").write("snap\n")
    if lt.run(game, cmd, 60, quiet=True) != 0: raise SystemExit("snap didn't work: " + open(os.path.join(lt.ltdir(game), "out.txt"), "rb").read().decode("cp1252", "replace")[-500:])
    out = open(os.path.join(lt.ltdir(game), "out.txt"), "rb").read().decode("cp1252", "replace")
    m = re.search(r"^snap (\d+)", out, re.M)
    print("globals taken:", m.group(1) if m else "?")


def restart(game, exe):
    """the test copy closed (an error message holds it up) and started again, minimised without taking the focus, with a
    new LogicTest game (tests\\roomdump_start.txt)"""
    import subprocess
    subprocess.run(["taskkill", "/F", "/IM", os.path.basename(exe)], capture_output=True)
    time.sleep(2)
    si = subprocess.STARTUPINFO()
    si.dwFlags |= subprocess.STARTF_USESHOWWINDOW
    si.wShowWindow = 7   # SW_SHOWMINNOACTIVE
    subprocess.Popen([exe], cwd=game, startupinfo=si)
    time.sleep(10)
    if lt.run(game, START, 300, quiet=True) != 0:
        raise SystemExit("the test copy didn't start a game again (tests\\roomdump_start.txt)")
    snap(game)


def map_rooms():
    """the rooms that are maps (rooms.txt's Q and QW: an overworld or a menu, no player to put there)"""
    out, room = set(), None
    for l in open(ROOMS_TXT, encoding="utf-8"):
        f = l.rstrip("\n").split("\t")
        if f[0] == "R": room = f[1]
        elif f[0] in ("Q", "QW") and room: out.add(room)
    return out


def send(game, cmdfile, names, stall):
    """lt.run's sending and waiting, watching the dumps come: 0 the run ended, 1 it ended on an error, 2 the game stopped
    (no new dump for stall seconds: an error message holding it up)"""
    d = lt.ltdir(game)
    for f in ("done.txt", "out.txt"):
        p = os.path.join(d, f)
        if os.path.exists(p): os.remove(p)
    cmds = open(cmdfile, encoding="utf-8").read().replace("\r\n", "\n")
    with open(os.path.join(d, "cmd.tmp"), "w", encoding="cp1252", newline="\r\n") as f: f.write(cmds)
    os.replace(os.path.join(d, "cmd.tmp"), os.path.join(d, "cmd.txt"))
    dd = os.path.join(d, "dumps")
    last, seen = time.time(), 0
    while not os.path.exists(os.path.join(d, "done.txt")):
        n = sum(1 for nm in names if os.path.exists(os.path.join(dd, nm + ".txt")))
        if n > seen: seen, last = n, time.time()
        elif time.time() - last > stall:
            if os.path.exists(os.path.join(d, "cmd.txt")): os.remove(os.path.join(d, "cmd.txt"))
            return 2
        time.sleep(0.25)
    out = open(os.path.join(d, "out.txt"), "rb").read().decode("cp1252", "replace")
    return 1 if any(l.startswith("error") for l in out.splitlines()) else 0


# boss rooms are dumped as they are after their fight (the logic has the fight as going into the room): every boss beaten
BOSS_AFTER = 'exec global.rndBossDone=string_repeat("1",global.rndBossN)'


def boss_rooms():
    """the rooms with a boss fight (rooms.txt's B lines)"""
    out, room = set(), None
    for l in open(ROOMS_TXT, encoding="utf-8"):
        f = l.rstrip("\n").split("\t")
        if f[0] == "R": room = f[1]
        elif f[0] == "B" and room: out.add(room)
    return out


def run(game, rooms, frames, batch, speed, exe, resume, retry=False, after=()):
    d = os.path.join(lt.ltdir(game), "dumps")
    skip = SKIP | map_rooms()
    jobs = [(r, x, y) for r, ws in sorted(ways_in().items()) if (not rooms or r in rooms) and r not in skip for x, y in ws]
    # (not the ways in the game stopped in before, roomdump_errors.txt, unless asked: each holds the game up a while)
    bad = set()
    if os.path.exists(ERRORS) and not retry:
        for l in open(ERRORS, encoding="utf-8"):
            f = l.split(":")[0].split()
            if len(f) == 3: bad.add((f[0], int(f[1]), int(f[2])))
    jobs = [j for j in jobs if j not in bad]
    if resume:
        jobs = [j for j in jobs if not os.path.exists(os.path.join(d, dump_name(*j) + ".txt"))]
    print("%d ways in to dump" % len(jobs))
    snap(game)
    t0 = time.time()
    i = 0
    while i < len(jobs):
        part = jobs[i:i + batch]
        s = ["# roomdump.py: ways in %d-%d" % (i + 1, i + len(part)), "god", "speed %d" % speed, "fps 30"]
        for r, x, y in part:
            # (and a second dump a moment later: what moved between them is moving, not where it was made)
            s += ["restore"] + list(after) + ["goto %s %d %d" % (r, x, y), "waitf %d room" % frames, "dump %s" % dump_name(r, x, y),
                  "waitf %d room" % (2 * frames), "dump %s.2" % dump_name(r, x, y)]
        cmd = os.path.join(HERE, "calib", "roomdump_cmds.txt")
        open(cmd, "w", encoding="utf-8").write("\n".join(s) + "\n")
        for r, x, y in part:
            p = os.path.join(d, dump_name(r, x, y) + ".txt")
            if os.path.exists(p): os.remove(p)
        rc = send(game, cmd, [dump_name(*j) for j in part], 15)
        if rc != 0:
            # (the run ended on an error, or the game stopped answering (an error message): the first way in without
            # its dump is where. Noted, the game started again if it stopped, and on from the way in after it)
            out = ""
            if rc == 1: out = open(os.path.join(lt.ltdir(game), "out.txt"), "rb").read().decode("cp1252", "replace")
            why = ([l for l in out.splitlines() if l.startswith("error")] or ["the game stopped answering"])[0]
            k = next((n for n, j in enumerate(part) if not os.path.exists(os.path.join(d, dump_name(*j) + ".txt"))), None)
            if k is not None:
                print("%s in %d,%d: %s" % (part[k] + (why,)))
                with open(ERRORS, "a", encoding="utf-8") as f: f.write("%s %d %d: %s\n" % (part[k] + (why,)))
            if rc == 2: restart(game, exe)
            i += len(part) if k is None else k + 1
            continue
        i += len(part)
        print("%d of %d done (%.0f s)" % (i, len(jobs), time.time() - t0))
    # (a whole run: the boss rooms again, after their fights)
    if not rooms and not after:
        print("the boss rooms, after their fights:")
        run(game, boss_rooms(), frames, batch, speed, exe, False, retry, [BOSS_AFTER])


# ---------------------------------------------------------------- comparing
def logic_view():
    """{room: [(kind, shape, x, y, xs, ys, ang, extra)]} from roomdata.py's rooms.txt: kinds X exit, D door, L place,
    J spring, K chain point, H hazard, P platform, W water, S solid (gates, state blocks, moving ones too)"""
    kinds = {"S": "S", "T": "S", "G": "S", "N": "S", "U": "S", "PR": "S", "FP": "S", "TS": "S", "P": "P", "H": "H", "HV": "H",
             "W": "W", "TW": "W", "J": "J", "K": "K", "X": "X", "D": "D", "L": "L", "V": "V"}
    out, room = collections.defaultdict(list), None
    for l in open(BASE_TXT, encoding="utf-8"):
        f = l.rstrip("\n").split("\t")
        if f[0] == "R": room = f[1]; continue
        if room is None or f[0] not in kinds or len(f) < 7: continue
        try:
            geo = (f[1], float(f[2]), float(f[3]), float(f[4]), float(f[5]), float(f[6]))
        except ValueError:
            continue
        out[room].append((kinds[f[0]],) + geo + (tuple(f[7:]), f[0]))
    return out


def classify(proj, rd):
    """the logic's kind for a game object (as roomdata.py sorts them), or None"""
    cache = {}
    def kind(obj):
        if obj in cache: return cache[obj]
        ch = proj.chain(obj)
        k = None
        if obj in rd.MAP_EXITS or obj in rd.EXITS or obj in rd.FIXED_EXITS or obj == "oMetEleExit": k = "X"
        elif obj == "oMapDoor": k = "D"
        elif obj == rd.ELEVATOR: k = "V"
        elif obj in rd.LOCATIONS or obj == "oStoryObject": k = "L"
        elif obj in rd.SPRINGS: k = "J"
        elif obj in ("oStrikeChainPoint", "oStrikePoint_Ext"): k = "K"
        elif obj in rd.HAZARDS: k = "H"
        elif rd.PLATFORMS in ch or obj == "oPlatTempFade": k = "P"   # (a fading platform: roomdata.py's jump-through one)
        elif rd.WATER in ch: k = "W"
        elif "oSolid" in ch: k = "S"
        cache[obj] = k
        return k
    return kind


def read_dump(path):
    head, insts, gids = None, [], {}
    for l in open(path, encoding="cp1252", errors="replace"):
        f = l.rstrip("\r\n").split("\t")
        if f[0] == "R": head = f
        elif f[0] == "I" and len(f) >= 19:
            v = {}
            for kv in f[19:]:
                if "=" in kv: k, val = kv.split("=", 1); v[k] = val
            insts.append(dict(id=int(f[1]), obj=f[2], x=float(f[3]), y=float(f[4]), xs0=float(f[5]), ys0=float(f[6]),
                              xs=float(f[7]), ys=float(f[8]), ang=float(f[9]), spr=f[10], msk=f[11],
                              bbox=tuple(float(t) for t in f[12:16]), solid=f[16], vis=f[17], v=v))
        elif f[0] == "G" and len(f) == 3:
            gids[f[1]] = f[2]
    return head, insts, gids


def r1(v): return round(float(v))


_SPR = {}


def sprite_box(name):
    """a sprite's collision box in its own pixels and its origin: (left, top, right, bottom, ox, oy), as the game has it
    (RoomLogic.cs Mask: bbox_type 0 worked out from every frame's pixels, 1 the whole image, 2 as stored), or None"""
    if name in _SPR: return _SPR[name]
    import roomdata as rd
    from PIL import Image
    d = os.path.join(rd.PROJ, "sprites", name)
    k = rd.kv(os.path.join(d, "sprite.txt"))
    out = None
    if k and os.path.exists(os.path.join(d, "0.png")):
        w, h = Image.open(os.path.join(d, "0.png")).size
        bl, bt = int(k.get("bbox_left", 0)), int(k.get("bbox_top", 0))
        br, bb = int(k.get("bbox_right", w - 1)), int(k.get("bbox_bottom", h - 1))
        bt_ = int(k.get("bbox_type", 0)); tol = int(k.get("alpha_tolerance", 0))
        if bt_ == 1: bl, bt, br, bb = 0, 0, w - 1, h - 1
        elif bt_ == 0:
            l = t = 10 ** 9; r = b = -1
            f = 0
            while os.path.exists(os.path.join(d, "%d.png" % f)):
                im = Image.open(os.path.join(d, "%d.png" % f)).convert("RGBA")
                a = im.getchannel("A").point(lambda v: 255 if v > tol else 0)
                bx = a.getbbox()
                if bx: l, t, r, b = min(l, bx[0]), min(t, bx[1]), max(r, bx[2] - 1), max(b, bx[3] - 1)
                f += 1
            if r >= 0: bl, bt, br, bb = l, t, r, b
        # (a stored box past the image's edge stops at it, as the game has it and RoomLogic.cs's mask)
        bl, bt, br, bb = max(0, bl), max(0, bt), min(w - 1, br), min(h - 1, bb)
        out = (bl, bt, br, bb, int(k.get("origin_x", 0)), int(k.get("origin_y", 0)))
    _SPR[name] = out
    return out


def inst_box(shape, x, y, xs, ys, ang):
    """an instance's box in the room (bbox_left, top, right, bottom, the right and bottom inclusive), or None"""
    import math
    sb = sprite_box(shape)
    if sb is None: return None
    bl, bt, br, bb, ox, oy = sb
    a = math.radians(ang); ca, sa = math.cos(a), math.sin(a)
    xs_, ys_ = [], []
    for cx, cy in ((bl, bt), (br + 1, bt), (bl, bb + 1), (br + 1, bb + 1)):
        dx, dy = (cx - ox) * xs, (cy - oy) * ys
        xs_.append(x + dx * ca + dy * sa); ys_.append(y - dx * sa + dy * ca)
    return (math.floor(min(xs_) + 1e-6), math.floor(min(ys_) + 1e-6), math.ceil(max(xs_) - 1e-6) - 1, math.ceil(max(ys_) - 1e-6) - 1)


def near(a, b, tol=1):
    return a is not None and b is not None and all(abs(p - q) <= tol for p, q in zip(a, b))


def way_diffs(lv, insts, kind, loc_type, way, moving=frozenset()):
    """one way in's differences: the game's instances (insts) against the logic's things (lv: its lines; moving: the
    ids of the game's that moved between the two dumps). Each a (what, text, the logic's line or None, the game's
    instance or None), what one of: game only, logic only, moved (since it was made, still now), moving, gate open,
    exit leads elsewhere, place moved"""
    out = []
    games = []
    for it in insts:
        k = kind(it["obj"])
        # (a mod's own object, __newobject... in the game: what its parent is)
        if k is None and it["obj"].startswith("__newobject") and "parent" in it["v"]: k = kind(it["v"]["parent"])
        if k is None: continue
        games.append((k, it))
    # places: by their type and number (the Randomizer shows each as the item it holds, and nudges it to fit)
    lp = {(e[7][0], e[7][1]): e for e in lv if e[0] == "L" and len(e[7]) >= 2}
    gp = {}
    for k, it in games:
        if k == "L" and it["obj"] in loc_type and ("objectNum" in it["v"] or loc_type[it["obj"]] in (15, 16, 17)):
            t = loc_type[it["obj"]]
            n = "1" if t in (15, 16, 17) else str(r1(it["v"]["objectNum"]))
            gp[(str(t), n)] = it
    # (the Randomizer's own place objects, __newobject... with no parent: a story pickup, shown as the item it holds, its
    # mask the story item's sprite and its number the place's)
    lspr = {(e[1], e[7][1]): e[7][0] for e in lv if e[0] == "L" and len(e[7]) >= 2}
    for it in insts:
        if it["obj"].startswith("__newobject") and "objectNum" in it["v"]:
            n = str(r1(it["v"]["objectNum"]))
            if (it["msk"], n) in lspr: gp[(lspr[(it["msk"], n)], n)] = it
    for key, it in gp.items():
        if key not in lp: out.append(("game only", "L place %s %s at %d,%d  %s" % (key[0], key[1], r1(it["x"]), r1(it["y"]), it["obj"]), None, it))
        else:
            e = lp[key]
            if abs(it["x"] - e[2]) > 16 or abs(it["y"] - e[3]) > 16:
                out.append(("place moved", "L place %s %s at %d,%d in the logic, %d,%d in the game" % (key[0], key[1], r1(e[2]), r1(e[3]), r1(it["x"]), r1(it["y"])), e, it))
    for key, e in lp.items():
        if key not in gp: out.append(("logic only", "L place %s %s at %d,%d" % (key[0], key[1], r1(e[2]), r1(e[3])), e, None))
    # the rest: by kind and collision box (the game's bbox; the logic's line's worked out from its sprite as the game
    # does); within 2px is the same (a spring settling on the floor); a box where it was made is one that moved since
    logic = [e for e in lv if e[0] != "L"]
    lbox = [inst_box(e[1], e[2], e[3], e[4], e[5], e[6]) for e in logic]
    used = [False] * len(logic)
    def find(k, box, tol):
        for i, e in enumerate(logic):
            if not used[i] and e[0] == k and near(lbox[i], box, tol): return i
        return None
    def check_exit(i, it):
        e = logic[i]
        want = (e[7][0], r1(e[7][1]), r1(e[7][2])) if len(e[7]) >= 3 else None
        got = (it["v"].get("toRoom"), r1(it["v"].get("newMapX", 0)), r1(it["v"].get("newMapY", 0)))
        if want and got != want:
            note = "  (the way in's own newMapX/Y)" if got[1:] == way else ""
            out.append(("exit leads elsewhere", "X exit %d,%d to %s %d,%d in the game, %s %d,%d in the logic%s" % (r1(it["x"]), r1(it["y"]), got[0], got[1], got[2], want[0], want[1], want[2], note), e, it))
    rest = []
    for k, it in games:
        if k == "L": continue
        if it["id"] in moving and k != "X":
            # (something moving: the movers' part of the logic; the logic's line where it was made, if any, is it)
            dx, dy = it["xs0"] - it["x"], it["ys0"] - it["y"]
            b0 = tuple(v + (dx if n % 2 == 0 else dy) for n, v in enumerate(it["bbox"]))
            i = find(k, b0, 1)
            if i is None: i = find(k, it["bbox"], 2)
            if i is not None: used[i] = True
            shape = it["msk"] if it["msk"] != "-" else it["spr"]
            out.append(("moving", "%s %s made at %d,%d  %s%s" % (k, shape, r1(it["xs0"]), r1(it["ys0"]), it["obj"], "" if i is not None else "  (not in the logic)"), logic[i] if i is not None else None, it))
            continue
        box = it["bbox"]
        i = find(k, box, 1)
        if i is None: i = find(k, box, 2)
        if i is not None:
            used[i] = True
            if k == "X":
                check_exit(i, it)
                # (an elevator's pad, oMetEleExit: the logic has it as a solid as well as an exit)
                j = find("S", box, 1)
                if j is not None and it["obj"] == "oMetEleExit": used[j] = True
            continue
        rest.append((k, it))
    rest2 = []
    for k, it in rest:
        dx, dy = it["xs0"] - it["x"], it["ys0"] - it["y"]
        b0 = tuple(v + (dx if n % 2 == 0 else dy) for n, v in enumerate(it["bbox"]))
        i = find(k, b0, 1)
        if i is not None:
            used[i] = True
            out.append(("moved", "%s %s %d,%d -> %d,%d  %s" % (k, logic[i][1], r1(it["xs0"]), r1(it["ys0"]), r1(it["x"]), r1(it["y"]), it["obj"]), logic[i], it))
            continue
        shape = it["msk"] if it["msk"] != "-" else it["spr"]
        rest2.append((k, shape, it))
    # a Metroid door the game makes from its holder (oMetroidDoorHolder makes oMetroidDoorColor beside it): the logic's
    # gate where the holder is. A solid that's off now (its mask sNull, or a box of a pixel: a red or blue block, a
    # barrier its switch has opened) is where a state line of the logic's is (T: there in one state of a switch's), or
    # an open gate (where the logic has one, it's "open" in the game: the door the player came in by, say)
    rest3 = []
    for k, shape, it in rest2:
        if it["obj"] == "oMetroidDoorColor" and any(e[1] == "sMetroidDoorHolder" and abs(e[2] - it["x"]) <= 32 and abs(e[3] - it["y"]) <= 32 for e in logic):
            continue
        bx = it["bbox"]
        if k == "S" and (shape == "sNull" or (bx[2] - bx[0] <= 1 and bx[3] - bx[1] <= 1)):
            cand = [i for i, e in enumerate(logic) if not used[i] and e[0] == "S" and abs(e[2] - it["xs0"]) <= 1 and abs(e[3] - it["ys0"]) <= 1]
            if not cand:
                cand = [i for i, e in enumerate(logic) if not used[i] and e[0] == "S" and abs(e[2] - it["x"]) <= 1 and abs(e[3] - it["y"]) <= 1]
            for i in cand:
                used[i] = True
                if logic[i][8] == "G": out.append(("gate open", "%s %s %d,%d (%s)" % (logic[i][8], logic[i][1], r1(logic[i][2]), r1(logic[i][3]), it["obj"]), logic[i], it))
            continue
        rest3.append((k, shape, it))
    for k, shape, it in rest3:
        made = "" if (r1(it["xs0"]), r1(it["ys0"])) == (r1(it["x"]), r1(it["y"])) else " (made at %d,%d)" % (r1(it["xs0"]), r1(it["ys0"]))
        extra = " to %s %s,%s" % (it["v"].get("toRoom"), it["v"].get("newMapX"), it["v"].get("newMapY")) if k == "X" else ""
        out.append(("game only", "%s %s %d,%d  %s%s%s" % (k, shape, r1(it["x"]), r1(it["y"]), it["obj"], made, extra), None, it))
    # (a state line of the logic's, T, whose state isn't the one the game started in: not there, as the logic has it;
    # the same for an exit's line for another state of a carried group: X ... group state, a line a state)
    # (and the enemy traps' barriers, oRndTrap: the Randomizer makes them as the trap starts, so not there yet)
    for i, e in enumerate(logic):
        if used[i] or e[8] in ("T", "TW", "U") or (e[8] == "X" and len(e[7]) >= 7): continue
        if e[8] == "G" and e[7] and e[7][-1] == "oRndTrap": continue
        what = ("%s %s %d,%d" % (e[8], e[1], r1(e[2]), r1(e[3]))) + ("  (%s: %s)" % (e[7][-1], e[7][0]) if e[8] == "G" and len(e[7]) >= 2 else "")
        out.append(("logic only", what, e, None))
    return out


def override_links():
    """overrides.txt's link lines: {(room, exit id "x,y"): (room, x, y)} (an exit the Randomizer leads elsewhere)"""
    out = {}
    for l in open(os.path.join(RL, "overrides.txt"), encoding="utf-8"):
        m = re.match(r"^link (\w+) out (-?\d+,-?\d+) -> (\w+) in (-?\d+),(-?\d+)", l)
        if m: out[(m.group(1), m.group(2))] = (m.group(3), int(m.group(4)), int(m.group(5)))
    return out


def collect(game, rooms, keep=frozenset(), kept=None):
    """each room's differences, way in by way in: {room: {(x, y): [(what, text, line, inst)]}}, and the ways in where
    the game ended up in another room ([(room, x, y, where)]); with keep, each way in's instances of those objects into
    kept ({(room, x, y): [inst]})"""
    import roomdata as rd
    import rndgen
    proj = rd.Project()
    kind = classify(proj, rd)
    loc_type = dict(rndgen.LT_BY_OBJ)
    logic = logic_view()
    links = override_links()
    d = os.path.join(lt.ltdir(game), "dumps")
    res, left = {}, []
    for room, ws in sorted(ways_in().items()):
        if rooms and room not in rooms: continue
        lv = logic.get(room, [])
        per_way = {}
        for x, y in ws:
            p = os.path.join(d, dump_name(room, x, y) + ".txt")
            if not os.path.exists(p): continue
            head, insts, gids = read_dump(p)
            if head is None or head[1] != room:
                left.append((room, x, y, head[1] if head else "?"))
                continue
            if kept is not None: kept[(room, x, y)] = [it for it in insts if it["obj"] in keep]
            # (what moved between this dump and the one a moment later: moving)
            moving = set()
            p2 = os.path.join(d, dump_name(room, x, y) + ".2.txt")
            if os.path.exists(p2):
                h2, insts2, g2 = read_dump(p2)
                at2 = {it["id"]: (r1(it["x"]), r1(it["y"])) for it in insts2}
                moving = {it["id"] for it in insts if it["id"] in at2 and at2[it["id"]] != (r1(it["x"]), r1(it["y"]))}
            diffs = way_diffs(lv, insts, kind, loc_type, (x, y), moving)
            # (an exit overrides.txt already leads where the game's does: the same)
            def linked(rec):
                what, text, line, it = rec
                if what != "exit leads elsewhere": return False
                to = links.get((room, "%d,%d" % (r1(line[2]), r1(line[3]))))
                return to is not None and to == (it["v"].get("toRoom"), r1(it["v"].get("newMapX", 0)), r1(it["v"].get("newMapY", 0)))
            per_way[(x, y)] = [rec for rec in diffs if not linked(rec)]
        if per_way: res[room] = per_way
    return res, left


def compare(game, rooms, out_path):
    make_base()
    res, left = collect(game, rooms)
    lines, counts = [], collections.Counter()
    for room, x, y, where in left:
        lines.append("%s in %d,%d: the game ended up in %s" % (room, x, y, where)); counts["left the room"] += 1
    for room, per_way in sorted(res.items()):
        # each difference with the ways in that have it
        by = collections.defaultdict(list)
        for w, diffs in per_way.items():
            for what, text, line, it in diffs: by[(what, text)].append(w)
        nw = len(per_way)
        out = []
        for (what, text), wl in sorted(by.items()):
            ways = "" if len(wl) == nw else "   (from in %s only)" % " ".join("%d,%d" % w for w in sorted(wl))
            out.append("  %-20s %s%s" % (what, text, ways))
            counts[what + " " + text.split()[0]] += 1
        if out:
            lines.append("%s (%d way(s) in)" % (room, nw)); lines += out
    os.makedirs(os.path.dirname(out_path), exist_ok=True)
    open(out_path, "w", encoding="utf-8", newline="\n").write("\n".join(lines) + "\n")
    for k, n in sorted(counts.items()): print("%6d %s" % (n, k))
    print("written", out_path)


def track(game, rooms, frames, speed, exe):
    """the moving things' paths: each room where something moves (compare's moving), come into by its first way in,
    every instance of the objects that move anywhere where it is each frame for that many frames (LogicTest's track),
    into <game>\\Mods\\LogicTest\\tracks\\<room>.txt"""
    res, left = collect(game, rooms)
    movers, where = set(), {}
    for room, per_way in res.items():
        for w, diffs in sorted(per_way.items()):
            for what, text, line, it in diffs:
                if what == "moving" and it is not None:
                    movers.add(it["obj"]); where.setdefault(room, w)
    open(os.path.join(lt.ltdir(game), "track.txt"), "w", encoding="cp1252", newline="\r\n").write("\n".join(sorted(movers)) + "\n")
    print("%d room(s) with moving things, %d object(s): %s" % (len(where), len(movers), " ".join(sorted(movers))))
    snap(game)
    d = os.path.join(lt.ltdir(game), "tracks")
    for room, (x, y) in sorted(where.items()):
        s = ["god", "speed %d" % speed, "fps 30", "restore", "goto %s %d %d" % (room, x, y), "waitf 2 room", "track %s %d" % (room, frames)]
        cmd = os.path.join(HERE, "calib", "roomdump_cmds.txt")
        open(cmd, "w", encoding="utf-8").write("\n".join(s) + "\n")
        rc = lt.run(game, cmd, 60 + frames // 30, quiet=True)
        if rc == 2:
            print("%s: the game stopped answering: started again" % room); restart(game, exe)
        elif rc != 0:
            print("%s: %s" % (room, open(os.path.join(lt.ltdir(game), "out.txt"), "rb").read().decode("cp1252", "replace")[-300:]))
    print("written", d)


def read_tracks(game):
    """the tracks: {room: {id: (object, [(frame, x, y)])}}"""
    d = os.path.join(lt.ltdir(game), "tracks")
    out = {}
    if not os.path.isdir(d): return out
    for fn in sorted(os.listdir(d)):
        if not fn.endswith(".txt"): continue
        room, per = fn[:-4], {}
        for l in open(os.path.join(d, fn), encoding="cp1252", errors="replace"):
            f = l.rstrip("\r\n").split("\t")
            if f[0] == "F" and len(f) == 6:
                per.setdefault(int(f[2]), (f[3], []))[1].append((int(f[1]), float(f[4]), float(f[5])))
        out[room] = per
    return out


def path_of(pts):
    """a mover's path from where it was frame by frame: ("line", x1, y1, x2, y2) along one straight line (back and forth
    or one way), ("circle", cx, cy, r) round one, ("still", x, y), or ("other", minx, miny, maxx, maxy)"""
    import math
    xy = [(x, y) for f, x, y in pts]
    if len(set(xy)) <= 1: return ("still",) + xy[0]
    xs, ys = [p[0] for p in xy], [p[1] for p in xy]
    # (a straight line: every point within a pixel of the line through the two furthest apart)
    a = max(xy, key=lambda p: (p[0] - xy[0][0]) ** 2 + (p[1] - xy[0][1]) ** 2)
    b = max(xy, key=lambda p: (p[0] - a[0]) ** 2 + (p[1] - a[1]) ** 2)
    L = math.hypot(b[0] - a[0], b[1] - a[1])
    if L > 0 and all(abs((b[0] - a[0]) * (a[1] - y) - (a[0] - x) * (b[1] - a[1])) / L <= 1.5 for x, y in xy):
        return ("line", a[0], a[1], b[0], b[1])
    # (a circle: the one nearest every point, least squares (part of a turn is enough), every point on it within 2px or
    # a fifth of its size: a circling platform's steps, rounded, drift its way round a few pixels a turn)
    pts2 = sorted(set(xy))
    n = len(pts2)
    if n >= 5:
        mx, my = sum(p[0] for p in pts2) / n, sum(p[1] for p in pts2) / n
        u = [p[0] - mx for p in pts2]; v = [p[1] - my for p in pts2]
        suu = sum(a * a for a in u); svv = sum(b * b for b in v); suv = sum(a * b for a, b in zip(u, v))
        suuu = sum(a ** 3 for a in u); svvv = sum(b ** 3 for b in v)
        suvv = sum(a * b * b for a, b in zip(u, v)); svuu = sum(b * a * a for a, b in zip(u, v))
        det = suu * svv - suv * suv
        if abs(det) > 1e-9:
            uc = (0.5 * (suuu + suvv) * svv - 0.5 * (svvv + svuu) * suv) / det
            vc = (0.5 * (svvv + svuu) * suu - 0.5 * (suuu + suvv) * suv) / det
            cx, cy = uc + mx, vc + my
            ds = [math.hypot(x - cx, y - cy) for x, y in pts2]
            r = sum(ds) / len(ds)
            if max(ds) - min(ds) <= max(2, r / 5): return ("circle", cx, cy, r)
    # (straight legs corner to corner, a rail's: where its way turns, and the legs between, each once: x1 y1 x2 y2 a leg)
    xyr = [(round(x), round(y)) for x, y in xy]
    corners = [xyr[0]]
    for a, b, c in zip(xyr, xyr[1:], xyr[2:]):
        d1 = (b[0] - a[0], b[1] - a[1]); d2 = (c[0] - b[0], c[1] - b[1])
        if d1 != d2 and (abs(d1[0] - d2[0]) > 1 or abs(d1[1] - d2[1]) > 1) and b != corners[-1]: corners.append(b)
    if corners[-1] != xyr[-1]: corners.append(xyr[-1])
    legs = []
    for a, b in zip(corners, corners[1:]):
        if a != b and (a, b) not in legs and (b, a) not in legs: legs.append((a, b))
    # (a leg that's part of another, the track's first or last: left out)
    def inside(l, m):
        (ax, ay), (bx, by) = m
        return all(min(ax, bx) <= px <= max(ax, bx) and min(ay, by) <= py <= max(ay, by) and (bx - ax) * (py - ay) == (by - ay) * (px - ax) for px, py in l)
    legs = [l for l in legs if not any(m != l and inside(l, m) for m in legs)]
    if 1 < len(legs) <= 16:
        return ("legs",) + tuple(float(v) for l in legs for c in l for v in c)
    return ("other", min(xs), min(ys), max(xs), max(ys))


def paths_report(game, out_path):
    make_base()
    """each mover's path as the game has it (its track) against the logic's: its N line's path (roomdata.py's
    mover_path), an M line (left out), or nothing"""
    tracks = read_tracks(game)
    logic = collections.defaultdict(list)
    room = None
    for l in open(BASE_TXT, encoding="utf-8"):
        f = l.rstrip("\n").split("\t")
        if f[0] == "R": room = f[1]; continue
        if (f[0] == "N" and len(f) >= 11) or (f[0] == "U" and len(f) >= 13):
            logic[room].append(("N", f[1], float(f[2]), float(f[3]), f[7] if f[0] == "N" else f[9], f[8:] if f[0] == "N" else f[10:]))
        elif f[0] == "M":
            logic[room].append(("M", f[1], float(f[2]), float(f[3]), "", []))
    lines, counts = [], collections.Counter()
    def fmt(p): return " ".join(str(int(round(v))) if isinstance(v, float) else v for v in p)
    for room, per in sorted(tracks.items()):
        out = []
        for i, (obj, pts) in sorted(per.items()):
            p = path_of(pts)
            if p[0] == "still": continue
            x0, y0 = pts[0][1], pts[0][2]
            # (the logic's line for it: an N line along the same line, its ends within 24px either way round, or round the
            # same circle, its middle within 24px and its size within 16; else an M line of its object near where it was)
            best = None
            for e in logic.get(room, []):
                if e[0] != "N" or not e[5]: continue
                q = [float(v) for v in e[5]]
                if p[0] == "line" and e[4] == "line" and len(q) >= 4:
                    d1 = max(abs(p[1] - q[0]), abs(p[2] - q[1]), abs(p[3] - q[2]), abs(p[4] - q[3]))
                    d2 = max(abs(p[1] - q[2]), abs(p[2] - q[3]), abs(p[3] - q[0]), abs(p[4] - q[1]))
                    if min(d1, d2) <= 24: best = e; break
                if p[0] == "circle" and e[4] == "circle" and len(q) >= 3:
                    if abs(p[1] - q[0]) <= 24 and abs(p[2] - q[1]) <= 24 and abs(p[3] - q[2]) <= 16: best = e; break
            if best is None:
                for e in logic.get(room, []):
                    if e[0] == "M" and e[1] == obj and abs(e[2] - x0) <= 160 and abs(e[3] - y0) <= 160: best = e; break
            if best is None: what = "not in the logic"
            elif best[0] == "M": what = "left out by the logic (M)"
            else: what = "logic: %s %s" % (best[4], " ".join(str(int(round(float(v)))) for v in best[5]))
            out.append("  %-20s %-18s game: %-34s %s" % (obj, "%d,%d" % (x0, y0), fmt(p), what))
            counts[what.split(":")[0] if what.startswith("logic") else what] += 1
        if out: lines.append(room); lines += out
    open(out_path, "w", encoding="utf-8", newline="\n").write("\n".join(lines) + "\n")
    for k, n in sorted(counts.items()): print("%5d %s" % (n, k))
    print("written", out_path)


MOVER_ADD = {"oMovingCrushPlat", "oMovingPlatform", "oCirclePlatform", "oVaultMovingPlat", "oG6_EarthPlat",
             "oMMEaglePlat", "oPlatformTouch", "oPlatformRailA"}
CHAIN_POINTS = {"oStrikeChainPoint", "oStrikePoint_Ext"}


def mover_lines(game, res):
    """gamestate.txt's lines for the moving platforms, from their tracks (track): path (the logic's N line's way, where
    the game's differs by more than 2px), add N (one the logic leaves out or hasn't: a platform the player rides, along
    a line or round a circle, the shape it had in the dump). The rest (rails, Strike Chain points going round, moving
    spikes, the water) for review"""
    import roomdata as rd
    def fmt(v): return rd.fnum(round(float(v), 2))
    tracks = read_tracks(game)
    logic, rippers = collections.defaultdict(list), collections.defaultdict(list)
    room = None
    for l in open(BASE_TXT, encoding="utf-8"):
        f = l.rstrip("\n").split("\t")
        if f[0] == "R": room = f[1]; continue
        if f[0] == "N" and len(f) >= 11: logic[room].append(f)
        if f[0] == "KR": rippers[room].append((float(f[2]), float(f[3])))
    d = os.path.join(lt.ltdir(game), "dumps")
    take, review = [], []
    for room, per in sorted(tracks.items()):
        # (the dump's instances, by id: each mover's shape)
        insts = {}
        for x, y in ways_in().get(room, []):
            p = os.path.join(d, dump_name(room, x, y) + ".txt")
            if os.path.exists(p):
                insts = {it["id"]: it for it in read_dump(p)[1]}
                break
        used = set()
        for i, (obj, pts) in sorted(per.items()):
            p = path_of(pts)
            if p[0] == "still": continue
            if p[0] == "line" and max(abs(p[1] - p[3]), abs(p[2] - p[4])) <= 2: continue   # (a spring settling)
            best = None
            for k, f in enumerate(logic.get(room, [])):
                if k in used: continue
                q = [float(v) for v in f[8:]]
                if p[0] == "line" and f[7] == "line" and len(q) >= 4:
                    d1 = max(abs(p[1] - q[0]), abs(p[2] - q[1]), abs(p[3] - q[2]), abs(p[4] - q[3]))
                    d2 = max(abs(p[1] - q[2]), abs(p[2] - q[3]), abs(p[3] - q[0]), abs(p[4] - q[1]))
                    if min(d1, d2) <= 24: best = (k, min(d1, d2)); break
                if p[0] == "circle" and f[7] == "circle" and len(q) >= 3:
                    dd = max(abs(p[1] - q[0]), abs(p[2] - q[1]), abs(p[3] - q[2]))
                    if dd <= 24: best = (k, dd); break
            if best is not None:
                k, dd = best; used.add(k); f = logic[room][k]
                if dd > 2:
                    take.append("%s\tpath\tN\t%s\t%s\t%s\t%s\t%s\t# %s" % (room, f[1], f[2], f[3], p[0], "\t".join(fmt(v) for v in p[1:]), obj))
                continue
            it = insts.get(i)
            if obj in CHAIN_POINTS and p[0] in ("line", "circle"):
                # (a Strike Chain point going round, or along a line: points along its way, every 24px, as the logic
                # has a moving platform's (waiting for it where it goes); not one a Ripper carries, KR, the logic has)
                if p[0] == "line" and any(abs(ry - p[2]) <= 16 for rx, ry in rippers.get(room, [])): continue
                import math
                # (only one that comes back: a point flying past once isn't there to wait for)
                if p[0] == "line":
                    dx, dy = p[3] - p[1], p[4] - p[2]
                    proj = [(x - p[1]) * dx + (y - p[2]) * dy for f, x, y in pts]
                    steps = [b - a for a, b in zip(proj, proj[1:]) if b != a]
                    if not any(s1 * s2 < 0 for s1, s2 in zip(steps, steps[1:])):
                        review.append("# %s: moving %s one way, line %d %d %d %d (not taken in: it doesn't come back)" % ((room, obj) + tuple(round(v) for v in p[1:])))
                        continue
                if p[0] == "circle":
                    n = max(8, int(2 * math.pi * p[3] / 24))
                    spots = [(p[1] + p[3] * math.cos(2 * math.pi * k / n), p[2] + p[3] * math.sin(2 * math.pi * k / n)) for k in range(n)]
                else:
                    n = max(1, int(math.hypot(p[3] - p[1], p[4] - p[2]) / 24))
                    spots = [(p[1] + (p[3] - p[1]) * k / n, p[2] + (p[4] - p[2]) * k / n) for k in range(n + 1)]
                for sx, sy in spots:
                    key = "%s\tadd\tK\tsStrikeChainPoint\t%d\t%d\t1\t1\t0\t# %s going round" % (room, round(sx), round(sy), obj)
                    if key not in take: take.append(key)
                continue
            if obj in MOVER_ADD and p[0] in ("line", "circle", "legs") and it is not None:
                shape = it["msk"] if it["msk"] != "-" else it["spr"]
                take.append("%s\tadd\tN\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t# %s" % (room, shape, fmt(pts[0][1]), fmt(pts[0][2]), fmt(it["xs"]), fmt(it["ys"]), fmt(it["ang"]),
                                                                                  p[0], "\t".join(fmt(v) for v in p[1:]), obj))
                continue
            review.append("# %s: moving %s %s from %d,%d" % (room, obj, " ".join(fmt(v) if isinstance(v, float) else v for v in p), pts[0][1], pts[0][2]))
    return take, review


GAMESTATE = os.path.join(RL, "gamestate.txt")
# the game's barriers (something opens them: an enemy beaten, a boss, a switch): not taken in as plain solids, but listed
# for a requirement to be decided (gamestate.txt's review)
BARRIERS = {"oEnemyBarrier", "oBossBarrier", "oEventBarrier", "oTimeSwBarrier", "oSwitchBarrier", "oBarrierColor",
            "oEnemyTestDoor", "oSolidVirusBlock"}
# things the logic has its own way of seeing (not taken in as still things): moving platforms with their paths
# (roomdata.py's mover_path), fading platforms (jump-through), what's never solid (NOT_SOLID), a boss
OWN_WAY = {"oCirclePlatform", "oPlatformScale", "oPlatBud", "oPlatformAutoMove", "oPlatTempFade", "oAbominationMain",
           "oPlatform_CVFall"}
# (and what they make: a Castlevania falling pillar's column, 16px in and 32px under its top)
OWN_PARTS = {"oPlatform_CVFall": [("oInvisibleSolid", 16, 32)]}
# (and lines the logic moves itself: floating platforms with the water, elevators along their shafts, moving platforms
# along their paths, a state's moving platform)
OWN_MOVES = {"FP", "V", "N", "U"}
# (the sprites of the things the logic has its own way of seeing: a line of one isn't taken out)
OWN_WAY_SPRITES = {"sPlatTempFade"}
# (the masks of invisible solids, any object's)
GENERIC_MASKS = {"sInvisibleSolidMask", "sScaledCollision"}


def triggered_objects(proj, rd):
    """the objects whose Step changes them as the player comes near (a distance from them, not a touch: comes within
    some pixels and it falls away) or turns them to nothing by themselves (sNull): the room as it starts doesn't say
    how they are when the player gets there, so neither taken in nor taken out (for review). What changes on a touch
    or a hit (an exit, a spring, a breakable wall, a pillar that falls when stood on) the logic has its own way of.
    And their parts: what only they make, never placed by itself (the Chaos elevator's cabin)"""
    out = set()
    pat = [r"point_distance\([^)]*oPlayer1", r"distance_to_object\(oPlayer1", r"oPlayer1\.[xy]\s*[<>]", r"sprite_index\s*=\s*sNull"]
    for o in proj.parent:
        owner, step = proj.event_inherited(o, "Step_0")
        if step and any(re.search(p, step) for p in pat): out.add(o)
    makers = collections.defaultdict(set)
    for o in proj.parent:
        proj.event(o, "Create_0")
        for code in proj.events.get(o, {}).values():
            for m in re.finditer(r"instance_create\(.*?,\s*(o\w+)\s*\)", code): makers[m.group(1)].add(o)
    placed = set()
    for r in os.listdir(rd.ROOMS):
        p = os.path.join(rd.ROOMS, r, "instances.txt")
        if os.path.exists(p): placed.update(l.split(",", 1)[0] for l in open(p, encoding="utf-8", errors="replace"))
    return out | {o for o, by in makers.items() if by <= out and o not in placed}


# the solids an enemy makes and takes away with it when it's beaten (Contra's wall, a junkyard car, a Drill Waying's
# base and pillar): gates that open with what beats it (traps.py's rule: an attack of a damage type each enemy takes).
# For each: what it makes, where from where it started, and the enemies to beat (the wall's turrets too). A Drill
# Waying's pillar rises to drillMax 16px blocks as the player comes near: taken in risen (riding it up isn't)
ENEMY_WALLS = {"oHugeAssWall": ([("oSolid", 48, 0)], ["oHugeAssWall", "oHAW_Gun"]),
               "oJunkyardCar": ([("oSolid", 0, 0)], ["oJunkyardCar"]),
               "oDrillWaying": ([("oSolid", 0, 16), ("oDrillWayingDrill", 0, -16)], ["oDrillWaying"])}


def enemy_walls(room, insts, area, fmt):
    """a way in's enemy walls (its instances of ENEMY_WALLS's enemies and what they made): (the gates' keys, the ids of
    the instances they stand for)"""
    import rndgen, traps
    keys, ids = [], set()
    # (what the things the logic has its own way of make: theirs, not taken in)
    for e in insts:
        for obj, dx, dy in OWN_PARTS.get(e["obj"], []):
            ids |= {i["id"] for i in insts if i["obj"] == obj and near((i["xs0"], i["ys0"]), (e["xs0"] + dx, e["ys0"] + dy))}
    for e in insts:
        if e["obj"] not in ENEMY_WALLS: continue
        made, beat = ENEMY_WALLS[e["obj"]]
        req = traps.req_words(traps.requirement(beat, area))
        for obj, dx, dy in made:
            it = next((i for i in insts if i["obj"] == obj and near((i["xs0"], i["ys0"]), (e["xs0"] + dx, e["ys0"] + dy))), None)
            if it is None: continue
            ids.add(it["id"])
            x, y, xs, ys = it["xs0"], it["ys0"], it["xs"], it["ys"]
            if obj == "oDrillWayingDrill":
                code = next((c for o, ix, iy, h, c in rndgen.instances(room) if o == e["obj"] and (ix, iy) == (r1(e["xs0"]), r1(e["ys0"]))), "")
                m = re.search(r"\bdrillMax\s*=\s*(\d+)", code)
                if not m: continue
                ys = int(m.group(1)); y = e["ys0"] - 16 * ys
            shape = it["msk"] if it["msk"] != "-" else it["spr"]
            keys.append("add\tG\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s" % (shape, fmt(x), fmt(y), fmt(xs), fmt(ys), fmt(it["ang"]), req, e["obj"]))
    return keys, ids


def digest(game, rooms, out_path):
    """gamestate.txt: what roomdata.py takes from the game's own rooms (its README says how it's read): the logic's lines
    the game hasn't (del), still things it has that the logic hasn't (add), things that were made somewhere and are
    still somewhere else (move), exits leading elsewhere (exit); a line only some ways in have says which (from). What
    isn't taken in is listed for review at the end: moving things (C.2), places, the game's barriers"""
    import roomdata as rd
    make_base()
    # (an exit's Step looks at where the player is for its arrow: exits go by where they lead, not this)
    proj = rd.Project()
    trig = triggered_objects(proj, rd) - (rd.EXITS | set(rd.FIXED_EXITS) | rd.MAP_EXITS | {"oMapDoor", "oMetEleExit"})
    kind = classify(proj, rd)
    kept = {}
    res, left = collect(game, rooms, trig | set(ENEMY_WALLS) | {o for made, beat in ENEMY_WALLS.values() for o, dx, dy in made}
                        | set(OWN_PARTS) | {o for parts in OWN_PARTS.values() for o, dx, dy in parts}, kept)
    area = {f[1]: int(f[4]) for f in (l.split("\t") for l in open(ROOMS_TXT, encoding="utf-8")) if f[0] == "R"}
    take, review = [], []
    def fmt(v): return rd.fnum(round(float(v), 2))
    def overlaps(a, b): return a is not None and b is not None and a[0] <= b[2] and b[0] <= a[2] and a[1] <= b[3] and b[1] <= a[3]
    def grown(b, n): return (b[0] - n, b[1] - n, b[2] + n, b[3] + n)
    for room, per_way in sorted(res.items()):
        nw = len(per_way)
        by = collections.OrderedDict()
        # (the sprites of the room's moving things: a logic line of one of them the game hasn't where it is isn't taken
        # out, it's moving: the movers' part. An invisible solid's mask is everyone's: by where the moving one is and
        # was made, then)
        moving = [it for diffs in per_way.values() for what, text, line, it in diffs if what == "moving" and it is not None]
        moving_spr = {(it["msk"] if it["msk"] != "-" else it["spr"]) for it in moving} - GENERIC_MASKS
        mboxes = [b for it in moving for b in (it["bbox"], tuple(t + d for t, d in zip(it["bbox"], (it["xs0"] - it["x"], it["ys0"] - it["y"]) * 2)))]
        for w, diffs in sorted(per_way.items()):
            insts = kept.get((room,) + w, [])
            # (the boxes of the game's things that change by themselves or as the player comes near: a logic line where
            # one is isn't taken out, nor a thing of the game's touching one (the spikes under Gate 4's falling columns))
            # (things the logic has a kind for: an enemy goes after the player wherever it is, C.3's; its box where it is
            # and where it was made: roomdata.py has some as they end up, Gate 4's columns down)
            tboxes = [b for it in insts if it["obj"] in trig and kind(it["obj"])
                      for b in (it["bbox"], tuple(t + d for t, d in zip(it["bbox"], (it["xs0"] - it["x"], it["ys0"] - it["y"]) * 2)))]
            # (and the logic's own line of one: where it was made)
            tstarts = {(r1(it["xs0"]), r1(it["ys0"])) for it in insts if it["obj"] in trig and kind(it["obj"])}
            # (the enemy walls: gates; what they made isn't taken in as it is)
            walls, made = enemy_walls(room, insts, area.get(room, 0), fmt)
            for key in walls: by.setdefault(key, [key.split("\t")[-1], []])[1].append(w)
            for what, text, line, it in diffs:
                if it is not None and it["id"] in made: continue
                key, note = None, ""
                if what == "logic only" and line is not None and line[8] in ("S", "G", "H", "HV", "P", "W", "J", "K", "X") and line[0] != "L" \
                        and line[1] not in moving_spr and line[1] not in OWN_WAY_SPRITES and (r1(line[2]), r1(line[3])) not in tstarts \
                        and not any(overlaps(inst_box(line[1], line[2], line[3], line[4], line[5], line[6]), b) for b in tboxes + mboxes):
                    key = "del\t%s\t%s\t%s\t%s" % (line[8], line[1], fmt(line[2]), fmt(line[3]))
                elif what == "gate open":
                    key = "del\t%s\t%s\t%s\t%s" % (line[8], line[1], fmt(line[2]), fmt(line[3])); note = it["obj"] + " open"
                elif what == "moved" and line is not None and line[8] not in OWN_MOVES:
                    key = "move\t%s\t%s\t%s\t%s\t%s\t%s" % (line[8], line[1], fmt(line[2]), fmt(line[3]), fmt(it["x"]), fmt(it["y"])); note = it["obj"]
                elif what == "exit leads elsewhere" and "the way in's own" not in text and it["v"].get("toRoom", "None") not in ("None", "", "-1", "-4") \
                        and "newMapX" in it["v"] and "newMapY" in it["v"]:
                    v = it["v"]
                    key = "exit\t%s\t%s\t%s\t%s\t%s" % (fmt(line[2]), fmt(line[3]), v.get("toRoom"), fmt(v.get("newMapX", 0)), fmt(v.get("newMapY", 0)))
                elif what == "game only" and it is not None and it["obj"] not in BARRIERS and it["obj"] not in rd.GATES \
                        and it["obj"] not in OWN_WAY and it["obj"] not in rd.NOT_SOLID and it["obj"] not in rd.LINE_MOVERS and it["obj"] not in trig \
                        and not any(overlaps(grown(it["bbox"], 2), b) for b in tboxes):
                    shape = it["msk"] if it["msk"] != "-" else it["spr"]
                    geo = "%s\t%s\t%s\t%s\t%s\t%s" % (shape, fmt(it["x"]), fmt(it["y"]), fmt(it["xs"]), fmt(it["ys"]), fmt(it["ang"]))
                    k = text.split()[0]
                    if k == "X":
                        v = it["v"]
                        # (not one leading back to the way in's own place: it goes back where the player came from)
                        if "toRoom" in v and "newMapX" in v and "newMapY" in v and (r1(v["newMapX"]), r1(v["newMapY"])) != w:
                            key = "add\tX\t%s\t%s\t%s\t%s\t%s\t%s" % (geo, v["toRoom"], fmt(v["newMapX"]), fmt(v["newMapY"]), fmt(v.get("exitType", 0)), it["obj"])
                    elif k == "J":
                        key = "add\tJ\t%s\t%s" % (geo, rd.SPRINGS.get(it["obj"], "L"))
                    elif k in ("S", "H", "P", "W", "K"):
                        key = "add\t%s\t%s" % (k, geo)
                    note = it["obj"]
                if key is None:
                    review.append((room, what, text, w)); continue
                by.setdefault(key, [note, []])[1].append(w)
        for key, (note, wl) in by.items():
            fr = "" if len(wl) == nw else "\tfrom\t" + " ".join("%d,%d" % w for w in sorted(wl))
            take.append("%s\t%s%s%s" % (room, key, fr, ("\t# " + note) if note else ""))
    # (the moving platforms' ways, from their tracks)
    mtake, mreview = mover_lines(game, res)
    with open(out_path, "w", encoding="utf-8", newline="\n") as f:
        f.write("# gamestate.txt: the rooms as the game makes them, where roomdata.py's reading of their code differs: made by\n"
                "# ..\\..\\logictest\\roomdump.py digest from the game itself (every room come into by every way in; README.txt,\n"
                "# THE ROOMS AS THE GAME MAKES THEM). Don't edit: make it again. roomdata.py takes it in (a tab between fields):\n"
                "#   room del T sprite x y            the logic's line of that type there isn't there in the game\n"
                "#   room add T sprite x y xs ys a ...  a thing the game has (T S solid, H hazard, P platform, W water, J spring, K\n"
                "#                                    Strike Chain point, X exit: then where it leads; N a moving platform: its way;\n"
                "#                                    G a wall an enemy makes: then what beats it, and the enemy)\n"
                "#   room move T sprite x y x2 y2     the logic's line is at x2,y2 in the game (made there, it moved and stopped)\n"
                "#   room exit x y room2 x2 y2        the exit at x,y leads there\n"
                "#   room path N sprite x y way ...   the moving platform's way as the game has it (line x1 y1 x2 y2, circle cx cy r,\n"
                "#                                    legs x1 y1 x2 y2 ...: a rail's, corner to corner)\n"
                "# ... from x,y x,y: only coming in at those ways in (roomdata.py: a group the way in sets, WS)\n")
        f.write("\n".join(take) + "\n")
        f.write("\n# the moving platforms (their tracks: roomdump.py track)\n")
        f.write("\n".join(mtake) + ("\n" if mtake else ""))
        f.write("\n# not taken in (for review): moving things (the movers' part), places, the game's barriers, rooms the game left\n")
        for l in mreview: f.write(l + "\n")
        # (each once, with the ways in that have it, or every way in)
        grouped = collections.OrderedDict()
        for room, what, text, w in review: grouped.setdefault((room, what, text), []).append(w)
        for (room, what, text), wl in grouped.items():
            ways = "" if len(wl) == len(res.get(room, {})) else "   (from in %s)" % " ".join("%d,%d" % w for w in sorted(wl))
            f.write("# %s: %s %s%s\n" % (room, what, text, ways))
        for room, x, y, where in left:
            f.write("# %s %d,%d: the game ended up in %s\n" % (room, x, y, where))
    print("%d line(s) taken in, %d moving platforms', %d for review; written %s" % (len(take), len(mtake), len(review) + len(mreview), out_path))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("what", choices=["run", "compare", "digest", "track", "paths"])
    ap.add_argument("game")
    ap.add_argument("--rooms", default="")
    ap.add_argument("--frames", type=int, default=30)
    ap.add_argument("--batch", type=int, default=25)
    ap.add_argument("--speed", type=int, default=8)
    ap.add_argument("--exe", default="DT3_LogicTest_b.exe", help="the test copy's exe (started again after an error)")
    ap.add_argument("--resume", action="store_true", help="only the ways in without a dump yet")
    ap.add_argument("--retry-errors", action="store_true", help="the ways in roomdump_errors.txt too")
    ap.add_argument("--after", action="append", default=[], help="a LogicTest command after each restore (e.g. set NAME VALUE)")
    ap.add_argument("--out", default=os.path.join(RL, "work", "roomdump_compare.txt"))
    a = ap.parse_args()
    rooms = set(a.rooms.split(",")) if a.rooms else None
    if a.what == "run": run(a.game, rooms, a.frames, a.batch, a.speed, os.path.join(a.game, a.exe), a.resume, a.retry_errors, a.after)
    elif a.what == "digest": digest(a.game, rooms, GAMESTATE if a.out == ap.get_default("out") else a.out)
    elif a.what == "paths": paths_report(a.game, os.path.join(RL, "work", "roomdump_paths.txt") if a.out == ap.get_default("out") else a.out)
    elif a.what == "track": track(a.game, rooms, 600 if a.frames == ap.get_default("frames") else a.frames, a.speed, os.path.join(a.game, a.exe))
    else: compare(a.game, rooms, a.out)


if __name__ == "__main__":
    main()
