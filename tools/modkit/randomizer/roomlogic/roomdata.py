"""
roomdata.py: the game's rooms as the room logic sees them: what's solid, what's a jump-through platform, a hazard,
water, a spring, a gate (solid until the player has something), an exit to another room, a door within the room, and
where the Randomizer's locations are. Each instance's creation code and Create event are run (gmleval) in the
Randomizer's world (a new game's globals, then the endgame world state the mod starts in), so an instance the endgame
world removes isn't there, and its size, place and exit are what that code makes them.

usage: python roomdata.py [<rooms.txt>]     (default: work\rooms.txt; roomlogic.py runs it)

rooms.txt, one line an instance, tab-separated (RoomLogic.cs reads it):
  R room width height area areaname                            a room (the lines after it are its instances)
  S|P|H|W sprite x y xscale yscale angle                       solid, platform, hazard, water
  HV sprite x y xscale yscale angle requirement name           a hazard the requirement makes harmless (Gate 5's lava:
                                                               varia, the Varia Suit)
  G sprite x y xscale yscale angle requirement name            gate: solid until the requirement is met
  J sprite x y xscale yscale angle L|S                         spring (large, small)
  X sprite x y xscale yscale angle toRoom x y exitType name [group state]
                                                               exit to another room (exitType 0 up, 1 touch, 2 down,
                                                               3 stand on it and press up or down); with a group, where
                                                               it leads in that state of a carried group (two lines an
                                                               exit: the Forest Palace's crystals turn its rooms over)
  D sprite x y xscale yscale angle x y exitType                a door to another place in the same room
  V sprite x y xscale yscale angle                             an elevator (oUseElevator)
  K sprite x y xscale yscale angle                             a Strike Chain point (Mega Man's grapple latches on)
  KR sprite x y xscale yscale angle                            a Strike Chain point that flies left and right along its
                                                               row, turning at walls (a Ripper's)
  PR sprite x y xscale yscale angle                            a rock the player pushes (it slides when walked into, and
                                                               falls off edges)
  N sprite x y xscale yscale angle line x1 y1 x2 y2            a moving platform the player rides, and where it goes
  N sprite x y xscale yscale angle circle cx cy r              (along a line, or round a circle)
  L sprite x y xscale yscale angle type number fall label      a location (fall 1: the pickup falls to the ground; label
                                                               its name, "skill point 59")
  T sprite x y xscale yscale angle group state [ride]          a solid in one state of a group the room's switches
                                                               change (rb the red and blue blocks, pb the sliding
                                                               blocks, b<GID> a switch's barrier, ice the ice platforms,
                                                               brk the bricks the head breaks); ride: a block that
                                                               carries the player standing on it from one state's place
                                                               to the other's (two lines a block, state 0 then 1)
  SW sprite x y xscale yscale angle group attack|bump|ice|normal [once]
                                                               a switch: hit (an attack, the head from below, an
                                                               elemental attack, the sword or the whip close up), the
                                                               group's state changes (once: only from the state it
                                                               starts in)
  SW sprite x y xscale yscale angle water N                    a Water Palace switch: hit, the water goes to level N
  RS group state                                               the state a group starts in (the room sets it as the
                                                               player comes in: rb, water)
  RG group state                                               the same, in a room that has nothing of the group's
  CG group                                                     a state the player carries from room to room (rb: the
                                                               red/blue switches'; water: the Water Palace's level;
                                                               crystal1-3: the Forest Palace's crystals)
  RBAUTO                                                       enemies' shots or moving traps hit the room's red/blue
                                                               switches by themselves
  TW sprite x y xscale yscale angle N                          water at the Water Palace's level N
  FP sprite x y xscale yscale angle                            a floating platform (rises with water, falls without)
  FN sNull x y 1 yscale 0 way [group state]                    a fan (Begonia's) at x,y blowing the player way (0 right,
                                                               90 up, 180 left, 270 down); with a group, only in that
                                                               state of it (a fan switch's)
  SP sprite x y xscale yscale angle tag                        a spot: reaching it is the event <room>/<tag> (a colored
                                                               switch the party split's partner holds, a colored key)
  PI x y [xThres newX newY rev]                                the party split's idle partner: where it starts (at
                                                               newX,newY when the player comes in past xThres; before it
                                                               with rev)
  U sprite x y xscale yscale angle group state line x1 y1 x2 y2
                                                               a moving platform (as N) there only in one state of a
                                                               group (cpm: the Magical Castle's platform makers)
  F sNull x y 1 1 0 object                                     a flying enemy the Mario Ability Set can bounce off
  M object x y                                                 a moving solid left out (for the report)
  B x y                                                        where a boss fight starts (the Randomizer's)
  Q                                                            the room is a map (an overworld): its exits all connect
  QW                                                           the room is a map the player walks across as an icon
                                                               (Zelda II's overworld: 16px steps, rivers and mountains
                                                               in the way): a way in reaches the exits its walk gets to;
                                                               exits named encounter are reached from anywhere on it
  BV room room                                                 (before the rooms) going from one to the other is a
                                                               boss fight (rndgen.py's BOSS_VIA)
  CARRY group state [scope]                                    (before the rooms) a carried state as a new game starts;
                                                               with a scope (a room name prefix), it's kept only within
                                                               those rooms (solve.py)
Requirements: alternatives separated by |, each a comma-separated list of item:count (link:1,samus:4), key:N for the
key of locked door N, event:NAME for an event (solve.py's events.txt), attack for any ability set's attack, "-" for
nothing.
"""
import os, re, sys, collections
HERE = os.path.dirname(os.path.abspath(__file__))
RAND = os.path.dirname(HERE)
PROJ = os.path.normpath(os.path.join(RAND, "..", "..", ".."))
sys.path.insert(0, RAND)
sys.path.insert(0, HERE)
import rndgen
import gmleval
from gmleval import UNK, Res

ROOMS = os.path.join(PROJ, "rooms")
OBJECTS = os.path.join(PROJ, "objects")

# the Randomizer's start: where the player comes out of the door from Greatest Stretch in Central City - North
START = ("rCCity_NorthA", 608, 320)
# the red and blue blocks and their switches (the state is the player's, carried from room to room)
RB_OBJECTS = {"oRBswitch", "oRedBlocker", "oBlueBlocker", "oRedMBlock", "oBlueMBlock", "oMarioRBblock"}
# what hits red/blue switches by itself (they take enemies' shots and traps as well as the player's attacks): a
# Sparky's sparks, and traps that move or zap
SWITCH_HITTERS = {"oSparky", "oPlatformFollower", "oZapTrap", "oZapTrapRed", "oMarioChainBall", "oMovingTrap"}
# what a timed switch's barrier counts as needing (all of it: what the game's timed switches take between them)
TIMED_SWITCH = "megaman:3,link:3,belmont:2,samus:5"
# the Water Palace's water levels (oWaterSwitch's wLvlTarget): its switches show 1, 2 or 3
WATER_LEVELS = {1: 176, 2: 368, 3: 640}
# the Forest Palace (rLink2_PalaceF_*): the crystal in its rooms 3, 5 and 7 (oG2_ForestCrystal), hit with the sword or
# the whip, flips global.mySegmentCheck[0], [1] or [2], and that turns the palace's middle rooms over: the exits that
# led to room 2a lead to 2b (and back), 4a/4b and 6a/6b the same. The player carries them from room to room as
# crystal1-3 (as the red/blue switches' state)
CRYSTALS = {"rLink2_PalaceF_3": 1, "rLink2_PalaceF_5": 2, "rLink2_PalaceF_7": 3}
SEGMENTS = "mySegmentCheck"
# (the rooms they matter in: the palace's, by name)
CRYSTAL_SCOPE = "rLink2_PalaceF_"
WORLD_PROGRESS = 5641   # rndInit's rndWorldProg

