"""
Builds the DT3+ Randomizer mod from the project: every collectible location in the game's rooms, the item pool, the
logic estimate for each location and the endgame world state, written as the mod's data scripts, with the hand-written
mod files in mod\\.

usage: python rndgen.py <output folder>
       python rndgen.py --world-from <save.dts>      (re-reads world.txt's values from a finished save)

Inputs next to this file:
  mod\\        the mod's own code (mod.ini, hooks, scripts, objects), copied to the output as is
  world.txt   the endgame world state: save file keys (loadSaveData) and their values, from a 100% save
  logic.txt   changes to the logic estimate (see README.txt)
Outputs:
  <output>\\scripts\\rndData.gml    locations, items and shops
  <output>\\scripts\\rndWorld.gml   the world state
  locations.csv (next to this file) every location with its logic, for checking and for logic.txt
"""
import os, re, sys, csv, shutil, collections

HERE = os.path.dirname(os.path.abspath(__file__))
PROJ = os.path.normpath(os.path.join(HERE, "..", "..", ".."))
ROOMS = os.path.join(PROJ, "rooms")

# location types: (code, object, label). Their vanilla item is worked out per location (chests: money or equipment)
LTYPES = [
    (1, "oHeartPiece", "Heart Piece"), (2, "oMoneyChest", "Treasure Chest"), (3, "oArrowQuiver", "Arrow Quiver"),
    (4, "oHeartEnergy", "Heart Energy"), (5, "oMissilePack", "Missile Tank"), (6, "oGamePower", "Game Power"),
    (7, "oAirUpgrade", "Air Upgrade"), (8, "oWalletBoost", "Internetz Mod"), (9, "oWeaponLevelUpgrade", "Weapon Upgrade"),
    (10, "oAPBoost", "Skill Point"), (11, "oLinkBombUpgrade", "Bomb Upgrade"), (12, "oMorphBombUpgrade", "Morph Bomb Upgrade"),
    (13, "oDoorKey", "Key"), (14, "oHeartContainer", "Heart Container"), (15, "oItemFinderPickup", "Item Finder"),
    (16, "oMMBoostedCharge", "X Charge Capsule"), (17, "oMetPick_SpringBall", "Spring Ball"), (18, "oRndStartItem", "Starting Item")]
LT_BY_OBJ = {o: c for c, o, l in LTYPES}
LT_LABEL = {c: l for c, o, l in LTYPES}

# item kinds (the numbers the mod's scripts use)
IK = dict(HP=1, MONEY=2, EQUIP=3, AQ=4, HE=5, MP=6, GP=7, AU=8, WB=9, WL=10, AP=11, LB=12, MB=13, KEY=14, HC=15, XF=16,
          XC=17, XS=18, JUMP=19, GDASH=20, ADASH=21, DJUMP=22, HIJUMP=23, SET=24)
LT_ITEM = {1: "HP", 3: "AQ", 4: "HE", 5: "MP", 6: "GP", 7: "AU", 8: "WB", 10: "AP", 11: "LB", 12: "MB", 13: "KEY",
           14: "HC", 15: "XF", 16: "XC", 17: "XS"}

# progression: the items the logic counts, in the order of the requirement strings (one digit each, keys two). mario: the
# Mario Ability Set (hasAbilToken[0]: jumping on Mario enemies, hitting blocks from below)
PROG = ["jump", "gdash", "adash", "djump", "hijump", "mario", "link", "belmont", "megaman", "samus", "gamej", "gamec", "keys"]
# how many of each there are. The ability sets' items are progressive: each one is the set's next level (hasAbilToken 2,
# 3...): Link and Belmont 3 (their three weapons; nothing uses a level 5), Mega Man 4 (the grapple at 5), Samus 7 (Arm
# Cannon, Morph Ball, Charge Beam, Missiles, Spazer Beam, Bombs, Diffusion Missile), the Gate 6 sets 2
PMAX = [1, 1, 1, 1, 2, 1, 3, 3, 4, 7, 2, 2, 17]
# the abilities that aren't at any location in an endgame world (the story gave them): added to the pool
EXTRA = [("JUMP", 0), ("GDASH", 0), ("ADASH", 0), ("DJUMP", 0), ("HIJUMP", 0), ("HIJUMP", 0)] + \
        [("SET", s) for s, n in enumerate(PMAX[5:12]) for _ in range(n)]

# what the story has given by the time it first reaches an area (the area numbers locationCheck uses are in story
# order): the logic estimate. Each stage has everything the ones before it have
STAGE_ADD = {1: {"jump": 1}, 2: {"mario": 1}, 3: {"link": 3}, 4: {"gdash": 1, "belmont": 3}, 5: {"megaman": 4},
             6: {"adash": 1}, 7: {"samus": 7, "hijump": 2}, 8: {"djump": 1, "gamej": 2, "gamec": 2}, 9: {}}
