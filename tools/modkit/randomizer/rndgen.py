"""
Builds the DT3+ Randomizer mod from the project: every collectible location in the game's rooms, the item pool, what
each location needs (the room logic's) and the endgame world state, written as the mod's data scripts, with the
hand-written mod files in mod\\.

usage: python rndgen.py <output folder>
       python rndgen.py --world-from <save.dts>      (re-reads world.txt's values from a finished save)

Inputs next to this file:
  mod\\        the mod's own code (mod.ini, hooks, scripts, objects), copied to the output as is
  world.txt   the endgame world state: save file keys (loadSaveData) and their values, from a 100% save
  roomlogic\\  what each location needs, worked out from the rooms: each room's logic (rooms\\), the connections and
              the hand-made changes (overrides.txt), joined by solve.py (roomlogic\\README.txt)
  logic.txt   last-resort changes to single locations (see README.txt)
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
    (16, "oMMBoostedCharge", "X Charge Capsule"), (17, "oMetPick_SpringBall", "Spring Ball")]
LT_BY_OBJ = {o: c for c, o, l in LTYPES}
LT_LABEL = {c: l for c, o, l in LTYPES}
# location types that stay the game's own, not locations: the Item Finder (its pickup gives it, as in the game; the
# mod's oIdentifier makes Chao's alert tell the locations' items apart)
KEEP_TYPES = {15}

# item kinds (the numbers the mod's scripts use)
IK = dict(HP=1, MONEY=2, EQUIP=3, AQ=4, HE=5, MP=6, GP=7, AU=8, WB=9, WL=10, AP=11, LB=12, MB=13, KEY=14, HC=15, XF=16,
          XC=17, XS=18, JUMP=19, GDASH=20, ADASH=21, DJUMP=22, HIJUMP=23, SET=24, VARIA=25)
LT_ITEM = {1: "HP", 3: "AQ", 4: "HE", 5: "MP", 6: "GP", 7: "AU", 8: "WB", 10: "AP", 11: "LB", 12: "MB", 13: "KEY",
           14: "HC", 15: "XF", 16: "XC", 17: "XS"}

# progression: the items the logic counts (their index: the mod's rndItemProg, and the logic's numbers in rndData; a
# key is 20 + its door's objectNum). jump: had from the start (the new game gives it). mario: the Mario Ability Set
# (hasAbilToken[0]: jumping on Mario enemies, hitting blocks from below). varia: the Varia Suit (Gate 5's lava harmless:
# the mod's oMetLava). cursed: the Trial Master's three cursed equipment pieces (equipment 10-12), which the trials need on
PROG = ["jump", "gdash", "adash", "djump", "hijump", "mario", "link", "belmont", "megaman", "samus", "gamej", "gamec",
        "varia", "cursed", "keys"]
KEY_BASE = 20
VARIA_IX, CURSED_IX = 12, 13
CURSED = (10, 11, 12)
# how many of each there are. The ability sets' items are progressive: each one is the set's next level (hasAbilToken 2,
# 3...): Link and Belmont 3 (their three weapons; nothing uses a level 5), Mega Man 4 (the Strike Chain at 5), Samus 7
# (Arm Cannon, Morph Ball, Charge Beam, Missiles, Spazer Beam, Bombs, Diffusion Missile), the Gate 6 sets 2
PMAX = [0, 1, 1, 1, 2, 1, 3, 3, 4, 7, 2, 2, 1, 3, 17]
# the abilities that aren't at any location in an endgame world (the story gave them): added to the pool (not jumping:
# a new game starts with it)
EXTRA = [("GDASH", 0), ("ADASH", 0), ("DJUMP", 0), ("HIJUMP", 0), ("HIJUMP", 0)] + \
        [("SET", s) for s, n in enumerate(PMAX[5:12]) for _ in range(n)] + [("VARIA", 0)]
# the room logic's names for the progression items
LOGIC_NAMES = {"gdash": 1, "adash": 2, "djump": 3, "hijump": 4, "mario": 5, "link": 6, "belmont": 7, "megaman": 8,
               "samus": 9, "gamej": 10, "gamec": 11, "varia": VARIA_IX, "cursed": CURSED_IX}
# a location that needs everything (the logic doesn't reach it, or it's a fight's or a trial's reward): it gets no
# ability or key
EVERYTHING = None
# places whose pickup only shows once something optional is done (their creation code checks the global): tower
# defense's rewards (rCCity_NorthA): need everything
COND_GLOBALS = ("gameOptTowerDef",)
# places a Trial Master trial gives (the pickup's creation code hides it till the trial's done; Central City South's
# heart container, which the mod makes, comes with the 7th): the trials need the three cursed equipment pieces on, so
# these places need them (roomlogic\overrides.txt: cursed 3; the 7th trial, five of the six others done too)
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
# beaten boss goes to the gallery, where rndBossEnd takes over) without its timer. Gate 5's lava hurts till the story
# gives the Varia Suit (gameProgress 2850); in a randomizer game, till the Varia Suit item's found (rndOwn[12])
GAME_PATCHES = [
    ("oHUD", "Draw_0",
     "    if global.bBossGallery=1 and room!=rBossGallery //Display timer in boss gallery\n",
     "    //if global.bBossGallery=1 and room!=rBossGallery //Display timer in boss gallery\n"
     "    if global.bBossGallery=1 and room!=rBossGallery and global.rndFight<0 //Randomizer change: not in a randomizer boss fight\n"),
    ("oMetLava", "Collision_oPlayer1",
     "if global.gameProgress<=2850 {redDmgHit(0)}\n",
     "//if global.gameProgress<=2850 {redDmgHit(0)}\n"
     "if global.gameProgress<=2850 or (global.rndActive=1 and global.rndOwn[12]=0) {redDmgHit(0)} //Randomizer change: in a randomizer game, till the Varia Suit's found\n"),
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
            elif obj in LT_BY_OBJ and LT_BY_OBJ[obj] not in KEEP_TYPES:
                t = LT_BY_OBJ[obj]
                n = num(code, "objectNum")
                if t in (15, 16, 17): n = 1
                if n is None: continue
                l = locs.setdefault((t, n), {"rooms": [], "item": None})
                l["rooms"].append(room)
                for g in COND_GLOBALS:
                    if re.search(r"global\.%s\b" % g, code): l["cond"] = 1
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

    # ---- logic: what the room logic says each location needs (roomlogic.txt: alternatives, each the progression items
    # and the keys it takes; each key opens its own door, the mod's oLockedDoor). The doors are listed in their areas'
    # order (for the keys' names and the Archipelago world)
    door_list = sorted((min((rarea.get(r) or 999) for r in rs), d) for d, rs in doors.items() if d is not None)
    door_order = [d for a, d in door_list]
    door_rank = {d: i for i, d in enumerate(door_order)}
    roomlogic = read_roomlogic()
    overrides, room_over = read_logic()
    rows = []
    for (t, n), l in locs.items():
        areas = [rarea.get(r) for r in l["rooms"]]
        a = max((x for x in areas if x is not None), default=None) if None not in areas else None
        req = roomlogic.get((t, n), EVERYTHING)
        if t == 14 and n == TRIAL_HC: l["trial"] = 1
        if (t == 14 and n in HC_BOSS) or l.get("cond"):
            # a heart container a boss's fight gives, or tower defense's reward: no ability or key there, so a fight that
            # can't be won yet never holds the game back
            req = EVERYTHING
        for r in l["rooms"]:
            if r in room_over: req = room_over[r]
        if (t, n) in overrides: req = overrides[(t, n)]
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
    # each location's logic: its alternatives (rndLocAltN, -1: it needs everything), each a list (rndLocAltLen long) of
    # what it takes: rndLocAltIx a progression item's number (rndProgOf; KEY_BASE+objectNum for a door's key) and
    # rndLocAltC how many (index a*ALT_STRIDE+j)
    for i, r in enumerate(rows):
        a = r["area"]
        where = "%s (%s)" % (anames.get(a, "?"), r["rooms"][0]) if a else r["rooms"][0]
        L.append("global.rndLocType[%d]=%d; global.rndLocNum[%d]=%d; global.rndLocOf[%d,%d]=%d; "
                 "global.rndLocName[%d]=%s; global.rndLocTrial[%d]=%d"
                 % (i, r["type"], i, r["num"], r["type"], r["num"], i,
                    i, gml_str("%s: %s %d" % (where, LT_LABEL[r["type"]], r["num"])), i, r["trial"]))
        if r["req"] is EVERYTHING:
            L.append("global.rndLocAltN[%d]=-1" % i)
            continue
        s = ["global.rndLocAltN[%d]=%d" % (i, len(r["req"]))]
        for ai, alt in enumerate(r["req"]):
            s.append("global.rndLocAltLen[%d,%d]=%d" % (i, ai, len(alt)))
            for j, (ix, c) in enumerate(sorted(alt.items())):
                s.append("global.rndLocAltIx[%d,%d]=%d; global.rndLocAltC[%d,%d]=%d" % (i, ai * ALT_STRIDE + j, ix, i, ai * ALT_STRIDE + j, c))
        L.append("; ".join(s))
    L.append("global.rndKeyBase=%d; global.rndAltStride=%d" % (KEY_BASE, ALT_STRIDE))
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
    L.append("global.rndApBase=%d //Archipelago: a location's id is this+type*1000+objectNum, an item's this+kind*10000+parameter" % AP_BASE)
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
    sprs = sorted(set(re.findall(r"sprite_index=(s\w+)", read(os.path.join(HERE, "mod", "scripts", "rndItemLookKP.gml")))) |
                  {object_sprite(o) for c, o, l in LTYPES if object_sprite(o)})
    # and the Archipelago look of another world's item: the mod's own sprite (made here)
    ap_bounds = ap_sprite(os.path.join(out, "sprites"))
    sprs.append(AP_SPRITE)
    L.append("global.rndSprMax=0")
    for s in sprs: L.append("global.rndSprMax=max(global.rndSprMax,%s)" % s)
    L.append("for(i=0;i<=global.rndSprMax;i+=1) {global.rndSprK[i]=0}")
    for s in sprs:
        fr = ap_bounds if s == AP_SPRITE else sprite_bounds(s)
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
        w.writerow(["order", "objectNum (key N in logic.txt)", "rooms", "area", "area name"])
        for i, (a, d) in enumerate(door_list):
            w.writerow([i + 1, d, " ".join(sorted(doors[d])), a if a < 999 else "", anames.get(a, "")])
    print("locations %d, items %d (%d abilities added, %d money chests left out), equipment shop slots %d, shops %d"
          % (len(rows), len(items), len(EXTRA), len(drop), k, len(shops)))
    print("locked doors (objectNum: area):", ", ".join("%d: %s" % (d, a if a < 999 else "?") for a, d in door_list))
    free = sum(1 for r in rows if r["req"] is not EVERYTHING and any(not alt for alt in r["req"]))
    some = sum(1 for r in rows if r["req"] is not EVERYTHING)
    print("locations: %d need nothing but jumping, %d can hold an ability or key, %d need everything (no ability or key)"
          % (free, some, len(rows) - some))
    print("bosses fought the randomizer's way: %d (%s)" % (len(blist), ", ".join("%d %s" % (t, n) for t, r, x, y, n in blist)))
    # the same placement the game makes (rndGenerate), for a few seeds with each option: it must work under the logic
    for label, wpn, spread in (("default options", False, 1), ("Guarantee Early Weapons", True, 1),
                               ("Ability Spread Near", False, 0), ("Ability Spread Far", False, 2)):
        results = [fill_check(rows, items, seed, door_order, wpn, SPREAD[spread]) for seed in range(50)]
        ok = [r for r in results if r]
        if not ok: raise SystemExit("%s: no seed could be placed: the logic asks for more than the locations allow" % label)
        depth = [max(p[0] for p in r) + 1 for r in ok]
        print("placement check, %s: %d of 50 seeds placed, layers %d to %d (average %.1f)"
              % (label, len(ok), min(depth), max(depth), sum(depth) / len(depth)))
    ap_export(rows, items, door_order, doors, rarea, anames, out)


# ---------------------------------------------------------------- Archipelago
# The DT3+ world (archipelago\dt3plus): its data (data.py, written here from the same locations, items and logic as the
# mod's) and the packed world, dt3plus.apworld, in the build's archipelago folder. Ids: a location's AP_BASE +
# type*1000 + objectNum, an item's AP_BASE + kind*10000 + parameter (the mod's rndApBase works them out the same way)
AP_GAME = "DT3+"
AP_VERSION = 2
AP_BASE = 4454000
AP_DIR = os.path.join(HERE, "archipelago", "dt3plus")
AP_SPRITE = "sRndAPItem"
AP_WEAPONS = ["Master Sword", "Bow & Arrow", "Fuse Bomb", "Hair Whip", "Dagger", "Holy Water", "X-Buster", "Shotgun Ice",
              "Gravity Well", "Arm Cannon", "Missile", "Morph Bomb"]
AP_SETS = ["Mario Ability Set", "Progressive Link", "Progressive Belmont", "Progressive Mega Man", "Progressive Samus",
           "Progressive Jerry Game Powers", "Progressive Claire Game Powers"]
# the progression items the logic counts, in PROG's order (keys aside; the cursed equipment is three items of its own,
# CURSED_GEAR, which a trial's place needs)
AP_PROG = ["Jump", "Dash", "Air Dash", "Double Jump", "Progressive High Jump Boots"] + AP_SETS + ["Varia Suit"]
AP_SIMPLE = {"HP": "Heart Piece", "AQ": "Arrow Quiver", "HE": "Heart Energy Expansion", "MP": "Missile Expansion",
             "GP": "Game Power", "AU": "Air Upgrade", "WB": "Internetz Mod", "AP": "Skill Point", "LB": "Bomb Upgrade",
             "MB": "Morph Bomb Upgrade", "HC": "Heart Container", "XF": "Item Finder", "XC": "X-Special Charge",
             "XS": "Spring Ball", "GDASH": "Dash", "ADASH": "Air Dash", "DJUMP": "Double Jump",
             "HIJUMP": "Progressive High Jump Boots", "VARIA": "Varia Suit"}
AP_CURSED = (10, 11, 12)  # the cursed equipment the Trial Master's trials need on


def equipment_names():
    """equipmentInit's names of the equipment (its list 2), by number"""
    t = read(os.path.join(PROJ, "scripts", "equipmentInit.gml"))
    t = t[t.find("tItemList=2"):]
    return {int(m.group(1)): m.group(2) for m in re.finditer(r'tItemIndex=(\d+)\s*\{\s*equipCheck\[1\]="([^"]*)"', t)}