# ---------------------------------------------------------------- what each object is
PLATFORMS = "oPlatform"
WATER = "oWater"
# placeholders that destroy themselves at once (the game's collision is in oInvisibleSolid and the slopes)
# hazards: the trap zones that stay where they are and hurt or kill on touch (moving and timed traps aren't counted)
HAZARDS = {"oSpikeZone", "oMarioSpikeFloor", "oStaticSpikeRed", "oStaticSpike", "oMarioSpikeCeiling", "oMM_Spike",
           "oCastleRedSpike", "oInstakillZone", "oScaledTrapZone", "oMarioSpikeR", "oMarioSpikeL", "oMarioLava",
           "oMetLava", "oCh19Spikes", "oLongSpikeCeiling", "oLongSpikeFloor", "oMarioLavaRev", "oMRustySpike",
           "oG6Lava", "oLongSpikeL", "oLongSpikeR", "oVillageFire", "oVP_RoomFire"}
SPRINGS = {"oLargeJumper": "L", "oSmallJumper": "S"}
# flying enemies the Mario Ability Set stomps (oEMarioBase's children and the like: the player bounces off one at -13.5,
# a double jump and air dash back): RoomLogic.cs lets a jump near one bounce off it at the top
BOUNCERS = {"oGreenParatroopa", "oRedParatroopa", "oLakitu", "oBulletBill", "oDistBulletBill", "oWingedMelon", "oCackBat",
            "oHF_MovingEye", "oMagicalBat", "oToady", "oWS_TheGuardian"}
ATTACK = "attack"
NORMAL_HIT = "link:1|belmont:1"           # damageType NORMAL, weaponTag<100: Link's sword, Belmont's whip
EXPLOSION = "link:3|samus:6"              # Link's bombs (Fuse Bomb), Samus' morph bombs
# gates: solid till the player has what opens them (a requirement, or a function of the instance's variables)
def metroid_wall(v):
    sp, im = v.get("spIndex"), v.get("spImage")
    if sp == "sMetroidBlockBreak": return ATTACK
    if sp == "sMetroidBlockHit":
        return {0: "samus:6", 1: "samus:4", 2: "samus:4"}.get(im)
    return None
def metroid_door(v):
    return {0: ATTACK, 1: "samus:4", 2: "samus:4"}.get(v.get("type"))
def locked_door(v):
    n = v.get("objectNum")
    return "key:%d" % n if isinstance(n, int) else None
def event_from_code(code):
    """an event barrier whose code waits for something the game remembers: the event it needs (solve.py's events.txt
    says what makes each happen), or None: any instrument (eGateProg, every gate's), a Nightmare Gate's boss beaten
    (eGateProg's character for that gate), an area visited (mapAreas)"""
    if re.search(r"string_char_at\(\s*global\.eGateProg\s*,\s*i\s*\+\s*1\s*\)", code): return "event:instrument"
    m = re.search(r"string_char_at\(\s*global\.eGateProg\s*,\s*(\d)\s*\)", code)
    if m: return "event:gate" + "ABCDEFGH"[int(m.group(1)) - 1]
    m = re.search(r"string_char_at\(\s*global\.mapAreas\s*,\s*(\d+)\s*\)", code)
    if m: return "event:area" + m.group(1)
    return None
def event_barrier(v):
    sc = v.get("spriteChange", 0)
    # a reach ring barrier (the Farreaches): it opens once the player goes through all the room's rings, each within
    # about a second of the last (oCh9RingManager): counted as needing the dash
    if sc == 5: return "gdash"
    if sc in (1, 3, 4): return None         # opened by something in the room, not the story: stays shut here
    pc = v.get("progCheck")
    if isinstance(pc, (int, float)) and pc <= WORLD_PROGRESS: return "open"
    return None
GATES = {
    "oLockedDoor": locked_door,
    "oBreakableMetroidWall": metroid_wall,
    "oMetroidDoorHolder": metroid_door,
    "oBreakableW_Coded": lambda v: NORMAL_HIT, "oBustBlock": lambda v: NORMAL_HIT, "oBreakableWall": lambda v: NORMAL_HIT,
    "oCh18BustBlock": lambda v: ATTACK,
    "oBreakableExplodeWall": lambda v: EXPLOSION, "oBreakableWExp_Coded": lambda v: EXPLOSION, "oBreakRock": lambda v: EXPLOSION,
    "oEnemyBarrier": lambda v: "-", "oEnemyTestDoor": lambda v: "-",
    "oEventBarrier": event_barrier,
    # Storm Eagle's flame canisters: any attack but a NORMAL one (the sword, the whip) breaks them, and each blows up the
    # ones next to it: a shot, an arrow, a dagger...
    "oMMFlameCanister": lambda v: "megaman:1|samus:1|link:2|belmont:2",
}
# moving solids that stay where they're placed till the player does something: solid as placed
STATIC_MOVING = {"oConveyorA", "oPushRock", "oShakeFallPlat", "oPlatform_CVFall", "oMarioCastleBlock",
                 "oMetroidBlockDisappear", "oCh17SecDoor", "oStepDoorA", "oMetalBlock", "oWrenchBlock", "oPlatformTouch",
                 "oDummyPlat", "oTimerPlatform", "oCh18GeyserPlat", "oSpikePlatformA", "oMMIntroCollA", "oPSF_Cart",
                 "oWaterFloatPlatform", "oSF_Tile2", "oSF_Tile3", "oSF_Tile4", "oWSEs_PlatA", "oPlatformBlock",
                 "oStepSwitchA", "oMCastle_PlatA", "oMMWallCrush"}
# moving platforms the player rides: back and forth along a line (xDir, yDir a tick for shiftChange-2 ticks, after a
# first step in Alarm 0), round a circle, or down while stood on (scales). The rest (crushers, the gravity well's
# platforms, rails, the Nightmare Gates' platforms) are left out: the logic doesn't use them
LINE_MOVERS = {"oMovingPlatform", "oG6_EarthPlat", "oVaultMovingPlat", "oMMEaglePlat"}


def mover_path(obj, v, room_w, room_h):
    """the path of a moving platform's position: ("line", x1, y1, x2, y2), ("circle", cx, cy, r), ("static",) or None"""
    import math
    def n(k):
        t = v.get(k)
        return t if isinstance(t, (int, float)) and not isinstance(t, bool) else None
    x, y = n("x"), n("y")
    if x is None or y is None: return None
    if obj in LINE_MOVERS:
        if obj == "oG6_EarthPlat" and v.get("bAutoMove") not in (1, True): return ("static",)
        if "doNotMove" in v: return ("static",)
        xd, yd, sc = n("xDir"), n("yDir"), n("shiftChange")
        if xd is None or yd is None or sc is None: return None
        sx, sy = x + round(xd), y + round(yd)
        steps = max(0, sc - 2)
        return ("line", sx, sy, sx + steps * xd, sy + steps * yd)
    if obj == "oCirclePlatform":
        d0, rate, spd = n("dirStart"), n("changeRate"), n("pSpeed")
        if d0 is None or not rate or spd is None: return None
        w = math.radians(rate)
        a = math.radians(d0)
        r = spd / w
        return ("circle", x - r * math.sin(a), y + r * math.cos(a), abs(r))
    if obj in ("oPlatformScale", "oPlatBud"):
        if obj == "oPlatBud" and v.get("type") != 0: return None
        fs, dm = n("fallSpeed"), n("distMax")
        if fs is None or dm is None or fs == 0: return ("static",)
        return ("line", x, y, x, y + (dm if fs > 0 else -dm))
    if obj == "oPlatformAutoMove":
        mx, my = n("moveSpeedX"), n("moveSpeedY")
        if mx is None or my is None: return None
        if mx == 0 and my == 0: return ("static",)
        # on to the room's edge (it's destroyed past it)
        t = min([((room_w + 24 - x) / mx) if mx > 0 else ((x + 24) / -mx) if mx < 0 else 1e9,
                 ((room_h + 24 - y) / my) if my > 0 else ((y + 24) / -my) if my < 0 else 1e9])
        return ("line", x, y, x + mx * t, y + my * t)
    return None