# places whose pickup only shows once something optional is done (their creation code checks the global): the stage of
# the logic they need. Tower defense (rCCity_NorthA's rewards for its offenses) opens late in the story (gameProgress
# 3900), and its fights are the player's own
COND_STAGE = {"gameOptTowerDef": 8}
# places a Trial Master trial gives (the pickup's creation code hides it till the trial's done; Central City South's
# heart container, made by the room, comes with the 7th): no ability or key there, since the trials need the three
# cursed equipment pieces on (equipment 10-12, shuffled as other items), and those don't go there either (rndGenerate)
COND_TRIAL = "trialMasterQuest"
TRIAL_HC = 7


# the pickups whose events get the randomizer's part ahead of the game's own (their location type), and what that part is
SIMPLE_PICKUPS = {"oHeartPiece": 1, "oArrowQuiver": 3, "oHeartEnergy": 4, "oMissilePack": 5, "oGamePower": 6,
                  "oAirUpgrade": 7, "oWalletBoost": 8, "oWeaponLevelUpgrade": 9, "oAPBoost": 10,
                  "oLinkBombUpgrade": 11, "oMorphBombUpgrade": 12, "oHeartContainer": 14, "oDoorKey": 13}
ALARM_PREFIX = ("//Randomizer: in a randomizer game this is a location: it shows its item (rndPickupSetup), or goes if that's\n"
                "//been taken. Otherwise as the game's own\n"
                "if global.rndActive=1\n{\n  rndPickupSetup(%d)\n%s  exit\n}\n")
ALARM_EXTRA = {"oHeartContainer": "  if rndLoc>=0 {if !rndHCOpen(objectNum) {instance_destroy()}} //its boss beaten first\n",
               "oDoorKey": "  indexCheck=\"0\"\n"}
COLL_PREFIX = ("//Randomizer: in a randomizer game, the location's item. Otherwise as the game's own\n"
               "if global.rndActive=1\n{\n  if variable_local_exists(\"rndLoc\") {if rndLoc>=0 {rndCollect(rndLoc);%s instance_destroy()}}\n"
               "  exit\n}\n")
COLL_EXTRA = {"oDoorKey": " indexCheck=\"1\";"}
# other events of the game's objects the mod has its own copy of: the game's own (read when the mod's built), with one
# line changed (the original kept commented above it). The randomizer's boss fights have the boss gallery's flag on (so a
# beaten boss goes to the gallery, where rndBossEnd takes over) without its timer
GAME_PATCHES = [
    ("oHUD", "Draw_0",
     "    if global.bBossGallery=1 and room!=rBossGallery //Display timer in boss gallery\n",
     "    //if global.bBossGallery=1 and room!=rBossGallery //Display timer in boss gallery\n"
     "    if global.bBossGallery=1 and room!=rBossGallery and global.rndFight<0 //Randomizer change: not in a randomizer boss fight\n"),
]

# bosses: the boss gallery's doors give each boss's type (oBossGalleryDoor's user event 0 sets its fight up), room and
# where the player starts it. One boss a room (its first type: Death, Sigma, Ridley and Decimator have a second). Left to
# the game: the Nightmare Gates' bosses (their instruments: rooms rExtGate*), the Abomination (type 58, the instrument
# quest's), the Warmaster EX room (type 65: the game's own Fedex fight), the Ridley tunnel chase (37) and the Leviathan
# road (41), which aren't fights a room makes
BOSS_SKIP = {37, 41, 58, 65}
BOSS_FINAL = 60          # the Warmaster: the win (his door is in the first room)
HC_BOSS = {1: 2, 2: 8, 3: 14, 4: 24, 5: 35, 6: 46}  # heart container (objectNum): the boss type after whose fight the game gives it
# bosses whose rooms the story's exit no longer goes to in an endgame world (it goes on past them): going through that
# exit (from, to) is the way into the fight, and the player goes on to where it leads after it
BOSS_VIA = {35: ("rSamus5_Lv4_N", "rSamus5_Lv4_RidleyTunnel"), 61: ("rPttT_06", "rPttT_08")}


def vanilla_event(obj, ev):
    """the game's own code for an object's event (objects/<obj>.gml), without the action header"""
    t = read(os.path.join(PROJ, "objects", obj + ".gml"))
    parts = re.split(r"^#define (\w+)\s*$", t, flags=re.M)
    for i in range(1, len(parts), 2):
        if parts[i] == ev:
            body = parts[i + 1]
            body = re.sub(r"^\s*/\*\"/\*'/\*\*//\* YYD ACTION.*?\*/\s*?\n", "", body, count=1, flags=re.S)
            return body.strip("\n") + "\n"
    raise SystemExit("%s has no %s event" % (obj, ev))


def object_sprite(obj):
    """an object's sprite (objects\\<obj>.txt), or None"""
    p = os.path.join(PROJ, "objects", obj + ".txt")
    if not os.path.exists(p): return None
    m = re.search(r"^sprite=(\w+)", read(p), re.M)
    return m.group(1) if m else None


