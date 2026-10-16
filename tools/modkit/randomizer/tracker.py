"""
tracker.py: the Check Tracker and the Item Tracker, two pages in the mod's tracker folder (tracker\\checks.html,
tracker\\items.html) opened in a web browser (or a stream's browser source) next to the game. The game writes what the
player has and has taken to tracker\\state.js whenever it changes (the mod's rndTrackWrite); the pages read it again
every second.

rndgen.py builds the pages' data here (tracker\\data.js): every check with its name, tab and screen (tracker_names.txt),
the room logic's tables (roomlogic\\erflat.py's: the same ones the mod's seeds are made with, so the pages work out what
the player's items reach with the seed's doors, bosses and options as the seed was made), the Item Tracker's items and
bosses, and their pictures (the game's own sprites, written to tracker\\icons: the bosses' heads cut out of theirs,
BOSS_ICONS). The pages' own files (the HTML, tracker.js, tracker.css) are in mod\\tracker, copied as they are.

A check is shown
  taken (blue)          the game has it taken (rndGot)
  in logic (green)      the player's items reach it: a place the room logic gets to; a Nightmare Gate's reward: its boss
                        beaten, or its fight reached (the gate's event); a boss's heart container: its place reached, its
                        boss beaten or its fight reached
  out of logic (red)    not yet. A check the seed gave no progression item because the logic doesn't reach it (or it's
                        tower defense's reward) is in logic once the player has every progression item
"""
import os, re, sys, json, collections
import rndgen

HERE = rndgen.HERE
NAMES = os.path.join(HERE, "tracker_names.txt")
# a check's rule (data.js's locs[].rule): the room logic's places, a Nightmare Gate's reward, a boss's heart container,
# every progression item
RULE_PLACE, RULE_GATE, RULE_BOSS_HEART, RULE_EVERYTHING = 0, 1, 2, 3
# the counters' places the game's general shop sells (oOtherShopA marks its own place in the game's string; the mod's
# rndMarkNext skips it): one more each than the pool has
SHOP_EXTRA = {"HP": 1, "AQ": 1, "HE": 1, "MP": 1, "AP": 1}

# the Item Tracker: groups of items, each (id, name, what says it's had, picture). What says it's had (the state's):
#   ("own", n, level)     global.rndOwn[n] at least level (0 jump, 1 dash ... 5-11 the ability sets, 12 the Varia Suit)
#   ("own", n, 1, max)    one picture for levels 1 to max (the level shown on it)
#   ("flag", key)         the state's key is 1
#   ("gate", g)           the instrument g had (eGateProg's place g is 9)
#   ("equip", p)          equipment p had (equipItems)
#   ("chip", g)           the Program Chip g had (the state's chips: rndChipOwn; all six without Chip Randomizer)
# A picture: (sprite, frame, tint (as image_blend) or None)
INSTRUMENTS = ["Full Moon Cello", "Conch Horn", "Sea Lily's Bell", "Surf Harp", "Wind Marimba", "Coral Triangle",
               "Organ of Evening Calm", "Thunder Drum"]