# solids that aren't there in the Randomizer's world for other reasons
NOT_SOLID = {"oSeekerAlertDoor"}   # shuts only when the player's spotted
EXITS = {"oExit", "oAccessGate", "oMMBossDoor", "oDistortionGate"}
# other ways to another room, the place they go to fixed in their code: (exitType, toRoom, x, y)
FIXED_EXITS = {"oVaultGate": (0, "rVault_1", 160, 288),        # (the Vault, from the Farreaches)
               "oShooter_Start": (0, "rWarshipA", 1072, 416)}  # (the shooter's menu goes on to the Warship once it's done)
LOCATIONS = {o: c for c, o, l in rndgen.LTYPES if c not in rndgen.KEEP_TYPES}
# the story's ability pickups (oStoryObject instances: rndgen.STORY_SPOTS), by room and room editor id, and by room and
# where they were placed (the instances' list below has no ids): their numbers
STORY_AT = {(room, hexid): n for n, room, hexid, what in rndgen.STORY_SPOTS}
STORY_POS = {(room,) + rndgen.story_place(room, hexid)[:2]: n for n, room, hexid, what in rndgen.STORY_SPOTS}


def menu_exits(room, world):
    """the ways out of a room whose way out is a menu, not exits (toRoom, x, y): Gate 4's stage select (oEvCh8Map): a
    Maverick's stage once it's beaten (gameGate4Prog: its intro otherwise, left out), the Sigma stages, the gate and
    the shop"""
    if room != "rMega4_Map": return []
    prog = str(world.get("gameGate4Prog", "000"))
    out = [(r, x, y) for i, (r, x, y) in enumerate((("rMega4_StormA", 80, 192), ("rMega4_OstrichA", 128, 160),
                                                    ("rMega4_ToxicJungleA", 80, 272))) if prog[i:i + 1] == "9"]
    return out + [("rMega4_SigmaA1", 80, 592), ("rMega4_SigmaB1", 80, 640), ("rMega4_SigmaC1", 96, 304),
                  ("rMega4_Gate", 208, 304), ("rMega4_Shop", 160, 312)]
FALLING_PICKUPS = {"oDoorKey"}
ELEVATOR = "oUseElevator"
MAP_EXITS = {"oZeldaMapExit", "oGameMapExit"}
# Zelda II's overworld (oPlayerZeldaIcon): an encounter enemy that touches the icon starts a fight in the room for the
# tile under it (oPlayerZeldaIcon's User Event 1: road, grass, desert, forest); the player starts where the room places
# oPlayer1 (oPlayer1 leaves them there). In the endgame world the enemies only spawn while the icon is on grass, desert
# or forest, and one can follow it onto a road: reaching the overworld is enough for any of them
WALK_ICON = "oPlayerZeldaIcon"
ENCOUNTERS = [("rLink2_EnRoad", 240, 288), ("rLink2_EnGrass", 640, 288), ("rLink2_EnDesert", 640, 288),
              ("rLink2_EnForest", 640, 304)]
# the events whose code is run after the creation code and Create (they set the instance up a step later)
ALARM_OBJECTS = {"oInvisibleSolid", "oMetroidDoorHolder", "oMarioLava", "oMarioLavaRev", "oPlatformBreak1",
                 "oPlatTempFade", "oScaledTrapZone", "oLargeJumper", "oMMWallCrush"}


def read(p):
    return open(p, encoding="utf-8", errors="replace").read()


def kv(p):
    d = {}
    if os.path.exists(p):
        for l in read(p).split("\n"):
            if "=" in l:
                k, v = l.split("=", 1); d[k.strip()] = v.strip()
    return d


class Project:
    def __init__(self):
        self.parent, self.sprite, self.mask, self.events = {}, {}, {}, {}
        for f in os.listdir(OBJECTS):
            if f.endswith(".txt"):
                o = f[:-4]; d = kv(os.path.join(OBJECTS, f))
                self.parent[o] = d.get("parent", ""); self.sprite[o] = d.get("sprite", ""); self.mask[o] = d.get("mask", "")
        self.resources = set(self.parent)
        for sub in ("sprites", "backgrounds", "rooms", "scripts", "sounds", "fonts", "paths", "timelines"):
            d = os.path.join(PROJ, sub)
            if os.path.isdir(d):
                for f in os.listdir(d): self.resources.add(os.path.splitext(f)[0])

    def chain(self, o):
        out = []
        while o and o not in out and len(out) < 30:
            out.append(o); o = self.parent.get(o, "")
        return out

    def is_a(self, o, base):
        return base in self.chain(o)

    def event(self, o, ev):
        if o not in self.events:
            ev_map = {}
            p = os.path.join(OBJECTS, o + ".gml")
            if os.path.exists(p):
                parts = re.split(r"^#define (\w+)\s*$", read(p), flags=re.M)
                for i in range(1, len(parts), 2):
                    body = re.sub(r"^\s*/\*\"/\*'/\*\*//\* YYD ACTION.*?\*/\s*?\n", "", parts[i + 1], count=1, flags=re.S)
                    ev_map[parts[i]] = body
            self.events[o] = ev_map
        return self.events[o].get(ev)

    def gone_at_once(self, o):
        """whether the object's Create event is just instance_destroy() (a placeholder)"""
        code = self.event(o, "Create_0")
        return code is not None and re.sub(r"\s", "", code) == "instance_destroy()"

    def event_inherited(self, o, ev):
        """the event's code for an object, as it runs: its own (with event_inherited() running the parent's), or the
        nearest parent's"""
        for c in self.chain(o):
            code = self.event(c, ev)
            if code is not None: return c, code
        return None, None


def world_state(proj):
    """the globals in a new Randomizer game: initGameVars' new game, the endgame world (world.txt), rndNewGame's own"""
    world = {}
    ctx = gmleval.Ctx(world, proj.resources, write_globals=True)
    code = read(os.path.join(PROJ, "scripts", "initGameVars.gml"))
    gmleval.execute(gmleval.parse(code), [gmleval.Way({})], ctx)
    keys = rndgen.save_keys()
    for line in open(os.path.join(RAND, "world.txt"), encoding="utf-8"):
        line = line.split("#", 1)[0].strip()
        if not line or "=" not in line: continue
        k, v = [s.strip() for s in line.split("=", 1)]
        if k not in keys: continue
        g, kind = keys[k]
        val = v if kind == "string" else (float(v) if "." in v else int(v))
        if "[" in g:
            # (an array's element: "mySegmentCheck[0]")
            name, idx = g[:-1].split("[", 1)
            if not isinstance(world.get(name), dict): world[name] = {}
            world[name][int(idx)] = val
            continue
        world[g] = val
    world.update({"CHAOS_Invasion": 0, "CHAOS_Upgrade": 0, "eGateProg": "00000000", "gateHProg": 0, "abomAttempts": 0,
                  "gameProgress": WORLD_PROGRESS, "gameCompleted": 0, "bBossGallery": 0, "bNightmareMode": 0,
                  "gamePaused": False})
    world.pop("activeCharacter", None)     # Jerry or Claire
    return world