def ap_sprite(folder):
    """the mod's sprite for another world's item, 16x16: six coloured orbs in a ring, outlined. Returns its bounds as
    sprite_bounds does"""
    sys.path.insert(0, os.path.dirname(HERE))
    import math, png
    cols = [(232, 72, 85), (245, 152, 66), (240, 220, 80), (95, 200, 95), (80, 140, 235), (175, 105, 225)]
    centres = [(7.5 + 4.6 * math.cos(math.radians(-90 + 60 * k)), 7.5 + 4.6 * math.sin(math.radians(-90 + 60 * k))) for k in range(6)]
    rows = []
    for y in range(16):
        row = bytearray(16 * 4)
        for x in range(16):
            px = None
            for (cx, cy), col in zip(centres, cols):
                d = math.hypot(x - cx, y - cy)
                if d <= 2.1: px = col + (255,); break
                if d <= 3.0 and px is None: px = (24, 24, 32, 255)
            if px: row[x * 4:x * 4 + 4] = bytes(px)
        rows.append(row)
    os.makedirs(folder, exist_ok=True)
    png.write(os.path.join(folder, AP_SPRITE + ".png"), 16, 16, rows)
    with open(os.path.join(folder, AP_SPRITE + ".ini"), "w", encoding="utf-8", newline="\n") as f:
        f.write("[sprite]\nframes=1\nxorig=0\nyorig=0\ntransparent=0\nsmooth=0\nsepmasks=0\nbboxmode=0\nleft=0\ntop=0\n"
                "right=15\nbottom=15\nkind=0\ntolerance=0\n")
    xs = [x for y, r in enumerate(rows) for x in range(16) if r[x * 4 + 3]]
    ys = [y for y, r in enumerate(rows) for x in range(16) if r[x * 4 + 3]]
    return [(min(xs), min(ys), max(xs), max(ys))]