WLP = "sWeaponLevelPickup"
ITEM_GROUPS = [
    ("Movement", [
        ("dash", "Dash", ("own", 1, 1), ("sDashBoots", 0, (255, 220, 120))),
        ("adash", "Air Dash", ("own", 2, 1), ("sDashBoots", 0, (150, 210, 255))),
        ("djump", "Double Jump", ("own", 3, 1), ("sDoubleJumpItem", 0, None)),
        ("hijump", "High Jump Boots", ("own", 4, 1, 2), ("sHiJumpBoots", 1, None)),
        ("varia", "Varia Suit", ("own", 12, 1), ("sVariaPickup", 0, None)),
        ("spring", "Spring Ball", ("flag", "spring"), ("sMetPick_SpringBall", 0, None)),
        ("xcharge", "X-Special Charge", ("flag", "xcharge"), (WLP, 6, (120, 190, 255))),
        ("finder", "Item Finder", ("flag", "finder"), ("sItemFinderPickup", 0, None)),
    ]),
    ("Mario", [("mario", "Mario Ability Set", ("own", 5, 1), ("sMarioQBlockN", 0, None))]),
    ("Link", [
        ("link1", "Master Sword", ("own", 6, 1), (WLP, 0, None)),
        ("link2", "Bow & Arrow", ("own", 6, 2), (WLP, 1, None)),
        ("link3", "Fuse Bomb", ("own", 6, 3), (WLP, 2, None)),
    ]),
    ("Belmont", [
        ("belmont1", "Hair Whip", ("own", 7, 1), (WLP, 3, None)),
        ("belmont2", "Dagger", ("own", 7, 2), (WLP, 4, None)),
        ("belmont3", "Holy Water", ("own", 7, 3), (WLP, 5, None)),
    ]),
    ("Mega Man", [
        ("mm1", "X Buster", ("own", 8, 1), (WLP, 6, None)),
        ("mm2", "Shotgun Ice", ("own", 8, 2), (WLP, 7, None)),
        ("mm3", "Gravity Well", ("own", 8, 3), (WLP, 8, None)),
        ("mm4", "Strike Chain", ("own", 8, 4), ("sStrikeChainPoint", 0, None)),
    ]),
    ("Samus", [
        ("samus1", "Arm Cannon", ("own", 9, 1), (WLP, 9, None)),
        ("samus2", "Morph Ball", ("own", 9, 2), ("sMorphBallPickup", 0, None)),
        ("samus3", "Charge Beam", ("own", 9, 3), ("sChargePickup", 0, None)),
        ("samus4", "Missiles", ("own", 9, 4), ("sMetPick_Missile", 0, None)),
        ("samus5", "Spazer Beam", ("own", 9, 5), ("sSpazerPickup", 0, None)),
        ("samus6", "Bombs", ("own", 9, 6), (WLP, 11, None)),
        ("samus7", "Diffusion Missile", ("own", 9, 7), ("sMetPick_SuperMissile", 0, None)),
    ]),
    ("Jerry", [
        ("jerry1", "Jerry's Game Powers", ("own", 10, 1), ("sGamePower", 0, None)),
        ("jerry2", "Bird Swarm", ("own", 10, 2), ("sJF_Bird", 0, None)),
    ]),
    ("Claire", [
        ("claire1", "Claire's Game Powers", ("own", 11, 1), ("sGamePower", 0, None)),
        ("claire2", "Flame Shield", ("own", 11, 2), ("sJCGameFlameBall", 0, None)),
    ]),
    ("Instruments", [("instr%d" % g, INSTRUMENTS[g - 1], ("gate", g), ("sPauseM_Instruments", g - 1, None))
                     for g in range(1, 9)]),
    ("Program Chips", [("chip%d" % g, "Program Chip %d" % g, ("chip", g), ("sPauseM_Chips", g - 1, None))
                       for g in range(1, 7)]),
    # (the Nightmare abilities: rndOwn 13-16, the pickups' look, rndItemLookKP's)
    ("Nightmare", [("nm%d" % p, "Nightmare " + n, ("own", 13 + p, 1), (WLP, f, (205, 110, 255)))
                   for p, (n, f) in enumerate(zip(rndgen.NIGHTMARE, (0, 6, 4, 11)))]),
    ("Cursed Equipment", [("cursed%d" % p, n, ("equip", p), ("sEquipItemIcons", p, None))
                          for p, n in ((10, "Cursed Helm"), (11, "Cursed Ring"), (12, "Cursed Pendant"))]),
]
# the counters: (id, name, the state's string (its places 1 to n, or lo to hi), the pool's item kind, picture). How many
# of the string's places are 1, of how many the pool has (and the general shop: SHOP_EXTRA); the keys: those found
COUNTERS = [
    ("keys", "Keys", ("keys",), "KEY", ("sDoorKey", 0, None)),
    ("hp", "Heart Pieces", ("count", "hp"), "HP", ("sHeartPiece", 0, None)),
    ("hc", "Heart Containers", ("count", "hc"), "HC", ("sHeartContainer", 0, None)),
    ("he", "Heart Energy", ("count", "he"), "HE", ("sHeartEnergy", 0, None)),
    ("aq", "Arrow Quivers", ("count", "aq"), "AQ", ("sArrowQuiver", 0, None)),
    ("mp", "Missile Tanks", ("count", "mp"), "MP", ("sMissilePack", 0, None)),
    ("gp", "Game Power", ("count", "gp"), "GP", ("sGamePower", 0, None)),
    ("au", "Air Upgrades", ("count", "au"), "AU", ("sAirUpgrade", 0, None)),
    ("wl", "Weapon Upgrades", ("count", "wl"), "WL", (WLP, 0, None)),
    ("lb", "Bomb Upgrades", ("count", "bu", 1, 5), "LB", ("sLinkBombUpgrade", 0, None)),
    ("mb", "Morph Bomb Upgrades", ("count", "bu", 6, 10), "MB", ("sMorphBombPickup", 0, None)),
    ("sp", "Skill Points", ("count", "sp"), "AP", ("sAPBoost", 0, None)),
    ("wb", "Internetz Mods", ("count", "wb"), "WB", ("sWalletBoost", 0, None)),
]