def sprite_bounds(name):
    """each frame's opaque pixels, from the sprite's origin: [(left, top, right, bottom)], None for a frame with none"""
    sys.path.insert(0, os.path.dirname(HERE))
    import png
    d = os.path.join(PROJ, "sprites", name)
    info = dict(l.strip().split("=", 1) for l in open(os.path.join(d, "sprite.txt"), encoding="utf-8") if "=" in l)
    ox, oy = int(info.get("origin_x", 0)), int(info.get("origin_y", 0))
    res = []
    for i in range(int(info.get("frames", 1))):
        w, h, rows = png.read(os.path.join(d, "%d.png" % i))
        l = t = 1 << 30; r = b = -1
        for y, row in enumerate(rows):
            for x in range(w):
                if row[x * 4 + 3]:
                    if x < l: l = x
                    if x > r: r = x
                    if y < t: t = y
                    b = y
        res.append((l - ox, t - oy, r - ox, b - oy) if r >= 0 else None)
    return res


def area_stage(a):
    if a is None: return 9
    for top, st in ((1, 1), (6, 1), (9, 2), (14, 3), (28, 4), (29, 5), (41, 6), (50, 7), (59, 8)):
        if a <= top: return st
    return 9


def stage_req(st):
    r = dict.fromkeys(PROG, 0)
    for s in range(1, st + 1):
        r.update(STAGE_ADD.get(s, {}))
    return r


def read(p):
    return open(p, encoding="utf-8", errors="replace").read()


def room_names():
    return [l.strip() for l in open(os.path.join(ROOMS, "index.yyd"), encoding="utf-8") if l.strip()]


def area_names():
    t = read(os.path.join(PROJ, "scripts", "locationCheck.gml"))
    parts = re.split(r"global\.location=(\d+)", t)
    names = {}
    for i in range(1, len(parts), 2):
        m = re.search(r'tNewLoc="([^"]*)"', parts[i + 1])
        if m and int(parts[i]) not in names: names[int(parts[i])] = m.group(1)
    return names


def room_area(room):
    p = os.path.join(ROOMS, room, "code.gml")
    if not os.path.exists(p): return None
    m = re.search(r"locationCheck\((\d+)\)", read(p))
    return int(m.group(1)) if m else None


def room_areas(rooms):
    """each room's area. A room without its own locationCheck is in the area the game last set, its room group's
    (rMario1_1 sets Gate 1's for the rMario1 rooms after it): the group's latest in story order, to be safe"""
    own = {r: room_area(r) for r in rooms}
    group = collections.defaultdict(list)
    for r, a in own.items():
        if a is not None: group[r.split("_")[0]].append(a)
    return {r: a if a is not None else max(group[r.split("_")[0]] or [None]) for r, a in own.items()}


def instances(room):
    p = os.path.join(ROOMS, room, "instances.txt")
    if not os.path.exists(p): return
    for line in open(p, encoding="utf-8", errors="replace"):
        f = line.strip().split(",")
        if len(f) < 4: continue
        cp = os.path.join(ROOMS, room, f[3] + ".gml")
        yield f[0], int(float(f[1])), int(float(f[2])), f[3], (read(cp) if os.path.exists(cp) else "")


def num(code, var):
    m = re.search(r"\b%s\s*=\s*(-?\d+)" % var, code)
    return int(m.group(1)) if m else None


def gml_str(s):
    return '"' + s.replace('"', "'") + '"'