class Runner:
    def __init__(self, proj, world):
        self.proj = proj; self.world = world; self.room = ""

    def run_event(self, obj, ev, way, ctx, depth=0):
        """runs an object's event (and its parents' where it calls event_inherited) on a way"""
        owner, code = self.proj.event_inherited(obj, ev)
        if code is None or depth > 10: return [way]
        tree = gmleval.parse(code)
        if tree[0] == "error": ctx.exact = False; return [way]
        par = self.proj.parent.get(owner, "")
        # event_inherited() runs the parent's event: done by splitting the code at the call
        stmts = tree[1]
        ways = [way]
        for s in stmts:
            if s[0] == "callst" and s[1][1] == "event_inherited":
                out = []
                for w in ways:
                    out += self.run_event(par, ev, w, ctx, depth + 1) if par else [w]
                ways = out
            else:
                ways = gmleval.execute(s, ways, ctx)
        return ways

    def instance(self, obj, x, y, code, room_w, room_h, area, world=None):
        """the instance after its creation code, Create event (and Alarm 0 for some): a gmleval Result (world: other
        globals than the Randomizer world's)"""
        world = dict(self.world if world is None else world); world["location"] = area if area is not None else UNK
        ctx = gmleval.Ctx(world, self.proj.resources)
        spr = self.proj.sprite.get(obj, ""); msk = self.proj.mask.get(obj, "")
        start = {"x": x, "y": y, "xstart": x, "ystart": y, "image_xscale": 1, "image_yscale": 1, "image_angle": 0,
                 "sprite_index": Res(spr) if spr else -1, "mask_index": Res(msk) if msk else -1,
                 "room_width": room_w, "room_height": room_h, "image_index": 0, "image_speed": 1, "image_alpha": 1,
                 "image_blend": 16777215, "visible": 1, "depth": 0, "object_index": Res(obj), "room": Res(self.room)}
        tree = gmleval.parse(code or "")
        exact = True
        if tree[0] == "error":
            return gmleval.Result(start, 2, False)
        ways = gmleval.execute(tree, [gmleval.Way(dict(start))], ctx)
        exact &= ctx.exact
        out = []
        for w in ways:
            w.exited = False
            out += self.run_event(obj, "Create_0", w, ctx)
        ways = out
        if obj in ALARM_OBJECTS:
            out = []
            for w in ways:
                w.exited = False
                out += self.run_event(obj, "Alarm_0", w, ctx)
            ways = out
        exact &= ctx.exact
        names = set()
        for w in ways: names |= set(w.vars)
        vars = {}
        for n in names:
            vals = [w.vars.get(n, UNK) for w in ways]
            v0 = vals[0]
            vars[n] = v0 if all(v is not UNK and v == v0 and type(v) is type(v0) for v in vals) else UNK
        ds = {w.destroyed for w in ways}
        if any(w.maybe for w in ways): ds |= {0, 1}
        return gmleval.Result(vars, ds.pop() if len(ds) == 1 else 2, exact)


def fnum(v):
    if isinstance(v, bool): return str(int(v))
    if isinstance(v, float) and v == int(v): return str(int(v))
    return str(v)


def gml_value(v):
    """a value as GML code (for the variables a room's code gives an instance it makes)"""
    if isinstance(v, Res): return str(v)
    if isinstance(v, str): return '"%s"' % v.replace('"', "'")
    return fnum(v)