# the Item Tracker's bosses, in the boss gallery's order (its types), the CHAOS Warmaster (the win) last: each one's
# head, from a sprite of its own: (type, sprite, frame, the square cut out (x, y, size: up to 32, made 32 (by whole
# steps for 16 or 32); 64, 96 or 128, made 32 by averaging), options: layers (sprites drawn together, as the boss's Draw event does,
# each one's corner at its x, y; a fifth value, true: that one mirrored), tint (multiplied, as image_blend), recolor
# (its light, as that colour), solid (its
# pixels made opaque: a sprite the game draws faint), silhouette (made whole after scaling: a black shape full of gaps),
# flip (mirrored), outline (a colour round it: a dark one on the dark page), special (drawn here: see defective_head,
# final_nightmare_head)).
# Type 58 is the Abomination (the gallery's last instrument fight, beaten: gateHProg 200); the rest are the
# Randomizer's bosses (rndgen.py's boss_list) but those BOSS_UNTRACKED has
BOSS_ICONS = [
    (1, "sBowserStand", 0, (13, 1, 20), {}),
    (2, "sCacklettaIdle", 0, (0, 0, 32), {}),
    (3, "sKamekIdle", 0, (8, 0, 32), {}),
    (4, "sHelmetHeadBody", 0, (0, -12, 16), {"layers": [("sHelmetHeadBody", 0, 0, 0), ("sHelmetHeadA", 0, 4, -11)]}),
    (5, "sDeadHand_Idle", 0, (12, -2, 32), {}),
    (6, "sBarbaHead", 0, (0, -8, 32), {}),
    (7, "sThunderbirdFace", 0, (0, 0, 16), {}),
    (8, "sAquaSer_HeadB", 0, (0, 0, 32), {}),
    (9, "sFNightmareEyes", 0, None, {"special": "finalnightmare", "outline": (60, 110, 70)}),
    (10, "sControlVirusCore", 0, (0, 0, 32), {}),
    (11, "sLargeVampireBat", 0, (64, 30, 32), {}),
    (12, "sDraculaIdle", 0, (29, -1, 16), {}),
    (13, "sMenaceHead", 0, (0, 3, 64), {"flip": True}),
    (14, "sDeathWalk", 0, (3, 44, 32), {}),
    (16, "sBlackmoorMain", 0, (-4, 16, 64), {"silhouette": True, "outline": (140, 120, 165), "flip": True}),
    (17, "sEnmityBody", 0, (43, 16, 64), {}),
    (18, "sMaohGiantBody", 0, (60, 52, 64), {}),
    (19, "sStormE_Idle", 0, (6, 0, 32), {}),
    (20, "sOOstrich_Idle", 0, (4, -2, 32), {}),
    (21, "sGBeetle_Idle", 0, (10, 14, 32), {}),
    (22, "sBospiderMain", 0, (14, 14, 32), {}),
    (23, "sBit_ArmUp", 0, (4, -2, 32), {}),
    (24, "sSigmaA_Head", 0, (0, 1, 16), {}),
    (26, "sElpizoIdle", 0, (18, 0, 16), {}),
    (27, "sArmyEyeMain", 0, (22, 0, 32), {}),
    (28, "sHex_A_Idle", 0, (3, -1, 16), {"solid": True}),
    (29, "sJerryIdle", 0, (-3, -4, 32), {"tint": (0, 0, 0), "outline": (120, 80, 170)}),
    (30, "sVaultDemonIdle", 0, (44, 34, 32), {}),
    (31, "sArachnusIdle", 0, (22, 4, 32), {}),
    (32, "sKingWormEye", 0, (13, 9, 32), {"layers": [("sKingWormEye", 0, 13, 9), ("sKingWormHead", 0, 0, 0)], "flip": True}),
    (33, "sKraidHead", 0, (40, 24, 64), {}),
    (34, "sMotherBrainBrain", 0, (8, 10, 64), {"layers": [("sMotherBrainGun", 0, 19, 44), ("sMotherBrainBrain", 0, 0, 0),
                                                          ("sMotherBrainEye", 0, 61, 29)]}),
    (35, "sRidleyHead", 0, (8, 14, 32), {}),
    # (Nightmare as its Draw makes it: its face always mirrored, the body and arms behind it as they're placed for its
    # facing, oMetNightmare's End Step; then all of it mirrored: looking right, the body's edge behind it showing that)
    (38, "sMetNightmareFaceA", 0, (-4, -44, 32), {"layers": [("sMetNightmareRightArm", 0, -27, -3, True),
                                                              ("sMetNightmareBody", 0, -43, -71, True),
                                                              ("sMetNightmareLeftArm", 0, 29, -37, True),
                                                              ("sMetNightmareFaceA", 0, -20, -50, True)], "flip": True}),
    (39, "sSandCrawlerBite", 0, (64, 24, 64), {}),
    (40, "sMalevHead", 0, (24, 20, 64), {}),
    (42, "sPT_StoneGolem_Idle", 0, (10, -4, 32), {}),
    (43, "sPT_FE_ArmsOut", 0, (16, 0, 32), {}),
    (44, "sHHG_Idle", 0, (-2, -3, 32), {}),
    (45, "sPT_Unforgotten", 0, (264, 32, 128), {}),
    (46, "sTOTO_Head", 0, (6, 6, 96), {}),
    (47, "sSeph_Idle", 0, (22, 2, 16), {}),
    (48, "sAntiAlpha_Idle", 0, (16, 2, 32), {}),
    (49, "sSeraIdle", 0, (1, -2, 32), {}),
    (50, "sBrainMachineMain", 0, (8, 0, 32), {}),
    (51, "sBBot_Idle", 0, (24, 6, 32), {}),
    (52, "sCACA_Body", 0, (128, 20, 96), {}),
    (53, "sGiantBlarg", 0, (32, 24, 64), {}),
    (54, "sDefective_Main", 0, None, {"special": "defective", "outline": (150, 40, 40)}),
    (55, "sShadowEura_Head", 0, (-10, -4, 64), {"layers": [("sShadowEura_Eye", 0, 25, 30), ("sShadowEura_Head", 0, 0, 0)]}),
    (56, "sDecimatorMain", 0, (-5, -10, 64), {}),
    (58, "sAbom_Base", 0, (66, 170, 64), {}),
    (59, "sHex_A_Hang", 0, (4, -1, 16), {"solid": True}),
    (61, "sAbom_ParasiteA", 0, (10, 14, 64), {}),
    (62, "sVirusPara_Open", 0, (64, 64, 96), {}),
    (60, "sWarmasterA_Idle", 0, (2, -2, 32), {}),
]
BOSS_ABOMINATION = 58
# the boss list's bosses the tracker leaves out, fought in their own places (rndgen.py's BOSS_FIXED) and not counted by
# the Randomizer's logic: Hexor (63), optional at the Distortion's dead end, and The Executive (64), whose fight needs
# nothing (roomlogic\bosses.txt)
BOSS_UNTRACKED = {63, 64}