def ap_export(rows, items, door_order, doors, rarea, anames, out):
    import zipfile
    equip = equipment_names()
    # the keys, by door: named after the door's area (numbered where an area has several)
    door_area_name = {d: anames.get(rarea.get(sorted(doors[d])[0]), sorted(doors[d])[0]) for d in door_order}
    key_names = {}
    for d in door_order:
        same = [e for e in door_order if door_area_name[e] == door_area_name[d]]
        key_names[d] = "Key: " + door_area_name[d] + (" %d" % (same.index(d) + 1) if len(same) > 1 else "")

    def name_of(kind, p):
        if kind in AP_SIMPLE: return AP_SIMPLE[kind]
        if kind == "MONEY": return "%d Internetz" % p
        if kind == "EQUIP": return equip.get(p, "Equipment %d" % p)
        if kind == "WL": return "Weapon Upgrade: " + AP_WEAPONS[p]
        if kind == "KEY": return key_names[p]
        if kind == "SET": return AP_SETS[p]
        raise SystemExit("no Archipelago name for item %s %s" % (kind, p))

    def classification(kind, p):
        if kind in ("GDASH", "ADASH", "DJUMP", "HIJUMP", "SET", "KEY", "VARIA"): return 1  # progression
        if kind == "EQUIP" and p in AP_CURSED: return 1
        if kind == "MONEY": return 0                                                       # filler
        return 2                                                                           # useful

    ap_items = collections.OrderedDict()
    for kind, p in items:
        n = name_of(kind, p)
        iid = AP_BASE + IK[kind] * 10000 + p
        if n in ap_items:
            if ap_items[n][0] != iid: raise SystemExit("two items named %r" % n)
            ap_items[n][2] += 1
        else:
            ap_items[n] = [iid, classification(kind, p), 1]
    money = sorted(p for kind, p in items if kind == "MONEY")
    filler = name_of("MONEY", money[0]) if money else "Heart Piece"
    cursed = [equip[p] for p in AP_CURSED]
    for c in cursed:
        if c not in ap_items: raise SystemExit("the cursed equipment %r isn't in the pool" % c)

    def ap_need(ix):
        return key_names[ix - KEY_BASE] if ix >= KEY_BASE else AP_PROG[ix]

    ap_locs = collections.OrderedDict()
    for r in rows:
        a = r["area"]
        where = anames.get(a) if a else None
        n = "%s - %s %d" % (where or r["rooms"][0], LT_LABEL[r["type"]], r["num"])
        if n in ap_locs: raise SystemExit("two locations named %r" % n)
        # (the cursed equipment a trial's place needs: CURSED_GEAR, by its trial flag)
        need = None if r["req"] is EVERYTHING else [[(ap_need(ix), c) for ix, c in sorted(alt.items()) if ix != CURSED_IX] for alt in r["req"]]
        ap_locs[n] = (AP_BASE + r["type"] * 1000 + r["num"], need, bool(r.get("trial")))
    everything = [(AP_PROG[p], PMAX[p]) for p in range(1, VARIA_IX + 1) if PMAX[p]] + [(c, 1) for c in cursed] + \
                 [(key_names[d], 1) for d in door_order]

    L = ['"""DT3+ Archipelago data, made by tools/modkit/randomizer/rndgen.py from the game (change rndgen.py, not this)"""',
         "GAME = %r" % AP_GAME,
         "VERSION = %d" % AP_VERSION,
         "BASE_ID = %d" % AP_BASE,
         "# the progression items the logic counts (a new game starts with jumping)",
         "PROG_ITEMS = %r" % AP_PROG[1:],
         "SET_ITEMS = %r" % AP_SETS,
         "# the keys, each its own door's",
         "DOOR_KEYS = %r" % [key_names[d] for d in door_order],
         "# what the Trial Master's trials need on",
         "CURSED_GEAR = %r" % cursed,
         "FILLER = %r" % filler,
         "# every progression item: what a location the logic doesn't reach needs, and the win",
         "EVERYTHING = %r" % everything,
         "VICTORY_LOCATION = 'Defeat the CHAOS Warmaster'",
         "# name: (id, classification (0 filler, 1 progression, 2 useful), how many in the pool)",
         "ITEMS = {"]
    L += ["    %r: (%d, %d, %d)," % (n, v[0], v[1], v[2]) for n, v in ap_items.items()]
    L += ["}",
          "# name: (id, what it needs: alternatives, each [(item, count)], any one of which is enough (None: EVERYTHING),",
          "#        a Trial Master trial's (needs CURSED_GEAR too))",
          "LOCATIONS = {"]
    L += ["    %r: (%d, %r, %r)," % (n, v[0], v[1], v[2]) for n, v in ap_locs.items()]
    L += ["}"]
    with open(os.path.join(AP_DIR, "data.py"), "w", encoding="utf-8", newline="\n") as f:
        f.write("\n".join(L) + "\n")

    # the packed world: a zip with the dt3plus folder in it
    os.makedirs(os.path.join(out, "archipelago"), exist_ok=True)
    dest = os.path.join(out, "archipelago", "dt3plus.apworld")
    with zipfile.ZipFile(dest, "w", zipfile.ZIP_DEFLATED) as z:
        for root, ds, fs in os.walk(AP_DIR):
            ds[:] = [d for d in ds if d != "__pycache__"]
            for f in sorted(fs):
                if f.endswith((".pyc", ".tmp")): continue
                p = os.path.join(root, f)
                z.write(p, os.path.join("dt3plus", os.path.relpath(p, AP_DIR)).replace("\\", "/"))
    print("Archipelago: %d locations, %d items in %d kinds (filler %r), %s" % (len(ap_locs), len(items), len(ap_items), filler, dest))


