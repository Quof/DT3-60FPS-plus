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

# progression: the items the logic counts, in the order of the requirement strings (one digit each, keys two)
PROG = ["jump", "gdash", "adash", "djump", "hijump", "base", "link", "belmont", "megaman", "samus", "gamej", "gamec", "keys"]
# how many of each there are. The ability sets' items are progressive: each one is the set's next level (hasAbilToken 2,
# 3...): Link and Belmont 3 (their three weapons; nothing uses a level 5), Mega Man 4 (the grapple at 5), Samus 7 (Arm
# Cannon, Morph Ball, Charge Beam, Missiles, Spazer Beam, Bombs, Diffusion Missile), the Gate 6 sets 2
PMAX = [1, 1, 1, 1, 2, 1, 3, 3, 4, 7, 2, 2, 17]
# the abilities that aren't at any location in an endgame world (the story gave them): added to the pool
EXTRA = [("JUMP", 0), ("GDASH", 0), ("ADASH", 0), ("DJUMP", 0), ("HIJUMP", 0), ("HIJUMP", 0)] + \
        [("SET", s) for s, n in enumerate(PMAX[5:12]) for _ in range(n)]

# what the story has given by the time it first reaches an area (the area numbers locationCheck uses are in story
# order): the logic estimate. Each stage has everything the ones before it have
STAGE_ADD = {1: {"jump": 1}, 2: {"base": 1}, 3: {"link": 3}, 4: {"gdash": 1, "belmont": 3}, 5: {"megaman": 4},
             6: {"adash": 1}, 7: {"samus": 7, "hijump": 2}, 8: {"djump": 1, "gamej": 2, "gamec": 2}, 9: {}}


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
    rarea = {r: room_area(r) for r in rooms}

    # ---- locations: (type, objectNum) -> rooms, vanilla item
    locs = collections.OrderedDict()
    doors = collections.defaultdict(set)
    shops = collections.OrderedDict()
    for room in rooms:
        for obj, x, y, hexid, code in instances(room) or []:
            if obj == "oLockedDoor":
                doors[num(code, "objectNum")].add(room)
            elif obj == "oNPC_Shop" and re.search(r"shopType\s*=\s*oShopWindow", code):
                sid = int(hexid, 16)
                inv = [num(code, r"inv\[%d\]" % i) or 0 for i in range(5)]
                mx = num(code, "maxInv") or 5
                s = shops.setdefault(sid, {"rooms": [], "inv": [v for v in inv[:mx]]})
                s["rooms"].append(room)
            elif obj in LT_BY_OBJ:
                t = LT_BY_OBJ[obj]
                n = num(code, "objectNum")
                if t in (15, 16, 17): n = 1
                if n is None: continue
                l = locs.setdefault((t, n), {"rooms": [], "item": None})
                l["rooms"].append(room)
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

    # ---- logic: the stage of each location's area (the most demanding of its rooms), and keys: a key for every locked
    # door in an area up to its own in story order (a door takes a key as soon as the player is next to it)
    door_area = sorted(min((rarea.get(r) or 999) for r in rs) for d, rs in doors.items() if d is not None)
    def keys_for(a):
        if a is None: return PMAX[-1]
        return sum(1 for da in door_area if da <= a)
    overrides, room_over = read_logic()
    rows = []
    for (t, n), l in locs.items():
        areas = [rarea.get(r) for r in l["rooms"]]
        if t == 18:
            req, a = stage_req(0), 1
        else:
            st = max(area_stage(a) for a in areas)
            a = max((x for x in areas if x is not None), default=None) if None not in areas else None
            req = stage_req(st)
            req["keys"] = max(keys_for(x) for x in areas)
        for r in l["rooms"]:
            if r in room_over: req = merge_req(req, room_over[r])
        if (t, n) in overrides: req = merge_req(req, overrides[(t, n)])
        rows.append({"type": t, "num": n, "rooms": l["rooms"], "area": a, "req": req, "item": l["item"]})

    # ---- items: what the locations hold, the abilities, less as many money chests as needed (the smallest)
    items = [r["item"] for r in rows if r["item"] is not None] + list(EXTRA)
    extra = len(items) - len(rows)
    money = sorted((i for i, it in enumerate(items) if it[0] == "MONEY"), key=lambda i: items[i][1])
    drop = set(money[:extra])
    items = [it for i, it in enumerate(items) if i not in drop]
    assert len(items) == len(rows), (len(items), len(rows))

    # ---- write
    os.makedirs(out, exist_ok=True)
    src = os.path.join(HERE, "mod")
    for root, ds, fs in os.walk(src):
        for f in fs:
            rel = os.path.relpath(os.path.join(root, f), src)
            dst = os.path.join(out, rel)
            os.makedirs(os.path.dirname(dst), exist_ok=True)
            shutil.copyfile(os.path.join(root, f), dst)
    L = ["//Randomizer data: every location, the items and the equipment shops, made by tools/modkit/randomizer/rndgen.py",
         "//from the game's rooms (don't change it here: change rndgen.py or logic.txt and build again)",
         "var i,t;",
         "for(t=0;t<=18;t+=1) {for(i=0;i<=130;i+=1) {global.rndLocOf[t,i]=-1}}",
         "global.rndLocN=%d" % len(rows)]
    for i, r in enumerate(rows):
        a = r["area"]
        where = "%s (%s)" % (anames.get(a, "?"), r["rooms"][0]) if a else r["rooms"][0]
        L.append("global.rndLocType[%d]=%d; global.rndLocNum[%d]=%d; global.rndLocOf[%d,%d]=%d; global.rndLocReq[%d]=%s; "
                 "global.rndLocName[%d]=%s" % (i, r["type"], i, r["num"], r["type"], r["num"], i, i, gml_str(req_str(r["req"])),
                                               i, gml_str("%s: %s %d" % (where, LT_LABEL[r["type"]], r["num"]))))
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
    print("locations %d, items %d (%d abilities added, %d money chests left out), equipment shop slots %d, shops %d"
          % (len(rows), len(items), len(EXTRA), len(drop), k, len(shops)))
    print("locked doors by area:", door_area)
    cnt = collections.Counter(max((s for s in range(10) if req_le(stage_req(s), r["req"])), default=0) for r in rows)
    print("locations by logic stage:", dict(sorted(cnt.items())))


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
WORLD_KEYS = ["123", "123iA", "123iB", "123iC", "123iD", "123iE", "123iF", "123iG", "123iH", "123iV1", "123iXA", "123iXB",
              "123iXC", "123iXE", "123iXF", "123iXG", "123iXH", "124", "125", "129c", "129e", "129g", "134", "134we",
              "136", "138", "140", "141a", "142sg0", "142sg1", "142sg2", "144"]


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