def defective_head():
    """Defective, as the game draws it (oDefective: a black blob, wavering, with two rings of twelve thin forked arms
    going round it): its likeness at 32x32, drawn here, its sprites being too big and thin to scale down"""
    import math
    img = [[(0, 0, 0, 0)] * 32 for _ in range(32)]
    def dot(x, y):
        x, y = int(round(x)), int(round(y))
        if 0 <= x < 32 and 0 <= y < 32: img[y][x] = (10, 8, 12, 255)
    for y in range(32):
        for x in range(32):
            a = math.atan2(y - 15.5, x - 15.5)
            if math.hypot(x - 15.5, y - 15.5) <= 8.2 + 0.9 * math.sin(a * 5): img[y][x] = (10, 8, 12, 255)
    for i in range(12):
        a = math.radians(i * 30 + 8)
        for t in range(70):
            r = 8 + 7 * t / 69
            dot(15.5 + r * math.cos(a), 15.5 + r * math.sin(a))
        for side in (-1, 1):
            b = a + side * 0.6
            for t in range(16):
                r = 2.5 * t / 15
                dot(15.5 + 12 * math.cos(a) + r * math.cos(b), 15.5 + 12 * math.sin(a) + r * math.sin(b))
    return img


def final_nightmare_head(load):
    """Final Nightmare in its base form, eye open, as its Draw makes it (oFinalNightmare: phase 3): a black body (a circle,
    radius 12) with four black circles going round it (radius 7, 8 out: as at one moment of their turning), its eyes
    (sFNightmareEyes) covered by a black circle (radius 8), and the big eye open on it (sFNBigEye's last frame, 4
    lower). 32x32, full size"""
    import math
    img = [[(0, 0, 0, 0)] * 32 for _ in range(32)]
    cx, cy = 16, 15
    def disc(x0, y0, r):
        for y in range(32):
            for x in range(32):
                if (x + 0.5 - x0) ** 2 + (y + 0.5 - y0) ** 2 <= r * r: img[y][x] = (0, 0, 0, 255)
    def sprite(name, frame, ox, oy):
        w, h, rows = load(name, frame)
        for y in range(h):
            for x in range(w):
                q = rows[y][x * 4:x * 4 + 4]
                if q[3] and 0 <= ox + x < 32 and 0 <= oy + y < 32: img[oy + y][ox + x] = tuple(q)
    disc(cx, cy, 12)
    for i in range(4):
        a = math.radians(22 + i * 90)
        disc(cx + 8 * math.cos(a), cy - 8 * math.sin(a), 7)
    sprite("sFNightmareEyes", 0, cx - 8, cy - 8)
    disc(cx, cy, 8)
    sprite("sFNBigEye", 2, cx - 7, cy + 4 - 6)
    return img