def prog_of(item):
    """an item's progression number (rndProgOf: 1-11 an ability or set, 12 the Varia Suit, 13 a cursed equipment piece,
    KEY_BASE+objectNum a door's key), or -1"""
    k, p = item
    if k in ("JUMP", "GDASH", "ADASH", "DJUMP", "HIJUMP"): return ["JUMP", "GDASH", "ADASH", "DJUMP", "HIJUMP"].index(k)
    if k == "SET": return 5 + p
    if k == "VARIA": return VARIA_IX
    if k == "EQUIP" and p in CURSED: return CURSED_IX
    if k == "KEY": return KEY_BASE + p
    return -1


# rndGenerate's layers: each progression item goes to a free location the items placed before it reach, in the newest
# layer (what the last item opened) with this chance, else the one before with it, and so on. The new game's options
# (oRndOptions) choose it: Ability Spread Near, Normal, Far
SPREAD = (0.3, 0.7, 1.0)
NEWEST = SPREAD[1]
# the weapons (the ability sets with an attack, the room logic's "attack": Link, Belmont, Mega Man, Samus). With the
# option Guarantee Early Weapons, every layer gets one while there are any left: the first item placed in a new layer
WEAPONS = (6, 7, 8, 9)
ALT_STRIDE = 40   # (rndLocAltIx/rndLocAltC: an alternative's entries are a*ALT_STRIDE+j)