def main():
    if len(sys.argv) >= 3 and sys.argv[1] == "--world-from":
        return world_from(sys.argv[2])
    if len(sys.argv) < 2: raise SystemExit(__doc__)
    out = sys.argv[1]
    rooms = room_names()
    anames = area_names()
    rarea = room_areas(rooms)

    # ---- locations: (type, objectNum) -> rooms, vanilla item
    locs = collections.OrderedDict()
    doors = collections.defaultdict(set)
    shops = collections.OrderedDict()
    for room in rooms:
        for obj, x, y, hexid, code in instances(room) or []:
            if obj == "oLockedDoor":
                doors[num(code, "objectNum")].add(room)
            elif obj == "oNPC_Shop" and re.search(r"shopType\s*=\s*oShopWindow", code):
                # a shop: the room editor's id (a room's copies share it); the game finds it by its room and the place
                # it starts at (its instance id isn't the editor's)
                sid = int(hexid, 16)
                inv = [num(code, r"inv\[%d\]" % i) or 0 for i in range(5)]
                mx = num(code, "maxInv") or 5
                s = shops.setdefault(sid, {"rooms": [], "at": [], "inv": [v for v in inv[:mx]]})
                s["rooms"].append(room)
                s["at"].append((room, x, y))
            elif obj in LT_BY_OBJ:
                t = LT_BY_OBJ[obj]
                n = num(code, "objectNum")
                if t in (15, 16, 17): n = 1
                if n is None: continue
                l = locs.setdefault((t, n), {"rooms": [], "item": None})
                l["rooms"].append(room)
                for g, st in COND_STAGE.items():
                    if re.search(r"global\.%s\b" % g, code): l["cond"] = max(l.get("cond", 0), st)
                if re.search(r"global\.%s\b" % COND_TRIAL, code): l["trial"] = 1
                if t == 2:
                    amt = num(code, "objectAmt") or 0
                    l["item"] = ("EQUIP", amt) if num(code, "newItem") == 1 else ("MONEY", amt)
                elif t == 9:
                    l["item"] = ("WL", num(code, "image_index") or 0)
                else:
                    l["item"] = (LT_ITEM[t], 0)
        # heart containers: made by the boss rooms' own code once the boss is beaten
        cp = os.path.join(ROOMS, room, "code.gml")
        if os.path.exists(cp):
            for m in re.finditer(r"instance_create\([^)]*oHeartContainer\)\s*\n\s*\w+\.objectNum=(\d+)", read(cp)):
                l = locs.setdefault((14, int(m.group(1))), {"rooms": [], "item": ("HC", 0)})
                if room not in l["rooms"]: l["rooms"].append(room)
    for n in (1, 2, 3):  # the starting items, dropped where a new game starts (see roomStart)
        locs[(18, n)] = {"rooms": ["rMain_1"], "item": None}

    # ---- logic: the stage of each location's area (the most demanding of its rooms), and keys. Each key opens its own
    # door (the mod's oLockedDoor: a key that opened any door could be used up on the wrong one, in a world that's all
    # open), and the doors are in story order (their areas'): a location needs the keys of every locked door in an area
    # up to its own (one may be in the way); "keys N" is the first N doors' keys
    door_list = sorted((min((rarea.get(r) or 999) for r in rs), d) for d, rs in doors.items() if d is not None)
    door_order = [d for a, d in door_list]
    door_area = [a for a, d in door_list]
    door_rank = {d: i for i, d in enumerate(door_order)}
    def keys_for(a):
        if a is None: return len(door_order)
        return sum(1 for da in door_area if da <= a)
    overrides, room_over = read_logic()
    rows = []
    for (t, n), l in locs.items():
        areas = [rarea.get(r) for r in l["rooms"]]
        if t == 18:
            req, a = stage_req(0), 1
        else:
            st = max([area_stage(a) for a in areas] + [l.get("cond", 0)])
            a = max((x for x in areas if x is not None), default=None) if None not in areas else None
            req = stage_req(st)
            req["keys"] = max(keys_for(x) for x in areas)
            if t == 14 and n == TRIAL_HC: l["trial"] = 1
            if (t == 14 and n in HC_BOSS) or l.get("trial"):
                # a heart container a boss's fight gives, or a trial's reward: no ability or key there (asking for
                # everything keeps them out), so a fight that can't be won yet never holds the game back
                req = stage_req(9)
                req["keys"] = len(door_order)
        for r in l["rooms"]:
            if r in room_over: req = merge_req(req, room_over[r])
        if (t, n) in overrides: req = merge_req(req, overrides[(t, n)])
        rows.append({"type": t, "num": n, "rooms": l["rooms"], "area": a, "req": req, "item": l["item"], "trial": l.get("trial", 0)})

    # ---- items: what the locations hold, the abilities, less as many money chests as needed (the smallest)
    items = [r["item"] for r in rows if r["item"] is not None] + list(EXTRA)
    extra = len(items) - len(rows)
    money = sorted((i for i, it in enumerate(items) if it[0] == "MONEY"), key=lambda i: items[i][1])
    drop = set(money[:extra])
    items = [it for i, it in enumerate(items) if i not in drop]
    assert len(items) == len(rows), (len(items), len(rows))
    # each key is one door's (its parameter: the door's objectNum)
    keys = [i for i, it in enumerate(items) if it[0] == "KEY"]
    if len(keys) != len(door_order) or len(keys) != PMAX[-1]:
        raise SystemExit("%d keys, %d locked doors (PMAX says %d): each key opens its own door" % (len(keys), len(door_order), PMAX[-1]))
    for i, d in zip(keys, door_order): items[i] = ("KEY", d)

    # ---- bosses (rBossGallery's doors)
    bosses = []
    seen_rooms = set()
    for obj, x, y, hexid, code in instances("rBossGallery"):
        if obj != "oBossGalleryDoor": continue
        t = num(code, "type"); tr = re.search(r"toRoom\s*=\s*(\w+)", code)
        if t is None or not tr: continue
        bosses.append((t, tr.group(1), num(code, "newMapX") or 0, num(code, "newMapY") or 0,
                       (re.search(r'bossName="([^"]*)"', code) or [None, "?"])[1]))
    bosses.sort()
    blist = []
    for t, room, bx, by, name in bosses:
        if t in BOSS_SKIP or room.startswith("rExtGate") or room in seen_rooms: continue
        rc = os.path.join(ROOMS, room, "code.gml")
        if not os.path.exists(rc) or not re.search(r"bossTrack\s*=\s*1", read(rc)): continue
        seen_rooms.add(room)
        blist.append((t, room, bx, by, name))
    bidx = {t: i for i, (t, room, bx, by, name) in enumerate(blist)}
    if BOSS_FINAL not in bidx: raise SystemExit("the final boss (type %d) isn't in the boss list" % BOSS_FINAL)
    # where each fight starts (the room code's bossTrack part puts the player there; else the gallery's place): the
    # player walking up to it starts the fight. One outside the room (the room code moves the player in its own way)
    # starts as the room is come into
    bstart = []
    for t, room, bx, by, name in blist:
        rc = read(os.path.join(ROOMS, room, "code.gml"))
        m = re.search(r"if global\.bossTrack\s*(>=|=)\s*1", rc)
        pp = re.search(r"oPlayer1\.x\s*=\s*(-?\d+)\s*;?\s*oPlayer1\.y\s*=\s*(-?\d+)", rc[m.end():m.end() + 1500]) if m else None
        fx, fy = (int(pp.group(1)), int(pp.group(2))) if pp else (bx, by)
        rw = int(re.search(r"^width=(\d+)", read(os.path.join(ROOMS, room, "room.txt")), re.M).group(1))
        rh = int(re.search(r"^height=(\d+)", read(os.path.join(ROOMS, room, "room.txt")), re.M).group(1))
        bstart.append((fx, fy, 0 if 0 <= fx < rw and 0 <= fy <= rh else 1))
    for t, via in BOSS_VIA.items():
        if t not in bidx or any(r not in rooms for r in via): raise SystemExit("BOSS_VIA: boss %d or a room of %s isn't there" % (t, via))

    # ---- write
    os.makedirs(out, exist_ok=True)
    src = os.path.join(HERE, "mod")
    for root, ds, fs in os.walk(src):
        for f in fs:
            rel = os.path.relpath(os.path.join(root, f), src)
            dst = os.path.join(out, rel)
            os.makedirs(os.path.dirname(dst), exist_ok=True)
            shutil.copyfile(os.path.join(root, f), dst)
    # the pickups' events: the randomizer's part, then the game's own (so they follow the project's code)
    for obj, lt in SIMPLE_PICKUPS.items():
        d = os.path.join(out, "objects", obj)
        os.makedirs(d, exist_ok=True)
        with open(os.path.join(d, "object.ini"), "w", encoding="utf-8", newline="\n") as f:
            f.write("[object]\nevents=replace\n")
        with open(os.path.join(d, "Alarm_0.gml"), "w", encoding="utf-8", newline="\n") as f:
            f.write(ALARM_PREFIX % (lt, ALARM_EXTRA.get(obj, "")) + vanilla_event(obj, "Alarm_0"))
        with open(os.path.join(d, "Collision_oPlayer1.gml"), "w", encoding="utf-8", newline="\n") as f:
            f.write(COLL_PREFIX % COLL_EXTRA.get(obj, "") + vanilla_event(obj, "Collision_oPlayer1"))
    for obj, ev, old, new in GAME_PATCHES:
        code = vanilla_event(obj, ev)
        if code.count(old) != 1: raise SystemExit("%s %s: the line GAME_PATCHES changes isn't there once (the game's code changed)" % (obj, ev))
        d = os.path.join(out, "objects", obj)
        os.makedirs(d, exist_ok=True)
        with open(os.path.join(d, "object.ini"), "w", encoding="utf-8", newline="\n") as f:
            f.write("[object]\nevents=replace\n")
        with open(os.path.join(d, ev + ".gml"), "w", encoding="utf-8", newline="\n") as f:
            f.write("//(the game's own %s %s, with the Randomizer's change: rndgen.py GAME_PATCHES)\n" % (obj, ev) + code.replace(old, new))
    # <event>.prefix.gml (mod\objects): the randomizer's part of one of the game's events, the game's own after it
    for root, ds, fs in os.walk(os.path.join(out, "objects")):
        for f in fs:
            if f.endswith(".prefix.gml"):
                obj, ev = os.path.basename(root), f[:-len(".prefix.gml")]
                with open(os.path.join(root, ev + ".gml"), "w", encoding="utf-8", newline="\n") as g:
                    g.write(read(os.path.join(root, f)).rstrip("\n") + "\n" + vanilla_event(obj, ev))
                os.remove(os.path.join(root, f))
    L = ["//Randomizer data: every location, the items and the equipment shops, made by tools/modkit/randomizer/rndgen.py",
         "//from the game's rooms (don't change it here: change rndgen.py or logic.txt and build again)",
         "var i,t;",
         "for(t=0;t<=18;t+=1) {for(i=0;i<=130;i+=1) {global.rndLocOf[t,i]=-1}}",
         "global.rndLocN=%d" % len(rows)]
    for i, r in enumerate(rows):
        a = r["area"]
        where = "%s (%s)" % (anames.get(a, "?"), r["rooms"][0]) if a else r["rooms"][0]
        L.append("global.rndLocType[%d]=%d; global.rndLocNum[%d]=%d; global.rndLocOf[%d,%d]=%d; global.rndLocReq[%d]=%s; "
                 "global.rndLocName[%d]=%s; global.rndLocTrial[%d]=%d"
                 % (i, r["type"], i, r["num"], r["type"], r["num"], i, i, gml_str(req_str(r["req"])),
                    i, gml_str("%s: %s %d" % (where, LT_LABEL[r["type"]], r["num"])), i, r["trial"]))
    L.append("global.rndItemN=%d" % len(items))
    for i, (k, p) in enumerate(items):
        L.append("global.rndItemKind[%d]=%d; global.rndItemParam[%d]=%d" % (i, IK[k], i, p))
    L.append("global.rndEShopN=0")
    k = 0
    for sid, s in shops.items():
        for slot, eq in enumerate(s["inv"]):
            if not eq: continue
            L.append("global.rndEShopNpc[%d]=%d; global.rndEShopSlot[%d]=%d; global.rndEShopEquip[%d]=%d; global.rndEShopRoom[%d]=%s"
                     % (k, sid, k, slot, k, eq, k, gml_str(s["rooms"][0])))
            k += 1
    L.append("global.rndEShopN=%d" % k)
    # where each shop's shopkeeper is (rndShopEquip finds the shop by its room and starting place)
    j = 0
    for sid, s in shops.items():
        for room, x, y in s["at"]:
            L.append("global.rndEShopAtRoom[%d]=%s; global.rndEShopAtX[%d]=%d; global.rndEShopAtY[%d]=%d; global.rndEShopAtNpc[%d]=%d"
                     % (j, room, j, x, j, y, j, sid))
            j += 1
    L.append("global.rndEShopAtN=%d" % j)
    L.append("global.rndBossN=%d" % len(blist))
    for i, (t, room, bx, by, name) in enumerate(blist):
        L.append("global.rndBossType[%d]=%d; global.rndBossRoom[%d]=%s; global.rndBossX[%d]=%d; global.rndBossY[%d]=%d; "
                 "global.rndBossName[%d]=%s" % (i, t, i, room, i, bx, i, by, i, gml_str(name)))
        vf, vt = BOSS_VIA.get(t, ("-1", "-1"))
        L.append("global.rndBossViaFrom[%d]=%s; global.rndBossViaTo[%d]=%s" % (i, vf, i, vt))
        fx, fy, fe = bstart[i]
        L.append("global.rndBossFX[%d]=%d; global.rndBossFY[%d]=%d; global.rndBossOnEntry[%d]=%d" % (i, fx, i, fy, i, fe))
    L.append("global.rndBossFinal=%d" % bidx[BOSS_FINAL])
    for n in range(8):
        L.append("global.rndHCBoss[%d]=%d" % (n, bidx.get(HC_BOSS.get(n, -1), -1)))
    # the locked doors (by objectNum): their order (the logic's) and where they are
    L.append("for(i=0;i<=50;i+=1) {global.rndDoorRank[i]=-1; global.rndDoorArea[i]=%s; global.rndDoorPlace[i]=%s}"
             % (gml_str("?"), gml_str("?")))
    L.append("global.rndDoorN=%d" % len(door_order))
    for i, d in enumerate(door_order):
        rs = sorted(doors[d])
        an = anames.get(rarea.get(rs[0]), "?")
        L.append("global.rndDoorRank[%d]=%d; global.rndDoorArea[%d]=%s; global.rndDoorPlace[%d]=%s"
                 % (d, i, d, gml_str(an), d, gml_str("%s, %s" % (an, rs[0]))))
    # the sprites of the pickups and of the items' looks (rndItemLook): their opaque pixels from the origin, of all frames
    # (rndSprU*) and of each (rndSprF*), for rndItemFit
    sprs = sorted(set(re.findall(r"sprite_index=(s\w+)", read(os.path.join(HERE, "mod", "scripts", "rndItemLook.gml")))) |
                  {object_sprite(o) for c, o, l in LTYPES if object_sprite(o)})
    L.append("global.rndSprMax=0")
    for s in sprs: L.append("global.rndSprMax=max(global.rndSprMax,%s)" % s)
    L.append("for(i=0;i<=global.rndSprMax;i+=1) {global.rndSprK[i]=0}")
    for s in sprs:
        fr = sprite_bounds(s)
        known = [b for b in fr if b]
        u = (min(b[0] for b in known), min(b[1] for b in known), max(b[2] for b in known), max(b[3] for b in known))
        L.append("global.rndSprK[%s]=1; global.rndSprN[%s]=%d; global.rndSprUL[%s]=%d; global.rndSprUT[%s]=%d; global.rndSprUR[%s]=%d; "
                 "global.rndSprUB[%s]=%d" % (s, s, len(fr), s, u[0], s, u[1], s, u[2], s, u[3]))
        for i, b in enumerate(fr):
            b = b or u
            L.append("global.rndSprFL[%s,%d]=%d; global.rndSprFT[%s,%d]=%d; global.rndSprFR[%s,%d]=%d; global.rndSprFB[%s,%d]=%d"
                     % (s, i, b[0], s, i, b[1], s, i, b[2], s, i, b[3]))
    os.makedirs(os.path.join(out, "scripts"), exist_ok=True)
    with open(os.path.join(out, "scripts", "rndData.gml"), "w", encoding="utf-8", newline="\n") as f:
        f.write("\n".join(L) + "\n")
    with open(os.path.join(out, "scripts", "rndWorld.gml"), "w", encoding="utf-8", newline="\n") as f:
        f.write(world_gml())
    with open(os.path.join(HERE, "locations.csv"), "w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        w.writerow(["id", "type", "num", "rooms", "area", "area name", "requires", "vanilla item"])
        for i, r in enumerate(rows):
            w.writerow([i, LT_LABEL[r["type"]].lower(), r["num"], " ".join(r["rooms"]), r["area"] or "",
                        anames.get(r["area"], ""), req_text(r["req"]), "%s %s" % r["item"] if r["item"] else ""])
    with open(os.path.join(HERE, "doors.csv"), "w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        w.writerow(["door (keys N: the first N)", "objectNum", "rooms", "area", "area name"])
        for i, (a, d) in enumerate(door_list):
            w.writerow([i + 1, d, " ".join(sorted(doors[d])), a if a < 999 else "", anames.get(a, "")])
    print("locations %d, items %d (%d abilities added, %d money chests left out), equipment shop slots %d, shops %d"
          % (len(rows), len(items), len(EXTRA), len(drop), k, len(shops)))
    print("locked doors (objectNum: area) in story order:", ", ".join("%d: %s" % (d, a if a < 999 else "?") for a, d in door_list))
    # (stage 9 adds nothing to 8: both are everything)
    cnt = collections.Counter(max((s for s in range(9) if req_le(stage_req(s), r["req"])), default=0) for r in rows)
    print("locations by logic stage:", dict(sorted(cnt.items())))
    print("bosses fought the randomizer's way: %d (%s)" % (len(blist), ", ".join("%d %s" % (t, n) for t, r, x, y, n in blist)))
    # the same placement the game makes (rndGenerate), for a few seeds: it must work under the logic
    ok = sum(1 for seed in range(50) if fill_check(rows, items, seed, door_rank))
    print("placement check: %d of 50 seeds placed" % ok)
    if ok == 0: raise SystemExit("no seed could be placed: the logic asks for more than the locations allow")


def prog_of(item):
    k, p = item
    if k in ("JUMP", "GDASH", "ADASH", "DJUMP", "HIJUMP"): return ["JUMP", "GDASH", "ADASH", "DJUMP", "HIJUMP"].index(k)
    if k == "SET": return 5 + p
    if k == "KEY": return 12
    return -1


def fill_check(rows, items, seed, door_rank):
    """rndGenerate's assumed fill, in Python: whether every progression item finds a place. Keys count as the first
    doors (in the logic's order) whose keys are all had. The most constrained go first (as rndGenerate)"""
    import random
    rnd = random.Random(seed)
    req = [[r["req"][p] for p in PROG] for r in rows]
    prog = [i for i, it in enumerate(items) if prog_of(it) >= 0]
    rnd.shuffle(prog)
    tot = collections.Counter(prog_of(items[i]) for i in prog)

    def places(i):
        p = prog_of(items[i])
        have = [tot[q] for q in range(13)]
        if p == 12: have[12] = door_rank[items[i][1]]
        else: have[p] -= 1
        return sum(1 for r in req if all(a <= b for a, b in zip(r, have)))
    prog.sort(key=places)
    fill = [-1] * len(rows)
    at = []

    def add(have, keys, item):
        p = prog_of(item)
        if p == 12:
            keys.add(door_rank[item[1]])
            have[12] = 0
            while have[12] in keys: have[12] += 1
        else:
            have[p] += 1

    for n, it in enumerate(prog):
        have = [0] * 13
        keys = set()
        for k in prog[n + 1:]: add(have, keys, items[k])
        taken = [False] * n
        changed = True
        while changed:
            changed = False
            for k in range(n):
                if not taken[k] and all(a <= b for a, b in zip(req[at[k]], have)):
                    taken[k] = True; add(have, keys, items[prog[k]]); changed = True
        cand = [i for i in range(len(rows)) if fill[i] < 0 and all(a <= b for a, b in zip(req[i], have))]
        if not cand: return False
        loc = rnd.choice(cand)
        fill[loc] = it; at.append(loc)
    return True


def req_le(a, b):
    return all(a[p] <= b[p] for p in PROG)


def req_str(r):
    return "".join(str(min(9, r[p])) for p in PROG[:-1]) + "%02d" % r["keys"]


def req_text(r):
    return " ".join(("%s" % p if r[p] == 1 and PMAX[i] == 1 else "%s %d" % (p, r[p])) for i, p in enumerate(PROG) if r[p]) or "nothing"


def merge_req(base, ov):
    if ov.get("=", False):
        r = dict.fromkeys(PROG, 0)
        r.update({k: v for k, v in ov.items() if k in PROG})
        return r
    r = dict(base)
    r.update({k: v for k, v in ov.items() if k in PROG})
    return r


def read_logic():
    """logic.txt: '<location type> <number>: <requirements>' or 'room <room>: <requirements>'. Requirements: 'stage N',
    item names from PROG with an optional count (link 2, keys 6), or 'nothing'. A line replaces the estimate."""
    labels = {l.lower(): c for c, l in LT_LABEL.items()}
    over, room_over = {}, {}
    p = os.path.join(HERE, "logic.txt")
    if not os.path.exists(p): return over, room_over
    for ln, line in enumerate(open(p, encoding="utf-8"), 1):
        line = line.split("#", 1)[0].strip()
        if not line: continue
        if ":" not in line: raise SystemExit("logic.txt line %d: no ':'" % ln)
        what, req = [s.strip() for s in line.split(":", 1)]
        r = {"=": True}
        toks = req.replace(",", " ").split()
        i = 0
        while i < len(toks):
            t = toks[i].lower()
            if t == "nothing": i += 1; continue
            if t == "stage":
                r.update(stage_req(int(toks[i + 1]))); i += 2; continue
            if t not in PROG: raise SystemExit("logic.txt line %d: unknown requirement %r" % (ln, t))
            cnt = 1
            if i + 1 < len(toks) and toks[i + 1].isdigit(): cnt = int(toks[i + 1]); i += 1
            r[t] = cnt; i += 1
        if what.lower().startswith("room "):
            room_over[what[5:].strip()] = r
        else:
            m = re.match(r"(.+?)\s+(\d+)$", what)
            if not m or m.group(1).lower() not in labels: raise SystemExit("logic.txt line %d: unknown location %r" % (ln, what))
            over[(labels[m.group(1).lower()], int(m.group(2)))] = r
    return over, room_over


# ---------------------------------------------------------------- world state
#(left as a new game has them: 123iXB tower defense and 123iXC the Trial Master's trials, done again for their rewards;
#129e the shortcuts, opened again; 124 the program chips, 138 the Yoshi dolls and 144 the game completed)
WORLD_KEYS = ["123", "123iA", "123iB", "123iC", "123iD", "123iE", "123iF", "123iG", "123iH", "123iV1", "123iXA",
              "123iXE", "123iXF", "123iXG", "123iXH", "125", "129c", "129g", "134", "134we",
              "136", "140", "141a", "142sg0", "142sg1", "142sg2"]


def save_keys():
    """{save key: (global name, 'real'|'string')} from loadSaveData"""
    t = read(os.path.join(PROJ, "scripts", "loadSaveData.gml"))
    m = {}
    for g, kind, key in re.findall(r"global\.(\w+)=ini_read_(real|string)\(sectionRead,\"(\w+)\"", t):
        m[key] = (g, kind)
    for i in range(3): m["142sg%d" % i] = ("mySegmentCheck[%d]" % i, "real")
    return m


def world_from(save):
    vals = {}
    sec = None
    for line in open(save, encoding="utf-8", errors="replace"):
        line = line.strip()
        if line.startswith("["): sec = line[1:-1]; continue
        if sec == "ALPHA" and "=" in line:
            k, v = line.split("=", 1)
            vals[k] = v
    keys = save_keys()
    with open(os.path.join(HERE, "world.txt"), "w", encoding="utf-8", newline="\n") as f:
        f.write("# the endgame world state the Randomizer starts a game in: save file keys (as loadSaveData reads them) and\n"
                "# their values in a 100%% save (%s), made by rndgen.py --world-from\n" % os.path.basename(save))
        for k in WORLD_KEYS:
            if k in vals: f.write("%s=%s    # global.%s\n" % (k, vals[k], keys.get(k, ("?",))[0]))
    print("world.txt written:", sum(1 for k in WORLD_KEYS if k in vals), "values")


def world_gml():
    keys = save_keys()
    L = ["//The endgame world state (world.txt, from a 100% save), made by tools/modkit/randomizer/rndgen.py"]
    for line in open(os.path.join(HERE, "world.txt"), encoding="utf-8"):
        line = line.split("#", 1)[0].strip()
        if not line: continue
        k, v = [s.strip() for s in line.split("=", 1)]
        g, kind = keys[k]
        L.append("global.%s=%s" % (g, gml_str(v) if kind == "string" else v))
    return "\n".join(L) + "\n"


if __name__ == "__main__":
    main()