def boss_icon(sprite, frame, crop, opts):
    """a boss's head: 32x32 RGBA rows (see BOSS_ICONS). opts: layers [(sprite, frame, x, y)] drawn in turn (each one's
    corner at x, y) in place of the sprite; tint, recolor (its light, as that colour), solid, outline; special"""
    sys.path.insert(0, os.path.dirname(HERE))
    import png
    def load(s, f):
        p = os.path.join(rndgen.PROJ, "sprites", s, "%d.png" % f)
        if not os.path.exists(p): raise SystemExit("tracker: the sprite %s has no frame %d" % (s, f))
        return png.read(p)
    if opts.get("special") == "defective":
        src = defective_head()
        cs = 32
    elif opts.get("special") == "finalnightmare":
        src = final_nightmare_head(load)
        cs = 32
    else:
        layers = opts.get("layers") or [(sprite, frame, 0, 0)]
        # (a layer's fifth value, if true: drawn mirrored, as with image_xscale -1; its corner is still its left edge)
        parts = [(load(l[0], l[1]), l[2], l[3], len(l) > 4 and l[4]) for l in layers]
        cx, cy, cs = crop
        tint, recolor, solid = opts.get("tint"), opts.get("recolor"), opts.get("solid")
        def px(x, y):
            out = (0, 0, 0, 0)
            for (w, h, rows), lx, ly, mirror in parts:
                if 0 <= x - lx < w and 0 <= y - ly < h:
                    c = (w - 1 - (x - lx)) if mirror else (x - lx)
                    q = rows[y - ly][c * 4:c * 4 + 4]
                    if q[3]: out = tuple(q)
            r, g, b, a = out
            if a and solid: a = 255
            if tint: r, g, b = r * tint[0] // 255, g * tint[1] // 255, b * tint[2] // 255
            if recolor:
                l = min(255, int((r * 0.3 + g * 0.59 + b * 0.11) * 1.25))
                r, g, b = l * recolor[0] // 255, l * recolor[1] // 255, l * recolor[2] // 255
            return (r, g, b, a)
        src = [[px(cx + x, cy + y) for x in range(cs)] for y in range(cs)]
    out = [[(0, 0, 0, 0)] * 32 for _ in range(32)]
    if cs <= 32 and 32 % cs == 0:
        k = 32 // cs
        for y in range(cs):
            for x in range(cs):
                for dy in range(k):
                    for dx in range(k): out[y * k + dy][x * k + dx] = src[y][x]
    elif cs < 32:
        # (a size between: each pixel of the icon takes the one under its middle)
        out = [[src[int((y + 0.5) * cs / 32)][int((x + 0.5) * cs / 32)] for x in range(32)] for y in range(32)]
    else:
        k = cs // 32
        if cs % 32: raise SystemExit("tracker: a boss head of size %d (up to 32, or 64, 96 or 128)" % cs)
        for y in range(32):
            for x in range(32):
                # (the block averaged, its colours by how opaque each pixel is)
                rs = gs = bs = at = 0
                for dy in range(k):
                    for dx in range(k):
                        r, g, b, a = src[y * k + dy][x * k + dx]
                        rs += r * a; gs += g * a; bs += b * a; at += a
                if at: out[y][x] = (rs // at, gs // at, bs // at, at // (k * k))
    if opts.get("silhouette"):
        # (a shape full of gaps, as a shape: what is mostly there made whole, the rest gone)
        out = [[(r, g, b, 255) if a >= 100 else (0, 0, 0, 0) for r, g, b, a in row] for row in out]
    if opts.get("flip"): out = [row[::-1] for row in out]
    outline = opts.get("outline")
    if outline:
        # (a pixel's outline: the empty ones beside an opaque one)
        o = [row[:] for row in out]
        for y in range(32):
            for x in range(32):
                if out[y][x][3]: continue
                if any(0 <= x + dx < 32 and 0 <= y + dy < 32 and out[y + dy][x + dx][3] > 128
                       for dx, dy in ((1, 0), (-1, 0), (0, 1), (0, -1))):
                    o[y][x] = tuple(outline) + (255,)
        out = o
    return [bytearray(v for p in row for v in p) for row in out]


def check_label(t):
    return "Boss Reward" if t == rndgen.INSTR_TYPE else rndgen.LT_LABEL[t]


def read_names(path=NAMES):
    """tracker_names.txt: {room: (tab, screen)}, {(type, objectNum): the check's own name}, the tabs in order"""
    rooms, checks, tabs = {}, {}, []
    labels = {l.lower(): c for c, l in rndgen.LT_LABEL.items()}
    labels["boss reward"] = rndgen.INSTR_TYPE
    if not os.path.exists(path): return rooms, checks, tabs
    for ln, line in enumerate(open(path, encoding="utf-8"), 1):
        line = line.strip()
        if not line or line.startswith("#"): continue
        if "=" not in line: raise SystemExit("tracker_names.txt line %d: no '='" % ln)
        left, right = [s.strip() for s in line.split("=", 1)]
        if left.lower().startswith("check "):
            m = re.match(r"(.+?)\s+(\d+)$", left[6:].strip())
            if not m or m.group(1).lower() not in labels:
                raise SystemExit("tracker_names.txt line %d: unknown check %r" % (ln, left[6:].strip()))
            checks[(labels[m.group(1).lower()], int(m.group(2)))] = right
            continue
        if "|" not in right: raise SystemExit("tracker_names.txt line %d: no '|' between the tab and the screen" % ln)
        tab, screen = [s.strip() for s in right.split("|", 1)]
        rooms[left] = (tab, screen)
        if tab not in tabs: tabs.append(tab)
    return rooms, checks, tabs


def positions(rows):
    """where each check is in its first room (its pickup's instance; a heart container the room's code makes: not
    known): {location: (x, y)}"""
    by_room = collections.defaultdict(list)
    for i, r in enumerate(rows): by_room[r["rooms"][0]].append(i)
    out = {}
    for room, ixs in by_room.items():
        want = {(rows[i]["type"], rows[i]["num"]): i for i in ixs}
        for obj, x, y, hexid, code in rndgen.instances(room) or []:
            t = rndgen.LT_BY_OBJ.get(obj)
            if t is None: continue
            n = 1 if t in (15, 16, 17) else rndgen.num(code, "objectNum")
            i = want.get((t, n))
            if i is not None and i not in out: out[i] = (x, y)
    return out


def ordinal(n):
    return "%d%s" % (n, "th" if 10 <= n % 100 <= 20 else {1: "st", 2: "nd", 3: "rd"}.get(n % 10, "th"))


def hints(ixs, pos, rows):
    """several checks of one type in one screen, told apart by where they are: {location: hint}"""
    if any(i not in pos for i in ixs) or len({rows[i]["rooms"][0] for i in ixs}) > 1:
        return {i: "#%d" % (k + 1) for k, i in enumerate(sorted(ixs, key=lambda i: rows[i]["num"]))}
    xs = [pos[i][0] for i in ixs]
    ys = [pos[i][1] for i in ixs]
    horiz = max(xs) - min(xs) >= max(ys) - min(ys)
    order = sorted(ixs, key=(lambda i: (pos[i][0], pos[i][1])) if horiz else (lambda i: (pos[i][1], pos[i][0])))
    n = len(order)
    if n == 2: words = ["left", "right"] if horiz else ["top", "bottom"]
    elif n == 3: words = ["left", "middle", "right"] if horiz else ["top", "middle", "bottom"]
    else: words = ["%s from the %s" % (ordinal(k + 1), "left" if horiz else "top") for k in range(n)]
    return {i: w for i, w in zip(order, words)}


def logic_tables(f):
    """the room logic's tables (erflat.export's), as the pages' reach uses them: pairs (first, count) flat"""
    def pairs(lst):
        out = []
        for a, b in lst: out += [a, b]
        return out
    return {
        "gN": [len(v) for v in f.gvals], "gmult": f.gmult, "scoped": f.scoped, "gsN": f.gs_n, "startGs": f.start_gs,
        "start": f.start, "EV": f.EV_BASE, "KB": f.KEY_BASE,
        "rooms": f.rnames, "roomArea": f.room_area, "roomScope": f.room_scope, "roomCarried": f.room_carried,
        "roomResets": [[x for gv in rs for x in gv] for rs in f.room_resets], "roomBoss": pairs(f.room_boss),
        "entryRoom": [ri for ri, inid in f.entries], "entryWays": pairs(f.entry_ways),
        "waySt": f.way_st, "wayRows": pairs(f.way_rows),
        "rowKind": f.row_kind, "rowTarget": f.row_target, "rowLeave": f.row_leave, "rowAlts": pairs(f.row_alts),
        "altFirst": f.alt_first, "altCount": f.alt_count, "reqIx": f.req_ix, "reqC": f.req_c,
        "exitDest": f.exit_dest, "exitSg": f.exit_sg, "exitSdest": f.exit_sdest, "exitExtra": pairs(f.exit_extra),
        "exitEnd": f.exit_end_own, "exitFollow": f.exit_follow, "endBack": [e["back"] for e in f.ends],
        "evWays": [[x for kind, what, (af, ac), mode in ways for x in (kind, what, af, ac, mode)] for ways in f.ev_ways],
        "evNames": f.evnames,
        "bossN": f.boss_n, "bossReq": pairs(f.boss_req), "roomSlot": f.room_slot, "exitSlot": f.exit_slot,
        "roomGate": f.room_gate, "chipBase": f.CHIP_BASE,
    }


def icon(out, ident, pic, done):
    """an item's picture (a sprite's frame, its opaque part, tinted as image_blend does) to tracker\\icons\\<id>.png:
    {src, w, h}"""
    sys.path.insert(0, os.path.dirname(HERE))
    import png
    sprite, frame, tint = pic
    key = (sprite, frame, tint)
    if key in done: return done[key]
    p = os.path.join(rndgen.PROJ, "sprites", sprite, "%d.png" % frame)
    if not os.path.exists(p): raise SystemExit("tracker: the sprite %s has no frame %d" % (sprite, frame))
    w, h, rows = png.read(p)
    xs = [x for y in range(h) for x in range(w) if rows[y][x * 4 + 3]]
    ys = [y for y in range(h) for x in range(w) if rows[y][x * 4 + 3]]
    if not xs: raise SystemExit("tracker: the sprite %s's frame %d is empty" % (sprite, frame))
    l, t, r, b = min(xs), min(ys), max(xs), max(ys)
    crop = []
    for y in range(t, b + 1):
        line = bytearray(rows[y][l * 4:(r + 1) * 4])
        if tint:
            for x in range(0, len(line), 4):
                for c in range(3): line[x + c] = line[x + c] * tint[c] // 255
        crop.append(line)
    os.makedirs(os.path.join(out, "tracker", "icons"), exist_ok=True)
    name = "%s.png" % ident
    png.write(os.path.join(out, "tracker", "icons", name), r - l + 1, b - t + 1, crop)
    done[key] = {"src": "icons/" + name, "w": r - l + 1, "h": b - t + 1}
    return done[key]


def build(out, rows, items, f, bp, hv, door_order, blist, anames, rarea, rooms, build_id):
    """the pages' data (out\\tracker\\data.js) and pictures (out\\tracker\\icons)"""
    names, check_names, tab_order = read_names()
    # ---- checks: tabs, screens, names
    tabs = [{"name": t, "screens": []} for t in tab_order]
    tab_ix = {t: i for i, t in enumerate(tab_order)}
    screen_ix = {}
    unnamed = []
    for i, r in enumerate(rows):
        room = r["rooms"][0]
        if room in names: tab, scr = names[room]
        else:
            # (a room the names file doesn't have: under its area's name)
            a = rarea.get(room)
            tab, scr = "Other", "%s (%s)" % (anames.get(a, "?"), room)
            unnamed.append(room)
            if tab not in tab_ix: tab_ix[tab] = len(tabs); tabs.append({"name": tab, "screens": []})
        k = (tab, scr)
        if k not in screen_ix:
            screen_ix[k] = len(tabs[tab_ix[tab]]["screens"])
            tabs[tab_ix[tab]]["screens"].append({"name": scr, "rooms": [], "checks": []})
        s = tabs[tab_ix[tab]]["screens"][screen_ix[k]]
        # (with the other rooms the same pickup is in, e.g. Forest Palace 4's 4a and 4b: standing there shows this screen)
        for rm in r["rooms"]:
            if rm not in s["rooms"]: s["rooms"].append(rm)
        s["checks"].append(i)
    # (screens in the names file's order: the order their rooms are listed in)
    order = {room: n for n, room in enumerate(names)}
    for t in tabs:
        t["screens"].sort(key=lambda s: min(order.get(rm, 1 << 20) for rm in s["rooms"]))
    tabs = [t for t in tabs if t["screens"]]
    pos = positions(rows)
    loc_name = {}
    for t in tabs:
        for s in t["screens"]:
            s["checks"].sort(key=lambda i: (rows[i]["type"], pos.get(i, (0, 0))[0], pos.get(i, (0, 0))[1], rows[i]["num"]))
            by_label = collections.defaultdict(list)
            for i in s["checks"]: by_label[check_label(rows[i]["type"])].append(i)
            for label, ixs in by_label.items():
                hs = hints(ixs, pos, rows) if len(ixs) > 1 else {}
                for i in ixs: loc_name[i] = label + (" (%s)" % hs[i] if i in hs else "")
    for i, r in enumerate(rows):
        if (r["type"], r["num"]) in check_names: loc_name[i] = check_names[(r["type"], r["num"])]
        elif r["type"] == rndgen.STORY_TYPE: loc_name[i] = "Story Item (%s)" % r["story"]
    # ---- each check's rule
    gate_ev = {}
    for v, n in enumerate(f.evnames):
        m = re.match(r"gate([A-H])$", n)
        if m: gate_ev[m.group(1)] = v
    bidx = {t: i for i, (t, room, bx, by, name) in enumerate(blist)}
    locs = []
    for i, r in enumerate(rows):
        loc = {"n": loc_name[i], "id": "%s %d" % (rndgen.LT_LABEL[r["type"]], r["num"]), "room": r["rooms"][0]}
        if r["type"] == rndgen.INSTR_TYPE:
            loc["rule"], loc["ev"], loc["gate"] = RULE_GATE, gate_ev["ABCDEFGH"[r["num"] - 1]], r["num"]
        elif r["req"] is not rndgen.EVERYTHING:
            loc["rule"] = RULE_PLACE
        elif r["type"] == 14 and r["num"] in rndgen.HC_BOSS and i in bp:
            loc["rule"], loc["slot"] = RULE_BOSS_HEART, bidx[rndgen.HC_BOSS[r["num"]]]
        else:
            loc["rule"] = RULE_EVERYTHING
        locs.append(loc)
    # ---- the rooms' tabs (the player's room: the tab to show when following them; a room with checks: its screen)
    area_tabs = collections.defaultdict(collections.Counter)
    for t_i, t in enumerate(tabs):
        for s_i, s in enumerate(t["screens"]):
            for room in s["rooms"]:
                if rarea.get(room) is not None: area_tabs[rarea[room]][t_i] += 1
    room_tab, room_screen = {}, {}
    for room in rooms:
        a = rarea.get(room)
        if a in area_tabs: room_tab[room] = area_tabs[a].most_common(1)[0][0]
    for t_i, t in enumerate(tabs):
        for s_i, s in enumerate(t["screens"]):
            for room in s["rooms"]:
                room_tab[room] = t_i; room_screen[room] = [t_i, s_i]
    # (every room's name, for where the player is when it has no checks: its screen's in the names file, else its area's)
    room_name = {}
    for room in rooms:
        if room in names: room_name[room] = names[room][1]
        elif anames.get(rarea.get(room)): room_name[room] = anames[rarea[room]]
    # ---- the Item Tracker
    pool = collections.Counter(k for k, p in items)
    done = {}
    groups = []
    for gname, lst in ITEM_GROUPS:
        g = {"name": gname, "items": []}
        for ident, name, have, pic in lst:
            g["items"].append({"id": ident, "name": name, "have": list(have), "icon": icon(out, ident, pic, done)})
        groups.append(g)
    counters = []
    for ident, name, have, kind, pic in COUNTERS:
        counters.append({"id": ident, "name": name, "have": list(have), "total": pool[kind] + SHOP_EXTRA.get(kind, 0),
                         "icon": icon(out, ident, pic, done)})
    # ---- the bosses: their heads, in the boss gallery's order (the Warmaster last), each with its place in the boss
    # list (-1: the Abomination, beaten when gateHProg is 200)
    sys.path.insert(0, os.path.dirname(HERE))
    import png
    bslot = {t: i for i, (t, room, bx, by, name) in enumerate(blist)}
    types = [b[0] for b in BOSS_ICONS]
    want = (set(bslot) - BOSS_UNTRACKED) | {BOSS_ABOMINATION}
    if sorted(types) != sorted(want):
        raise SystemExit("tracker: BOSS_ICONS has the bosses %s; the boss list (less BOSS_UNTRACKED) and the Abomination "
                         "are %s" % (sorted(types), sorted(want)))
    os.makedirs(os.path.join(out, "tracker", "icons"), exist_ok=True)
    bosses = []
    for t, spr, fr, crop, opts in BOSS_ICONS:
        name = "boss%d.png" % t
        png.write(os.path.join(out, "tracker", "icons", name), 32, 32, boss_icon(spr, fr, crop, opts))
        bosses.append({"src": "icons/" + name, "slot": bslot.get(t, -1)})
    # ---- every progression item (the 'everything' rule): the logic's, the instruments only with Instrument
    # Randomization
    every = sorted((ix, n) for ix, n in hv.items() if ix != rndgen.INSTR_IX)
    data = {
        "build": build_id,
        "tabs": tabs, "locs": locs, "roomTab": room_tab, "roomScreen": room_screen, "roomName": room_name,
        "doors": door_order, "everything": every, "everythingIR": [[rndgen.INSTR_IX, hv.get(rndgen.INSTR_IX, 8)]],
        "items": groups, "counters": counters, "bosses": bosses,
        "logic": logic_tables(f),
    }
    os.makedirs(os.path.join(out, "tracker"), exist_ok=True)
    with open(os.path.join(out, "tracker", "data.js"), "w", encoding="utf-8", newline="\n") as fh:
        fh.write("// the DT3+ Randomizer trackers' data, made by tools/modkit/randomizer/rndgen.py (tracker.py) for this build\n")
        fh.write("window.DT3_DATA=" + json.dumps(data, separators=(",", ":")) + ";\n")
    n_screens = sum(len(t["screens"]) for t in tabs)
    print("trackers: %d checks in %d tabs, %d screens; %d items, %d counters, %d bosses (tracker\\checks.html, tracker\\items.html)"
          % (len(rows), len(tabs), n_screens, sum(len(g["items"]) for g in groups), len(counters), len(bosses)))
    if unnamed:
        print("trackers: rooms with checks not in tracker_names.txt (shown under 'Other'):", ", ".join(sorted(set(unnamed))))