def reaches(req, have, all_had):
    if req is EVERYTHING: return all_had
    return any(all(have[ix] >= c for ix, c in alt.items()) for alt in req)


def fill_check(rows, items, seed, door_order, weapons=False, newest=NEWEST):
    """rndGenerate's placement in Python (the same steps, Python's random numbers): the progression items one at a time,
    each one that opens a location the items so far don't reach if there is one (else any; a kind that opens fewer is
    likelier), at a free location they reach, by layer. weapons: Guarantee Early Weapons (a new layer's first item is a
    weapon); newest: Ability Spread's chance. Returns [(layer, location, item)] for the items, or None when one had
    nowhere to go"""
    import random
    rnd = random.Random(seed)
    prog = [i for i, it in enumerate(items) if prog_of(it) > 0]
    rnd.shuffle(prog)
    total = collections.Counter(prog_of(items[i]) for i in prog)
    have = collections.Counter()
    layer = [-1] * len(rows)
    filled = [False] * len(rows)
    armed = set()   # the layers with a weapon
    cur = 0

    def mark(lay):
        all_had = all(have[ix] >= n for ix, n in total.items())
        new = 0
        for i, r in enumerate(rows):
            if layer[i] < 0 and reaches(r["req"], have, all_had): layer[i] = lay; new += 1
        return new
    mark(0)
    placed = []
    remaining = list(prog)
    while remaining:
        useful = collections.Counter()
        for i, r in enumerate(rows):
            if layer[i] >= 0 or r["req"] is EVERYTHING: continue
            for alt in r["req"]:
                short = [ix for ix, c in alt.items() if have[ix] < c]
                if len(short) == 1 and alt[short[0]] - have[short[0]] == 1: useful[short[0]] += 1
        pool = remaining
        force = False
        if weapons and cur not in armed and any(not filled[i] for i in range(len(rows)) if layer[i] == cur):
            pool = [k for k in remaining if prog_of(items[k]) in WEAPONS]
            if pool: force = True
            else: pool = remaining
        cand = [k for k in pool if useful[prog_of(items[k])] > 0]
        if cand:
            kinds = sorted(set(prog_of(items[c]) for c in cand))
            r = rnd.random() * sum(1.0 / useful[ix] for ix in kinds)
            kind = kinds[-1]
            for ix in kinds:
                r -= 1.0 / useful[ix]
                if r <= 0: kind = ix; break
            cand = [c for c in cand if prog_of(items[c]) == kind]
        else:
            cand = list(pool)
        k = rnd.choice(cand)
        if force:
            pick = cur
        else:
            layers = sorted({layer[i] for i in range(len(rows)) if layer[i] >= 0 and not filled[i]}, reverse=True)
            if not layers: return None
            pick = layers[-1]
            for lay in layers:
                if rnd.random() < newest: pick = lay; break
        loc = rnd.choice([i for i in range(len(rows)) if layer[i] == pick and not filled[i]])
        filled[loc] = True
        placed.append((pick, loc, k))
        if prog_of(items[k]) in WEAPONS: armed.add(pick)
        remaining.remove(k)
        have[prog_of(items[k])] += 1
        if mark(cur + 1): cur += 1
    return placed