def main():
    out_path = sys.argv[1] if len(sys.argv) > 1 else os.path.join(HERE, "work", "rooms.txt")
    os.makedirs(os.path.dirname(os.path.abspath(out_path)), exist_ok=True)
    proj = Project()
    world = world_state(proj)
    run = Runner(proj, world)
    rooms = rndgen.room_names()
    rarea = rndgen.room_areas(rooms)
    anames = rndgen.area_names()
    report = collections.Counter()
    notes = []
    lines = []
    bosses = boss_starts()
    import traps
    trap_gates = traps.room_gates()
    for room in rooms:
        rd = os.path.join(ROOMS, room)
        rs = kv(os.path.join(rd, "room.txt"))
        if not rs: continue
        W, H = int(rs.get("width", 0)), int(rs.get("height", 0))
        area = rarea.get(room)
        run.room = room
        lines.append("R\t%s\t%d\t%d\t%s\t%s" % (room, W, H, area if area is not None else -1, anames.get(area, "")))
        if room in bosses:
            lines.append("B\t%d\t%d" % bosses[room])
        is_map = False
        # the room's own code (run after its instances are made): the instances it surely destroys and the ones it
        # surely makes (a floor the endgame world gets, a door taken away)
        world_r = dict(world); world_r["location"] = area if area is not None else UNK
        rc = os.path.join(rd, "code.gml")
        created, destroys = gmleval.room_effects(read(rc) if os.path.exists(rc) else "",
                                                 {"room": Res(room), "room_width": W, "room_height": H},
                                                 gmleval.Ctx(world_r, proj.resources))
        gone_objs = {n for k, n in destroys if k == "obj"}
        gone_gids = {n for k, n in destroys if k == "gid"}
        # (and what the scene controllers it makes surely destroy in their Step, in this world: Gate 5's Metroid rooms'
        # oEvCh13MetroidControl takes the room's event barriers away once the story's past the room)
        for obj, cx, cy, props in created:
            owner, step = proj.event_inherited(obj, "Step_0")
            if step is None: continue
            c2, d2 = gmleval.room_effects(step, {"room": Res(room), "room_width": W, "room_height": H, "x": cx, "y": cy},
                                          gmleval.Ctx(world_r, proj.resources))
            gone_objs |= {n for k, n in d2 if k == "obj"}
            gone_gids |= {n for k, n in d2 if k == "gid"}
        todo = []
        for obj, x, y, hexid, code in rndgen.instances(room) or []:
            m = re.search(r"GID_SET\(\s*(\d+)", code)
            if (room, hexid) in STORY_AT and obj == "oStoryObject":
                pass   # (a story pickup's place stays, whatever takes the pickup out: STORY_AT below)
            elif (m and int(m.group(1)) in gone_gids) or any(c in gone_objs for c in proj.chain(obj)):
                report["destroyed by the room's code"] += 1
                continue
            todo.append((obj, x, y, code))
        for obj, x, y, props in created:
            todo.append((obj, x, y, "\n".join("%s=%s" % (k, gml_value(v)) for k, v in props.items())))
            report["made by the room's code"] += 1
        # (Gate 4's stages' ways back, which a Randomizer game adds: rndgen.py's MM_BACK_EXITS, the roomStart hook)
        for broom, bx, by, to, tx, ty in rndgen.MM_BACK_EXITS:
            if broom == room:
                todo.append(("oExit", bx, by, "exitType=1\nbShowArrow=true\ntoRoom=%s\nnewMapX=%d\nnewMapY=%d" % (to, tx, ty)))
                report["way back added (Gate 4's stages)"] += 1
        # the switches: which are on already (a switch holder's code turns it on once the story's past it, and its
        # barriers are gone), and where each is (by its GID, for the barriers that name it)
        holders = {}
        for obj, x, y, code in todo:
            if obj not in ("oSwitchHolder", "oTimedSwitch"): continue
            m = re.search(r"GID_SET\(\s*(\d+)", code)
            if not m: continue
            r = run.instance(obj, x, y, code, W, H, area)
            spr = r.vars.get("sprite_index")
            holders[int(m.group(1))] = {"on": obj == "oSwitchHolder" and r.vars.get("bSendActive") == 1, "x": x, "y": y,
                                        "spr": spr if isinstance(spr, Res) else Res(proj.sprite.get(obj, ""))}
        switches_used = set()
        # the red and blue switches' state (global.rbSwitchBlueOn) and the Water Palace's water level (wpWaterLevel) are
        # the player's, carried from room to room: a room with red/blue blocks or switches carries it (CG rb), and sets
        # it as the player comes in if its code does (RS; RG where the room has none of them); a Water Palace room whose
        # water is at wpWaterLevel carries that (CG water). A Sparky's sparks hit the red/blue switches too (SPARKY)
        m = re.search(r"global\.rbSwitchBlueOn\s*=\s*(true|false|1|0)\b", read(rc) if os.path.exists(rc) else "")
        rb_reset = None if not m else (1 if m.group(1) in ("true", "1") else 0)
        objs_here = {obj for obj, x, y, code in todo}
        has_rb = bool(objs_here & RB_OBJECTS)
        # colored switches, keys and locks: a colored switch keeps its barriers open while someone stands on it, so in a
        # party split room (the two characters, one idle where it was left) the partner can be left on it: its barriers
        # are open once the party reaches it (a spot the room file works out, the barriers needing that spot's event);
        # a colored key opens the door its color's lock panel names (once the key's reached: the lock's beside the door)
        split = re.search(r"global\.partySplit\s*=\s*1\b", read(rc) if os.path.exists(rc) else "") is not None
        door_of = {}      # a barrier's GID -> the spot that opens it
        spots = []        # (tag, x, y, sprite)
        for obj, x, y, code in todo:
            if obj == "oSwitchPanelColor" and split:
                tag = "switch%d" % (len(spots) + 1)
                spots.append((tag, x, y, "sSwitchPanelColor"))
                for g in re.findall(r"idsForTargetDoors\[\d+\]\s*=\s*(\d+)", code): door_of[int(g)] = tag
        keys = {}
        for obj, x, y, code in todo:
            if obj == "oKeyColor":
                m = re.search(r"image_index\s*=\s*(\d+)", code); keys[int(m.group(1)) if m else 0] = (x, y)
        for obj, x, y, code in todo:
            if obj == "oLockPanelColor":
                m = re.search(r"image_index\s*=\s*(\d+)", code); c = int(m.group(1)) if m else 0
                g = re.search(r"idForTargetDoor\s*=\s*(\d+)", code)
                if g and c in keys:
                    tag = "key%d" % (c + 1)
                    if tag not in [s[0] for s in spots]: spots.append((tag, keys[c][0], keys[c][1], "sKeyColor"))
                    door_of[int(g.group(1))] = tag
        for tag, sx, sy, spr in spots:
            if tag in door_of.values(): lines.append("SP\t%s\t%d\t%d\t1\t1\t0\t%s" % (spr, sx, sy, tag))
        water_carried = any(obj == "oWaterVolume" and "wpWaterLevel" in code for obj, x, y, code in todo)
        # (the Forest Palace's crystals the room's crystal or exits go by: carried, CG)
        crystals = set()
        # Begonia's fan switches: hit, each turns its fans on or off (a group of the room's for each switch)
        fan_group = {}
        for obj, x, y, code in todo:
            if obj == "oFanSwitch":
                for g in re.findall(r"fanID\[\d+\]\s*=\s*\(?\s*GID\(\s*(\d+)\s*\)", code):
                    fan_group.setdefault(int(g), "fan%d_%d" % (x, y))
        for obj, x, y, code in todo:
            ch = proj.chain(obj)
            if obj == "oBegoniaFan":
                # a fan: it blows the player its way (8px a tick) in a stream 224px long and 32px wide (times its
                # yscale), unless something solid is between it and the player. One that starts off (noSpin) blows once
                # its switch turns it on (state 1 of the switch's group); one with no switch stays off (the chest in
                # rMain_25ExtA starts its fan)
                r = run.instance(obj, x, y, code, W, H, area)
                v = r.vars
                fx, fy, fys, ang = v.get("x"), v.get("y"), v.get("image_yscale", 1), v.get("image_angle", 0)
                if r.destroyed == 1 or not all(isinstance(t, (int, float)) for t in (fx, fy, fys, ang)): continue
                way = int(ang) % 360
                if way not in (0, 90, 180, 270): continue
                on = "noSpin" not in v
                m = re.search(r"GID_SET\(\s*(\d+)", code)
                grp = fan_group.get(int(m.group(1))) if m else None
                if grp:
                    lines.append("FN\tsNull\t%s\t%s\t1\t%s\t0\t%d\t%s\t%d" % (fnum(fx), fnum(fy), fnum(fys), way, grp, 0 if on else 1))
                elif on:
                    lines.append("FN\tsNull\t%s\t%s\t1\t%s\t0\t%d" % (fnum(fx), fnum(fy), fnum(fys), way))
                report["fan"] += 1
                continue
            if obj == "oFanSwitch":
                r = run.instance(obj, x, y, code, W, H, area)
                v = r.vars
                grp = "fan%d_%d" % (x, y)
                if r.destroyed == 1 or grp not in fan_group.values(): continue
                spr = v.get("sprite_index")
                lines.append("SW\t%s\t%s\t%s\t%s\t%s\t%s\t%s\tattack" % (spr if isinstance(spr, Res) else proj.sprite.get(obj), fnum(v.get("x", x)),
                             fnum(v.get("y", y)), fnum(v.get("image_xscale", 1)), fnum(v.get("image_yscale", 1)), fnum(v.get("image_angle", 0)), grp))
                report["fan switch"] += 1
                continue
            # what a room's switches change: a state of the room (RoomLogic.cs works out each state's places, and goes
            # from one to another where a switch can be hit)
            if obj in ("oRBswitch", "sSwitchPlatformBlock"):
                r = run.instance(obj, x, y, code, W, H, area)
                if r.destroyed == 1: continue
                spr = r.vars.get("sprite_index")
                lines.append("SW\t%s\t%d\t%d\t1\t1\t0\t%s\tattack" % (spr if isinstance(spr, Res) else proj.sprite.get(obj), x, y,
                                                                    "rb" if obj == "oRBswitch" else "pb"))
                continue
            if obj == "oWaterVolume" and water_carried:
                # the Water Palace's water: at the level the player brings in (1 y 176, 2 y 368, 3 y 640), the room's
                # width and height under it
                r = run.instance(obj, x, y, code, W, H, area)
                xs, ys = r.vars.get("image_xscale", W), r.vars.get("image_yscale", H)
                for lv, wy in WATER_LEVELS.items():
                    lines.append("TW\tsScaledCollision\t0\t%d\t%s\t%s\t0\t%d" % (wy, fnum(xs), fnum(ys), lv))
                continue
            if obj == "oG2_ForestCrystal":
                # a Forest Palace crystal: hit with the sword or the whip (damageType NORMAL), it flips its crystal's
                # state, back and forth (CRYSTALS: which one the room's is)
                n = CRYSTALS.get(room)
                r = run.instance(obj, x, y, code, W, H, area)
                if n and r.destroyed != 1:
                    spr = r.vars.get("sprite_index")
                    lines.append("SW\t%s\t%d\t%d\t1\t1\t0\tcrystal%d\tnormal" % (spr if isinstance(spr, Res) else proj.sprite.get(obj), x, y, n))
                    crystals.add(n); report["Forest Palace crystal"] += 1
                continue
            if obj == "oWaterSwitch":
                # a Water Palace switch: hit, it sets the water to its level (wLvlTarget)
                r = run.instance(obj, x, y, code, W, H, area)
                lv = {wy: l for l, wy in WATER_LEVELS.items()}.get(r.vars.get("wLvlTarget"))
                if r.destroyed != 1 and lv:
                    lines.append("SW\tsSwitchHolder\t%d\t%d\t1\t1\t0\twater\t%d" % (x, y, lv)); report["water switch"] += 1
                continue
            if obj == "oBillBlaster":
                # a Bill Blaster fires Bullet Bills (flying Mario enemies, 7.5px a tick) from 8px under it: they come by
                # there to bounce off
                r = run.instance(obj, x, y, code, W, H, area)
                if r.destroyed != 1:
                    lines.append("F\tsNull\t%d\t%d\t1\t1\t0\toBulletBill" % (x, y + 8))
                    report["Bill Blaster (Bullet Bills to bounce off)"] += 1
                continue
            if obj in BOUNCERS:
                r = run.instance(obj, x, y, code, W, H, area)
                if r.destroyed != 1:
                    lines.append("F\tsNull\t%d\t%d\t1\t1\t0\t%s" % (x, y, obj))
                    report["flying enemy to bounce off"] += 1
                continue
            if obj == "oMarioBreakBlock":
                # a brick: the head hitting it from below breaks it (one with an item in it only gives it: solid). The
                # room's brk state has the bricks the head can get to gone (RoomLogic.cs works out which)
                r = run.instance(obj, x, y, code, W, H, area)
                if r.destroyed == 1: continue
                if "altItem" in r.vars:
                    lines.append("S\tsMarioBreakBlock\t%d\t%d\t1\t1\t0" % (x, y)); continue
                lines.append("T\tsMarioBreakBlock\t%d\t%d\t1\t1\t0\tbrk\t0" % (x, y))
                lines.append("SW\tsMarioBreakBlock\t%d\t%d\t1\t1\t0\tbrk\tbump\tonce" % (x, y))
                report["brick"] += 1
                continue
            if obj == "oDonutPlatformStart":
                # a donut platform (it makes oDonutPlatform once the player isn't in its way): stood on, it falls after
                # a moment, so it's somewhere to land and jump from
                lines.append("S\tsDonutPlatform\t%d\t%d\t1\t1\t0" % (x, y))
                report["donut platform"] += 1
                continue
            if obj == "oCastlePlatMaker":
                # hit with an attack, a platform comes out of it and goes 200px its way (oMCastle_PlatB: 2px a tick for
                # 100 ticks, one every 3 seconds): a moving platform in the room's cpm state (all of them, once one's hit)
                r = run.instance(obj, x, y, code, W, H, area)
                ang = r.vars.get("image_angle", 0)
                way = {0: (1, 0), 90: (0, -1), 180: (-1, 0), 270: (0, 1)}.get(int(ang) % 360 if isinstance(ang, (int, float)) else -1)
                if r.destroyed == 1 or way is None: continue
                lines.append("SW\tsCastlePlatMaker\t%d\t%d\t1\t1\t0\tcpm\tattack\tonce" % (x, y))
                lines.append("U\tsCastlePlatform\t%d\t%d\t1\t1\t0\tcpm\t1\tline\t%d\t%d\t%d\t%d"
                             % (x, y, x, y, x + 200 * way[0], y + 200 * way[1]))
                report["platform maker"] += 1
                continue
            if obj == "oIceMickeyBlock":
                # an ice block: an elemental attack (Mega Man's Shotgun Ice, Belmont's Holy Water) grows a platform out of
                # its side for a while (oIceMickeyPlat: 32px wide at the block's middle height, for about 5 seconds). The
                # room's ice state has the platforms, once one block's hit (the logic doesn't tell them apart)
                r = run.instance(obj, x, y, code, W, H, area)
                side = r.vars.get("mySide")
                if r.destroyed == 1 or side not in (1, -1): continue
                lines.append("SW\tsIceMickeyBlock\t%d\t%d\t1\t1\t0\tice\tice\tonce" % (x, y))
                lines.append("T\tsIceMickeyPlat\t%d\t%d\t%d\t1\t0\tice\t1" % (x + 8 * side, y, side))
                report["ice block"] += 1
                continue
            if obj == "oTurnPlatform":
                # (its two bars, solids it makes: across it, or upright after a switch turns it)
                r = run.instance(obj, x, y, code, W, H, area)
                s = r.vars.get("image_xscale", 1)
                if not isinstance(s, (int, float)): s = 1
                flat = [(x - 32 * s, y - 48 * s, 4 * s, s), (x - 32 * s, y + 32 * s, 4 * s, s)]
                upright = [(x - 48 * s, y - 32 * s, s, 4 * s), (x + 32 * s, y - 32 * s, s, 4 * s)]
                first, second = (upright, flat) if r.vars.get("angleChange") == 90 else (flat, upright)
                for st, bars in ((0, first), (1, second)):
                    for bx, by, bxs, bys in bars:
                        lines.append("T\tsInvisibleSolidMask\t%s\t%s\t%s\t%s\t0\tpb\t%d" % (fnum(bx), fnum(by), fnum(bxs), fnum(bys), st))
                continue
            if obj == "oPlayerIdle":
                # the party split's idle partner: where it starts; put at newX,newY instead when the player comes in
                # past xThres (before it, with checkRev)
                if split:
                    m0 = re.search(r"xThres\s*=\s*(\d+)", code)
                    m1, m2 = re.search(r"newX\s*=\s*(\d+)", code), re.search(r"newY\s*=\s*(\d+)", code)
                    if m0 and m1 and m2:
                        lines.append("PI\t%d\t%d\t%s\t%s\t%s\t%d" % (x, y, m0.group(1), m1.group(1), m2.group(1), 1 if "checkRev" in code else 0))
                    else:
                        lines.append("PI\t%d\t%d" % (x, y))
                continue
            if obj == "oMetRipper":
                # a Ripper: it flies left and right along its row, turning at walls, and carries a Strike Chain point
                # (Mega Man's grapple latches on); RoomLogic.cs puts points along its way
                r = run.instance(obj, x, y, code, W, H, area)
                if r.destroyed != 1:
                    lines.append("KR\tsNull\t%d\t%d\t1\t1\t0" % (x, y))
                    report["Ripper (a moving Strike Chain point)"] += 1
                continue
            if obj == "oStoryObject" and (room, x, y) in STORY_POS:
                # one of the story's ability pickups (rndgen.STORY_SPOTS): gone in the endgame world (its creation code
                # takes it out once the story's past it), a Randomizer place (location type 19) where it was placed, as
                # it looked (its creation code's sprite)
                r = run.instance(obj, x, y, code, W, H, area)
                spr = r.vars.get("sprite_index")
                if not isinstance(spr, Res): spr = Res(rndgen.STORY_DEFAULT_SPRITE)
                n = STORY_POS[(room, x, y)]
                lines.append("L\t%s\t%d\t%d\t1\t1\t0\t%d\t%d\t0\t%s %d"
                             % (spr, x, y, rndgen.STORY_TYPE, n, rndgen.LT_LABEL[rndgen.STORY_TYPE].lower(), n))
                report["story pickup (a place)"] += 1
                continue
            kind = None
            if obj in MAP_EXITS: kind = "mapexit"
            elif obj in EXITS or obj in FIXED_EXITS: kind = "exit"
            elif obj == "oMapDoor": kind = "door"
            elif obj == "oMetEleExit": kind = "elevexit"
            elif obj == ELEVATOR: kind = "elevator"
            elif obj in LOCATIONS: kind = "loc"
            elif obj in SPRINGS: kind = "spring"
            elif obj in ("oStrikeChainPoint", "oStrikePoint_Ext"): kind = "chain"
            elif obj in HAZARDS: kind = "hazard"
            elif PLATFORMS in ch: kind = "platform"
            elif WATER in ch: kind = "water"
            elif "oSolid" in ch: kind = "solid"
            if kind is None or proj.gone_at_once(obj): continue
            r = run.instance(obj, x, y, code, W, H, area)
            v = r.vars
            if r.destroyed == 1:
                continue
            ix, iy = v.get("x"), v.get("y")
            xs, ys, ang = v.get("image_xscale"), v.get("image_yscale"), v.get("image_angle")
            msk = v.get("mask_index"); spr = v.get("sprite_index")
            shape = msk if isinstance(msk, Res) else spr
            if not all(isinstance(t, (int, float)) for t in (ix, iy, xs, ys, ang)) or not isinstance(shape, Res):
                report["unknown shape " + kind] += 1
                notes.append("%s %s (%d,%d): its place, size or sprite depends on something unknown" % (room, obj, x, y))
                if kind in ("solid",):
                    # (where it might be: as placed)
                    ix, iy, xs, ys, ang = x, y, 1, 1, 0
                    shape = Res(proj.mask.get(obj) or proj.sprite.get(obj) or "")
                    if not shape: continue
                else:
                    continue
            geo = "%s\t%s\t%s\t%s\t%s\t%s" % (shape, fnum(ix), fnum(iy), fnum(xs), fnum(ys), fnum(ang))
            if shape == "sNull": continue
            if kind == "mapexit":
                is_map = True
                tr, nx, ny = v.get("toRoom"), v.get("newMapX"), v.get("newMapY")
                if isinstance(tr, Res) and isinstance(nx, (int, float)) and isinstance(ny, (int, float)) and r.destroyed == 0:
                    lines.append("X\t%s\t%s\t%s\t%s\t1\t%s" % (geo, tr, fnum(nx), fnum(ny), obj))
                else:
                    report["map exit unknown"] += 1
                continue
            if kind == "exit":
                tr, nx, ny, et = v.get("toRoom"), v.get("newMapX"), v.get("newMapY"), v.get("exitType", 0)
                if obj in ("oAccessGate", "oDistortionGate"): et = 0
                if obj == "oMMBossDoor": et = 1
                if obj in FIXED_EXITS:
                    et, tr, nx, ny = FIXED_EXITS[obj]; tr = Res(tr)
                if r.destroyed == 2:
                    report["exit maybe there"] += 1
                    notes.append("%s %s (%d,%d) to %s: there or not depending on something unknown (left out)" % (room, obj, x, y, tr))
                    continue
                # an exit whose way goes by a Forest Palace crystal: where it leads in each of its states (a line each)
                m = re.search(r"global\.%s\[(\d)\]" % SEGMENTS, code)
                if m and obj == "oExit":
                    seg = int(m.group(1))
                    ways = []
                    for val in (0, 1):
                        w2 = dict(run.world); w2[SEGMENTS] = dict(w2.get(SEGMENTS) or {}); w2[SEGMENTS][seg] = val
                        v2 = run.instance(obj, x, y, code, W, H, area, world=w2).vars
                        tr2, nx2, ny2, et2 = v2.get("toRoom"), v2.get("newMapX"), v2.get("newMapY"), v2.get("exitType", 0)
                        if isinstance(tr2, Res) and isinstance(nx2, (int, float)) and isinstance(ny2, (int, float)) and et2 in (0, 1, 2):
                            ways.append("X\t%s\t%s\t%s\t%s\t%d\t%s\tcrystal%d\t%d" % (geo, tr2, fnum(nx2), fnum(ny2), et2, obj, seg + 1, val))
                    if len(ways) == 2:
                        lines += ways; crystals.add(seg + 1); report["exit turned by a crystal"] += 1
                    else:
                        report["exit unknown"] += 1
                        notes.append("%s %s (%d,%d): where it goes depends on something unknown (left out)" % (room, obj, x, y))
                    continue
                if isinstance(tr, Res) and isinstance(nx, (int, float)) and isinstance(ny, (int, float)) and et in (0, 1, 2):
                    lines.append("X\t%s\t%s\t%s\t%s\t%d\t%s" % (geo, tr, fnum(nx), fnum(ny), et, obj))
                    report["exit"] += 1
                else:
                    report["exit unknown"] += 1
                    notes.append("%s %s (%d,%d): where it goes depends on something unknown (left out)" % (room, obj, x, y))
                continue
            if kind == "elevexit":
                tr, nx, ny = v.get("toRoom"), v.get("newMapX"), v.get("newMapY")
                lines.append("S\t%s" % geo)
                if isinstance(tr, Res) and isinstance(nx, (int, float)) and isinstance(ny, (int, float)) and r.destroyed == 0:
                    lines.append("X\t%s\t%s\t%s\t%s\t3\t%s" % (geo, tr, fnum(nx), fnum(ny), obj))
                else:
                    report["exit unknown"] += 1
                continue
            if kind == "door":
                nx, ny, et = v.get("newX"), v.get("newY"), v.get("exitType", 0)
                if isinstance(nx, (int, float)) and isinstance(ny, (int, float)) and et in (0, 1, 2) and r.destroyed == 0:
                    lines.append("D\t%s\t%s\t%s\t%d" % (geo, fnum(nx), fnum(ny), et))
                else:
                    report["door unknown"] += 1
                continue
            if kind == "elevator":
                lines.append("V\t%s" % geo); continue
            if kind == "loc":
                t = LOCATIONS[obj]
                n = v.get("objectNum")
                if t in (15, 16, 17): n = 1
                if not isinstance(n, int): continue
                lines.append("L\t%s\t%d\t%d\t%d\t%s %d" % (geo, t, n, 1 if obj in FALLING_PICKUPS else 0, rndgen.LT_LABEL[t].lower(), n))
                continue
            if kind == "spring":
                lines.append("J\t%s\t%s" % (geo, SPRINGS[obj])); continue
            if kind == "chain":
                lines.append("K\t%s" % geo); continue
            if kind == "hazard":
                # (Gate 5's lava hurts in a Randomizer game till the Varia Suit's found, the mod's oMetLava; its purple
                # lava always does)
                if obj == "oMetLava" and v.get("image_blend") != gmleval.CONSTS["c_purple"]:
                    lines.append("HV\t%s\tvaria\t%s" % (geo, obj)); report["lava (harmless with the Varia Suit)"] += 1; continue
                lines.append("H\t%s" % geo); continue
            if kind == "platform":
                lines.append("P\t%s" % geo); continue
            if kind == "water":
                lines.append("W\t%s" % geo); continue
            # solids
            if r.destroyed == 2: report["solid maybe there"] += 1
            if obj in NOT_SOLID: continue
            # a barrier a switch opens: gone if its switch is on already, else shut till it's hit (the room's state b<GID>)
            # a timed switch's barrier (open for a while once the switch is hit): counted as needing what the timed
            # switches take between them, the Gravity Well, Link's bombs, Belmont's whip and dagger and the Spazer Beam
            if obj == "oTimeSwBarrier":
                lines.append("G\t%s\t%s\t%s" % (geo, TIMED_SWITCH, obj)); report["timed switch barrier"] += 1
                continue
            if obj in ("oSwitchBarrier", "oTimeSwBarrier"):
                if obj == "oSwitchBarrier":
                    g = v.get("switchCache")
                    ids = [int(g)] if isinstance(g, (int, float)) else []
                else:
                    ids = [int(n) for n in re.findall(r"switchCache\[\d+\]\s*=\s*(\d+)", code)]
                if len(ids) == 1 and ids[0] in holders:
                    if holders[ids[0]]["on"]:
                        report["switch barrier open"] += 1
                        continue
                    lines.append("T\t%s\tb%d\t0" % (geo, ids[0]))
                    switches_used.add(ids[0]); report["switch barrier"] += 1
                    continue
                # (several timed switches at once, or a switch not found: shut)
                lines.append("S\t%s" % geo); report["switch barrier shut"] += 1
                continue
            # the red and blue blocks (solid when the red/blue switches are on blue: red, else blue)
            if obj in ("oRedBlocker", "oRedMBlock"):
                lines.append("T\t%s\trb\t1" % geo); continue
            if obj in ("oBlueBlocker", "oBlueMBlock"):
                lines.append("T\t%s\trb\t0" % geo); continue
            if obj == "oMarioRBblock":
                lines.append("S\t%s" % geo); lines.append("SW\t%s\trb\tbump" % geo); continue
            # a fading platform (or wall): there for timeTillOff ticks, gone for timeTillOn, over and over (a second or
            # so each): somewhere to stand, and somewhere to go through, waiting for it: a jump-through platform
            if obj == "oPlatTempFade":
                lines.append("P\t%s" % geo); report["fading platform"] += 1; continue
            # a block a switch slides 64px (and back); it carries a player standing on it (ride: the pair of lines is one
            # block, in each state)
            if obj == "oPlatformBlock":
                xsp, ysp = v.get("xSpd"), v.get("ySpd")
                if isinstance(xsp, (int, float)) and isinstance(ysp, (int, float)):
                    ex = ix + (64 if xsp > 0 else -64 if xsp < 0 else 0)
                    ey = iy + (64 if ysp > 0 else -64 if ysp < 0 else 0)
                    lines.append("T\t%s\tpb\t0\tride" % geo)
                    lines.append("T\t%s\t%s\t%s\t%s\t%s\t%s\tpb\t1\tride" % (shape, fnum(ex), fnum(ey), fnum(xs), fnum(ys), fnum(ang)))
                    continue
            gm = re.search(r"GID_SET\(\s*(\d+)", code)
            if gm and int(gm.group(1)) in door_of:
                lines.append("G\t%s\tevent:%s/%s\t%s" % (geo, room, door_of[int(gm.group(1))], obj)); report["colored barrier"] += 1
                continue
            if obj == "oEventBarrier" and event_from_code(code):
                lines.append("G\t%s\t%s\t%s" % (geo, event_from_code(code), obj)); report["gate waiting for an event"] += 1
                continue
            if obj in GATES:
                req = GATES[obj](v)
                if req == "open": continue
                if req is None:
                    lines.append("S\t%s" % geo); report["gate shut: " + obj] += 1
                    notes.append("%s %s (%d,%d): a gate whose opening isn't known: solid" % (room, obj, x, y))
                else:
                    lines.append("G\t%s\t%s\t%s" % (geo, req, obj)); report["gate " + obj] += 1
                continue
            # a floating platform: it floats up to the water's top, or falls to what's under it (RoomLogic.cs, at each
            # water level)
            if obj == "oWaterFloatPlatform":
                lines.append("FP\t%s" % geo); report["floating platform"] += 1; continue
            # a rock the player pushes (oMoveableSolid: walked into, it slides; with nothing under it, it falls):
            # RoomLogic.cs works out where it can be pushed to, and makes its top somewhere to stand there
            if obj == "oPushRock":
                lines.append("PR\t%s" % geo); report["push rock"] += 1; continue
            if "oMovingSolid" in ch or "oMoveableSolid" in ch:
                if obj not in STATIC_MOVING:
                    path = mover_path(obj, v, W, H)
                    if path is None:
                        lines.append("M\t%s\t%d\t%d" % (obj, x, y)); report["moving left out: " + obj] += 1
                        continue
                    if path[0] != "static":
                        lines.append("N\t%s\t%s\t%s" % (geo, path[0], "\t".join(fnum(round(t, 2)) for t in path[1:])))
                        report["moving platform ridden"] += 1
                        continue
            lines.append("S\t%s" % geo)
        # the enemy traps the Randomizer brings back (..\traps.py): their barriers, walls that open with what beats the
        # trap's enemies (beaten once, it's gone; the logic never takes the player into one they can't win)
        for spr, bx, by, bxs, bys, bang, req in trap_gates.get(room, []):
            lines.append("G\t%s\t%s\t%s\t%s\t%s\t%s\t%s\toRndTrap" % (spr, fnum(bx), fnum(by), fnum(bxs), fnum(bys), fnum(bang), req))
            report["enemy trap barrier"] += 1
        # the Trial Master's 7th trial's heart container: the room's code makes it only in Nightmare mode, the mod in every
        # Randomizer game once the trial's done (rndHC7), where the code puts it
        m = re.search(r"instance_create\(\s*(\d+)\s*,\s*(\d+)\s*,\s*oHeartContainer\s*\)\s*\n\s*\w+\.objectNum\s*=\s*%d\b" % rndgen.TRIAL_HC,
                      read(rc) if os.path.exists(rc) else "")
        if m:
            lines.append("L\tsHeartContainer\t%s\t%s\t1\t1\t0\t14\t%d\t0\theart container %d" % (m.group(1), m.group(2), rndgen.TRIAL_HC, rndgen.TRIAL_HC))
            report["trial heart container"] += 1
        # the switches the barriers wait for (hit once: open for good, for this visit)
        for g in sorted(switches_used):
            h = holders[g]
            lines.append("SW\t%s\t%d\t%d\t1\t1\t0\tb%d\tattack\tonce" % (h["spr"], h["x"], h["y"], g))
        if has_rb:
            lines.append("CG\trb")
            if rb_reset is not None: lines.append("RS\trb\t%d" % rb_reset)
            # (an enemy's shots or a moving trap near a red/blue switch hit it by themselves, again and again: a Sparky's
            # sparks, a platform follower going round its platform, a zap trap, a chain ball)
            switches = [(x, y) for obj, x, y, code in todo if obj == "oRBswitch"]
            if any(obj in SWITCH_HITTERS and any(abs(x - sx) <= 160 and abs(y - sy) <= 160 for sx, sy in switches)
                   for obj, x, y, code in todo):
                lines.append("RBAUTO"); report["red/blue switches hit by traps or enemies"] += 1
        elif rb_reset is not None:
            lines.append("RG\trb\t%d" % rb_reset)
        if water_carried: lines.append("CG\twater")
        for n in sorted(crystals): lines.append("CG\tcrystal%d" % n)
        # (a menu's ways out: the room is a map, every one of them from wherever the player comes in)
        for tr, nx, ny in menu_exits(room, world):
            lines.append("X\tsExit\t0\t0\t1\t1\t0\t%s\t%d\t%d\t1\tmenu" % (tr, nx, ny))
            is_map = True
        # (a map walked as an icon: its exits are reached where the walk gets to them; its encounters anywhere)
        if any(obj == WALK_ICON for obj, x, y, code in todo):
            for tr, nx, ny in ENCOUNTERS:
                lines.append("X\tsExit\t0\t0\t1\t1\t0\t%s\t%d\t%d\t1\tencounter" % (tr, nx, ny))
            lines.append("QW")
        elif is_map: lines.append("Q")
    with open(out_path, "w", encoding="utf-8", newline="\n") as f:
        f.write("START\t%s\t%d\t%d\n" % START)
        # (the carried states as a new game starts: the red/blue switches off; the water and the Forest Palace's
        # crystals where the world has them)
        f.write("CARRY\trb\t0\nCARRY\twater\t%d\n" % {wy: l for l, wy in WATER_LEVELS.items()}.get(world.get("wpWaterLevel"), 2))
        # (the crystals only matter in the Forest Palace: kept within its rooms, CARRY's scope, a room name prefix)
        segs = world.get(SEGMENTS) if isinstance(world.get(SEGMENTS), dict) else {}
        for n in sorted(set(CRYSTALS.values())):
            f.write("CARRY\tcrystal%d\t%d\t%s\n" % (n, 1 if segs.get(n - 1) == 1 else 0, CRYSTAL_SCOPE))
        for t, (a, b) in sorted(rndgen.BOSS_VIA.items()):
            f.write("BV\t%s\t%s\n" % (a, b))
        f.write("\n".join(lines) + "\n")
    with open(os.path.splitext(out_path)[0] + "_notes.txt", "w", encoding="utf-8", newline="\n") as f:
        f.write("\n".join(notes) + "\n")
    for k, n in sorted(report.items()): print("%6d %s" % (n, k))
    print("written", out_path)


def boss_starts():
    """{room: (x, y)}: where the Randomizer's boss fights start (rndgen's boss list)"""
    out = {}
    for obj, x, y, hexid, code in rndgen.instances("rBossGallery"):
        if obj != "oBossGalleryDoor": continue
        t = rndgen.num(code, "type"); tr = re.search(r"toRoom\s*=\s*(\w+)", code)
        if t is None or not tr or t in rndgen.BOSS_SKIP: continue
        room = tr.group(1)
        if room.startswith("rExtGate") or room in out: continue
        rc = os.path.join(ROOMS, room, "code.gml")
        if not os.path.exists(rc): continue
        txt = read(rc)
        if not re.search(r"bossTrack\s*=\s*1", txt): continue
        m = re.search(r"if global\.bossTrack\s*(>=|=)\s*1", txt)
        pp = re.search(r"oPlayer1\.x\s*=\s*(-?\d+)\s*;?\s*oPlayer1\.y\s*=\s*(-?\d+)", txt[m.end():m.end() + 1500]) if m else None
        out[room] = (int(pp.group(1)), int(pp.group(2))) if pp else ((rndgen.num(code, "newMapX") or 0), (rndgen.num(code, "newMapY") or 0))
    return out


if __name__ == "__main__":
    main()