def alt_text(alt):
    if not alt: return "nothing"
    names = {v: k for k, v in LOGIC_NAMES.items()}
    out = []
    for ix, c in sorted(alt.items()):
        if ix >= KEY_BASE: out.append("key %d" % (ix - KEY_BASE))
        elif PMAX[ix] == 1: out.append(names[ix])
        else: out.append("%s %d" % (names[ix], c))
    return " ".join(out)


def req_text(req):
    return "everything" if req is EVERYTHING else " | ".join(alt_text(a) for a in req)


def read_roomlogic():
    """{(type, number): alternatives} from the room logic: roomlogic\\solve.py joins each room's logic (roomlogic\\rooms\\),
    the connections and the hand-made changes (roomlogic\\overrides.txt), and writes roomlogic\\roomlogic.txt. A place it
    doesn't reach needs EVERYTHING"""
    rl = os.path.join(HERE, "roomlogic")
    if not os.path.isdir(os.path.join(rl, "rooms")):
        raise SystemExit("roomlogic\\rooms isn't there: run roomlogic\\roomlogic.py first (see roomlogic\\README.txt)")
    sys.path.insert(0, rl)
    import solve
    out = {}
    for key, alts in solve.solve_all().items():
        conv = []
        for a in alts:
            if a.o: continue   # (a way only with an option on: the mod has no such options yet)
            alt = {LOGIC_NAMES[solve.ITEMS[i]]: n for i, n in enumerate(a.c) if n}
            for k in a.k: alt[KEY_BASE + k] = 1
            conv.append(alt)
        out[key] = conv if conv else EVERYTHING
    return out


def read_logic():
    """logic.txt: '<location type> <number>: <requirements>' or 'room <room>: <requirements>', replacing the room
    logic's. Requirements: alternatives separated by |, each the items it takes (djump, samus 4, key 3: a door's key by
    its objectNum), 'nothing' or 'everything'"""
    labels = {l.lower(): c for c, l in LT_LABEL.items()}
    over, room_over = {}, {}
    p = os.path.join(HERE, "logic.txt")
    if not os.path.exists(p): return over, room_over
    for ln, line in enumerate(open(p, encoding="utf-8"), 1):
        line = line.split("#", 1)[0].strip()
        if not line: continue
        if ":" not in line: raise SystemExit("logic.txt line %d: no ':'" % ln)
        what, req = [s.strip() for s in line.split(":", 1)]
        if req.strip().lower() == "everything":
            r = EVERYTHING
        else:
            r = []
            for part in req.split("|"):
                alt = {}
                toks = part.replace(",", " ").split()
                i = 0
                while i < len(toks):
                    t = toks[i].lower()
                    if t == "nothing": i += 1; continue
                    cnt = 1
                    if i + 1 < len(toks) and toks[i + 1].isdigit(): cnt = int(toks[i + 1]); i += 1
                    if t == "key": alt[KEY_BASE + cnt] = 1
                    elif t in LOGIC_NAMES: alt[LOGIC_NAMES[t]] = cnt
                    else: raise SystemExit("logic.txt line %d: unknown requirement %r" % (ln, t))
                    i += 1
                r.append(alt)
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
