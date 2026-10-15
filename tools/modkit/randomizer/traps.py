"""
traps.py: the game's enemy traps (kill rooms) in the Randomizer. In the story a trap shuts the player in with barriers
till they've beaten its enemies: a block of a chapter's event object (oEvCh10MainA and the like) that runs at one point
of the story. Past the story, in the world the Randomizer starts in, they don't happen. Each trap here happens once in
a Randomizer game: the game's own code for it, run by a mod object of its own (oRndTrap<n>, made in its room by the
roomStart hook while it isn't beaten), changed so that
  - it starts only with the player inside its arena (between its barriers: TRAPS' box where they don't say), and no other
    trap of the room going (the game's enemy counter and barriers are one of each);
  - it ends by marking it beaten (global.rndTrapDone, kept in the save) as its barriers go, not by moving the story on;
  - the story's own parts are left out: its flags (gameProgress, the gates' progress strings), tutorials, checkpoints,
    abilities it gives.
In the room logic its barriers are walls that open with what beats its enemies (roomdata.py: roomlogic's "G" gates), so
the logic never takes the player into a trap they can't win.

What beats a trap's enemies: for each kind of enemy it makes, an attack of a damage type it takes (its resType for the
type isn't 1, 0x: the player's weapons of each type as roomlogic\\bosses.txt lists them; in Gate 6 its own sets too), or
the Mario Ability Set for the ones Mario stomps (oEMarioBase's children); every kind of them. A trap's own line can say
otherwise (req).

The traps the game has that aren't here: story scenes more than fights (Chao found in the Vault, the War Room, the
lava rising in Gate 5's Norfair, Storm Eagle's canister bridge, the Gravity Suit and Air Dash rooms, the Diffusion
Missile, Mountain Temple C's knights, the Displaced Construction Site's runes), the CHAOS Warship's fights the story
plays with its party split (oPlayerIdle), the Hammer Bros of Stratum Steppe (the Mario Ability Set's lesson), the
Metroid rooms (the Metroids are gone past the story), King Worm's map (it waits for every enemy of the room), the
Nightmare Gates' (the game runs them every time), Bubble Tower B (shut in the Randomizer).
"""
import os, re, collections
import rndgen

PROJ = rndgen.PROJ
OBJ_DIR = os.path.join(PROJ, "objects")
BARRIER_SPRITE = "sInvisibleSolidMask"      # (oEnemyBarrier's mask: 16x16)

# the traps: (id, the game's object, a text of its block's condition (the block in its Step), options):
#   inner    the condition text of the block inside it that is the trap (the rest is left to the game)
#   trigger  the barriers made by the n-th place that makes barriers (default 0): a block with two traps
#   start    the scene step it starts at (sceneProgress: the second trap of such a block)
#   box      the arena (x1, y1, x2, y2: where the player is, their feet), where its barriers alone don't say
#   enemies  the kinds of enemy it waits for, where it waits for ones the room has (or a block of two traps)
#   req      what beats it, in the room logic's words (link:1|belmont:1...), where the enemies' resistances don't say
#   off      (variable, value) set on the room's event object: the game's own copy of the trap kept from running, for
#            one the game would still run in the Randomizer's world (its flag is something the Randomizer changes)
#   drop     more statements to leave out (regexes)
TRAPS = [
    # ---- the Vault (oEvCh10MainA)
    ("rVault_2a", "oEvCh10MainA", "gameProgress=2180 and room=rVault_2", {}),
    ("rVault_3", "oEvCh10MainA", "gameProgress=2200 and room=rVault_3", {}),
    ("rVault_2b", "oEvCh10MainA", "gameProgress=2230 and room=rVault_2", {}),
    ("rVault_8a", "oEvCh10MainA", "gameProgress=2330 and room=rVault_8", {}),
    ("rVault_8b", "oEvCh10MainA", "gameProgress=2340 and room=rVault_8", {}),
    ("rVault_8c", "oEvCh10MainA", "gameProgress=2350 and room=rVault_8", {}),
    # (the story's no-dashing stretch: left out)
    ("rVault_9", "oEvCh10MainA", "gameProgress=2370 and room=rVault_9", {"drop": [r"oPlayer1\.dashEnergy\s*="]}),
    ("rVault_10", "oEvCh10MainA", "gameProgress=2390 and room=rVault_10", {}),
    ("rVault_18", "oEvCh10MainA", "gameProgress=2500 and room=rVault_18", {}),
    # ---- Gate 5 (oEvCh13MainA)
    ("rSamus5_Lv2_F", "oEvCh13MainA", "gameProgress=2760 and room=rSamus5_Lv2_F", {}),
    ("rSamus5_Lv2_K", "oEvCh13MainA", "gameProgress=2770 and room=rSamus5_Lv2_K", {}),
    ("rSamus5_Lv1_S", "oEvCh13MainA", "room=rSamus5_Lv1_S", {"inner": 'gateKraid="1"'}),
    ("rSamus5_Lv2_U", "oEvCh13MainA", "room=rSamus5_Lv2_U", {"inner": 'gateArachnus="0"'}),
    # ---- Neo Grime City (oEvCh14MainA)
    ("rNGC_A", "oEvCh14MainA", "gameProgress=3120 and room=rNGC_A", {}),
    ("rNGC_B", "oEvCh14MainA", "gameProgress=3140 and room=rNGC_B", {}),
    ("rNGC_LC_G", "oEvCh14MainA", "gameProgress=3270 and room=rNGC_LC_G", {}),
    ("rNGC_LC_H", "oEvCh14MainA", "gameProgress=3280 and room=rNGC_LC_H", {}),
    ("rNGC_BR_A", "oEvCh14MainA", "gameProgress=3320 and room=rNGC_BR_A", {}),
    # ---- Gate 6 (oEvCh15MainA, oEvCh15Dream, oEvCh15SideA: the last's flag is the Game Power string, which the
    # Randomizer fills in its own order)
    ("rGame6_HeroPlainsF", "oEvCh15MainA", "gameProgress=3440 and room=rGame6_HeroPlainsF", {}),
    ("rGame6_EarthG", "oEvCh15MainA", "gameProgress=3460 and room=rGame6_EarthG", {}),
    ("rGame6_WindC", "oEvCh15MainA", "gameProgress=3600 and room=rGame6_WindC", {}),
    ("rGame6_WindF", "oEvCh15MainA", "gameProgress=3610 and room=rGame6_WindF", {}),
    ("rGame6_DreamWoodsB", "oEvCh15Dream", "gameProgress=3680 and room=rGame6_DreamWoodsB", {}),
    ("rGame6_DreamWoodsCa", "oEvCh15Dream", "gameProgress=3690 and room=rGame6_DreamWoodsC", {}),
    ("rGame6_DreamWoodsCb", "oEvCh15Dream", "gameProgress=3710 and room=rGame6_DreamWoodsC", {}),
    ("rGame6_DreamWoodsD", "oEvCh15Dream", "gameProgress=3730 and room=rGame6_DreamWoodsD", {}),
    ("rGame6_ParaIslandD", "oEvCh15SideA", "room=rGame6_ParaIslandD", {"inner": 'indexCheck="0"', "off": ("indexCheck", '"1"')}),
    ("rGame6_WaterCaveA", "oEvCh15SideA", "room=rGame6_WaterCaveA", {"inner": 'indexCheck="0"', "off": ("indexCheck", '"1"')}),
    ("rGame6_WaterCaveD", "oEvCh15SideA", "room=rGame6_WaterCaveD", {"inner": 'indexCheck="0"', "off": ("indexCheck", '"1"')}),
    # ---- the Hidden Program Facility (oEvCh17MainA): two arenas one after the other
    ("rHPF_Ga", "oEvCh17MainA", "gameProgress=4140 and room=rHPF_G", {"enemies": ["oBloodTyrant"]}),
    ("rHPF_Gb", "oEvCh17MainA", "gameProgress=4140 and room=rHPF_G", {"trigger": 1, "start": 2, "enemies": ["oMalignantOoze"]}),
    # ---- Starry Skies and the CHAOS Weapons Facility (oEvCh18MainA). Windy Hills' ambush: one barrier over the
    # player's way up, its Rocketeers below. Fierce Skies' tanks: the game runs them every time (no flag)
    ("rMain_62", "oEvCh18MainA", "gameProgress=4230 and room=rMain_62", {"box": (0, 744, 896, 1216)}),
    ("rMain_68", "oEvCh18MainA", "room=rMain_68", {"off": ("tankEvent", "2")}),
    ("rLowFacC", "oEvCh18MainA", "gameProgress=4351 and room=rLowFacC", {}),
    ("rLowFacH", "oEvCh18MainA", "gameProgress=4400 and room=rLowFacH", {}),
    # (its Drone's sign, an instance of the room's the code names: left out)
    ("rLowFacJ", "oEvCh18MainA", "gameProgress=4420 and room=rLowFacJ", {"drop": [r"tNewMessage", r"\(GID\(378907\)\)"]}),
    ("rLowFacM", "oEvCh18MainA", "gameProgress=4430 and room=rLowFacM", {"enemies": ["oCHAOS_Rocketeer"]}),
    # ---- the CHAOS Warship (oEvCh20MainA)
    ("rWarshipB", "oEvCh20MainA", "gameProgress=5080 and room=rWarshipB", {}),
    ("rWarshipZ_C", "oEvCh20MainA", "gameProgress=5290 and room=rWarshipZ_C", {}),
    # ---- the Mushroom Kingdom (oEvCh2MainA)
    ("rMario1_3", "oEvCh2MainA", "gameProgress=190 and room=rMario1_3", {}),
    ("rMario1_HFc", "oEvCh2MainA", "gameProgress=380 and room=rMario1_HFc", {}),
    # ---- Greatest Stretch (oEvCh3MainA): the story's answer is the dive birds (they hit the enemies for Jerry)
    ("rMain_8", "oEvCh3MainA", "gameProgress=530 and room=rMain_8", {"req": "-"}),
    # ---- Hyrule (oEvCh4MainA)
    ("rLink2_PalaceF_9", "oEvCh4MainA", "gameProgress=730 and room=rLink2_PalaceF_9", {}),
    ("rLink2_PalaceW_11a", "oEvCh4MainA", "gameProgress=840 and room=rLink2_PalaceW_11", {}),
    ("rLink2_PalaceW_11b", "oEvCh4MainA", "gameProgress=850 and room=rLink2_PalaceW_11", {}),
    # ---- Transylvania (oEvCh6MainA)
    ("rBelmont3_1B", "oEvCh6MainA", "gameProgress=1170 and room=rBelmont3_1B", {}),
    ("rBelmont3_2D", "oEvCh6MainA", "gameProgress=1210 and room=rBelmont3_2D", {}),
    ("rBelmont3_4E", "oEvCh6MainA", "room=rBelmont3_4E", {"inner": 'gameProgCheck="0"'}),
    ("rBelmont3_4I", "oEvCh6MainA", "room=rBelmont3_4I", {"inner": 'gameProgCheck="0"'}),
    ("rBelmont3_7F", "oEvCh6MainA", "gameProgress=1500 and room=rBelmont3_7F", {}),
    # ---- the Mountain Temple (oEvCh7MainA)
    ("rMountTemple_D", "oEvCh7MainA", "gameProgress=1630 and room=rMountTemple_D", {}),
    ("rMountTemple_H", "oEvCh7MainA", "gameProgress=1670 and room=rMountTemple_H", {}),
    # ---- Megapolis, Sigma's Fortress (oEvCh8MainB)
    ("rMega4_SigmaA2", "oEvCh8MainB", "gameProgress=1870 and room=rMega4_SigmaA2", {}),
    ("rMega4_SigmaA4", "oEvCh8MainB", "gameProgress=1880 and room=rMega4_SigmaA4", {}),
    ("rMega4_SigmaB2", "oEvCh8MainB", "gameProgress=1900 and room=rMega4_SigmaB2", {}),
    ("rMega4_SigmaC3", "oEvCh8MainB", "gameProgress=1960 and room=rMega4_SigmaC3", {}),
    ("rMega4_SigmaC4", "oEvCh8MainB", "gameProgress=1970 and room=rMega4_SigmaC4", {}),
]

# the player's weapons by damage type (resType's places: NORMAL, PIERCE, ELEMENTAL, SHOT, EXPLOSION, SPECIAL), as
# roomlogic\bosses.txt has them; and Gate 6's own sets, which work only there (area 58)
WEAPONS = {0: ["link:1", "belmont:1"], 1: ["link:2", "belmont:2"], 2: ["belmont:3", "megaman:2"],
           3: ["megaman:1", "samus:1"], 4: ["link:3", "samus:6"], 5: ["megaman:3", "samus:4"]}
GATE6_WEAPONS = {0: ["gamec:1"], 1: ["gamec:2"], 3: ["gamej:1"], 4: ["gamej:2"], 5: ["gamej:2"]}
GATE6_AREA = 58
# (GameMaker's own variables and words: not the code's own)
BUILTINS = {"x", "y", "i", "depth", "visible", "solid", "persistent", "sprite_index", "image_index", "image_speed",
            "image_xscale", "image_yscale", "image_angle", "image_alpha", "image_blend", "mask_index", "speed",
            "direction", "gravity", "hspeed", "vspeed", "friction", "room", "other", "self", "noone", "all", "global",
            "true", "false", "pi", "c_black", "c_white", "c_red", "c_dkgray", "c_gray", "trapId", "gDeltaTime",
            "gDeltaDoTicks", "newMessage", "newEnemy", "view_xview", "view_yview", "view_wview", "view_hview",
            "view_object", "fa_center", "fa_left", "fa_right", "fa_middle"}
KEYWORDS = {"if", "else", "and", "or", "not", "with", "for", "while", "do", "until", "repeat", "var", "exit", "break",
            "continue", "return", "switch", "case", "default", "div", "mod", "xor", "then", "begin", "end"}
# the statements of the story left out of every trap (regexes of a statement's start)
STORY = [r"global\.gameProgress\s*=(?!=)", r"global\.gameGate\d?\w*Prog\s*=(?!=)", r"tNewString\b",
         r"global\.(hasShoes|hasAbilToken|canDoubleJump|metCheckpoint|newMapX|newMapY)\b[^=]*=(?!=)",
         r"tNewTutorial\b", r"instance_create\([^)]*o(TutorialPanel|CheckpointNotice|MetroidCheckpoint)\)",
         r"(gateKraid|gateArachnus|gateKingWorm|gameProgCheck)\s*=(?!=)",
         # (the story's scenes after a fight: never reached, as the trap ends with its barriers; left out all the same)
         r"msgCreate\([^\n]*oMessageCutscene", r"scenePChk\(", r"global\.gamePaused\s*=\s*true"]


# ---------------------------------------------------------------- the game's code
def match_brace(s, i):
    """s[i] == '{': the index after its matching '}' (strings and comments skipped)"""
    depth, n = 0, len(s)
    while i < n:
        c = s[i]
        if c in "\"'":
            j = s.find(c, i + 1); i = (j if j >= 0 else n) + 1; continue
        if s.startswith("//", i):
            j = s.find("\n", i); i = j if j >= 0 else n; continue
        if s.startswith("/*", i):
            j = s.find("*/", i + 2); i = (j + 2) if j >= 0 else n; continue
        if c == "{": depth += 1
        elif c == "}":
            depth -= 1
            if depth == 0: return i + 1
        i += 1
    raise SystemExit("traps: unbalanced braces")


def if_blocks(code):
    """every if with a braced body: (start, the header's condition (no comment), its start and end, the body's start
    and end)"""
    out = []
    for m in re.finditer(r"^[ \t]*(?:else\s+)?if\b[ \t]*([^{\n]*?)[ \t]*(?=\{|//|$)", code, flags=re.M):
        k = m.end()
        while k < len(code):
            if code.startswith("//", k):
                e = code.find("\n", k); k = e if e >= 0 else len(code); continue
            if code[k] in " \t\r\n": k += 1; continue
            break
        if k < len(code) and code[k] == "{":
            out.append((m.start(), m.group(1), m.start(1), m.end(1), k, match_brace(code, k)))
    return out


def block(obj, cond):
    """the body (braces and all) of the block of the object's Step whose condition has the text"""
    code = rndgen.vanilla_event(obj, "Step_0")
    # (the one that raises barriers: the condition can be elsewhere too, the story's skipped scenes)
    found = [b for b in if_blocks(code) if cond in b[1] and re.search(r"oEnemyBarrier\)|oEventBarrier\.y", code[b[4]:b[5]])]
    if len(found) != 1: raise SystemExit("traps: %s's Step has %d blocks with %r" % (obj, len(found), cond))
    b = found[0]
    return code[b[4]:b[5]]


def inner(body, cond):
    found = [b for b in if_blocks(body) if cond in b[1]]
    if not found: raise SystemExit("traps: no inner block with %r" % cond)
    b = min(found, key=lambda b: b[0])
    return body[b[4]:b[5]]


def drop_statements(code, pat):
    """the statements starting with the pattern (after a line's start, '{' or ';') made an empty block: '{}' (so an if
    without braces keeps a body); a with (...) {...} statement whole"""
    def with_block(m):
        return m.group(1) + m.group(2) + "{}"
    code = re.sub(r"(^|[{;])([ \t]*)with\s*\(?\s*[^)\n]*%s[^)\n]*\)?\s*\{[^{}]*\}" % pat, with_block, code, flags=re.M)
    return re.sub(r"(^|[{;])([ \t]*)(?:%s)[^;\n}]*" % pat, lambda m: m.group(1) + m.group(2) + "{}", code, flags=re.M)


def chain(obj):
    """the object and its parents"""
    out = []
    while obj and obj not in out:
        out.append(obj)
        p = os.path.join(OBJ_DIR, obj + ".txt")
        if not os.path.exists(p): break
        m = re.search(r"^parent=(\w*)", rndgen.read(p), re.M)
        obj = m.group(1) if m else ""
    return out


def is_enemy(obj):
    return "oEnemyBase" in chain(obj)


def res_types(obj):
    """an enemy's resType for each damage type (1 0x, 2 0.5x, 3 1x, 4 2x, 5 3x), its parents' first"""
    r = {i: 3 for i in range(6)}
    for o in reversed(chain(obj)):
        try:
            code = rndgen.vanilla_event(o, "Create_0")
        except SystemExit:
            continue
        for i, v in re.findall(r"\bresType\[(\d)\]\s*=\s*(\d+)", code): r[int(i)] = int(v)
        m = re.search(r"for\s*\(\s*i\s*=\s*0\s*;\s*i\s*<\s*6\s*;[^)]*\)\s*\{?\s*resType\[i\]\s*=\s*(\d+)", code)
        if m:
            for i in range(6): r[i] = int(m.group(1))
    return r


# ---------------------------------------------------------------- one trap
class Trap:
    pass


def barriers_in(code, room):
    """the places in the code that make barriers, in order: [(where in the code, [(x, y, xscale, yscale, angle)])]:
    oEnemyBarrier made (its scales and angle set after it), or the room's oEventBarriers slid in (y+=n: where they're
    placed in the room, which their own code moves n up)"""
    groups = []
    made = list(re.finditer(r"(\w+)\s*=\s*instance_create\(\s*(-?\d+)\s*,\s*(-?\d+)\s*,\s*oEnemyBarrier\s*\)", code))
    for k, m in enumerate(made):
        var, x, y = m.group(1), int(m.group(2)), int(m.group(3))
        end = made[k + 1].start() if k + 1 < len(made) else len(code)
        tail = code[m.end():end]
        def prop(p, d):
            mm = re.search(r"\b%s\.%s\s*=\s*(-?[\d.]+)" % (var, p), tail)
            return float(mm.group(1)) if mm else d
        groups.append((m.start(), (x, y, prop("image_xscale", 1), prop("image_yscale", 1), prop("image_angle", 0))))
    for m in re.finditer(r"oEventBarrier\.y\s*\+=\s*(\d+)", code):
        for obj, x, y, hexid, icode in rndgen.instances(room) or []:
            if obj != "oEventBarrier": continue
            ys = re.search(r"image_yscale\s*=\s*([\d.]+)", icode)
            xs = re.search(r"image_xscale\s*=\s*([\d.]+)", icode)
            groups.append((m.start(), (x, y, float(xs.group(1)) if xs else 1, float(ys.group(1)) if ys else 1, 0)))
    return groups


def rect(b):
    """a barrier's rectangle (x1, y1, x2, y2), its mask 16x16 from its corner, turned by its angle as GameMaker does"""
    x, y, xs, ys, ang = b
    a = int(ang) % 360
    if a == 0: return (x, y, x + 16 * xs, y + 16 * ys)
    if a == 90: return (x, y - 16 * xs, x + 16 * ys, y)
    if a == 270: return (x - 16 * ys, y, x, y + 16 * xs)
    if a == 180: return (x - 16 * xs, y - 16 * ys, x, y)
    raise SystemExit("traps: a barrier at angle %s" % ang)


def arena(bars):
    """where the player is inside the arena (their feet): between its upright barriers (and a little above and below
    them), or between its lying ones; far enough from each that a barrier made there isn't in the player's body (16px
    from an upright one, the body's half width and more; 40px under a lying one above, the body's height)"""
    up = [rect(b) for b in bars if int(b[4]) % 180 == 0]
    lying = [rect(b) for b in bars if int(b[4]) % 180 == 90]
    if len(up) >= 2:
        up.sort()
        return (up[0][2] + 16, min(r[1] for r in up) - 48, up[-1][0] - 16, max(r[3] for r in up) + 96)
    if len(lying) >= 2:
        lying.sort(key=lambda r: r[1])
        return (min(r[0] for r in lying) - 48, lying[0][3] + 40, max(r[2] for r in lying) + 48, lying[-1][1] - 4)
    return None


def requirement(enemies, area):
    """what beats them all: alternatives (each {set: level}), the fewest"""
    weapons = {t: list(WEAPONS.get(t, [])) + (GATE6_WEAPONS.get(t, []) if area == GATE6_AREA else []) for t in range(6)}
    alts = [{}]
    for e in sorted(set(enemies)):
        rt = res_types(e)
        atoms = set()
        for t in range(6):
            if rt[t] != 1:
                atoms.update(weapons[t])
        if "oEMarioBase" in chain(e): atoms.add("mario")
        if not atoms: raise SystemExit("traps: nothing hurts %s" % e)
        new = []
        for a in alts:
            for at in atoms:
                s, _, l = at.partition(":")
                b = dict(a); b[s] = max(b.get(s, 0), int(l or 1))
                new.append(b)
        # (the fewest: one that needs all another needs, and more, is left out)
        new.sort(key=lambda d: (len(d), sorted(d.items())))
        alts = []
        for d in new:
            if not any(all(d.get(s, 0) >= l for s, l in o.items()) for o in alts): alts.append(d)
    return alts


def req_words(alts):
    return "|".join(",".join(s if s == "mario" else "%s:%d" % (s, l) for s, l in sorted(a.items())) for a in alts)


def make(ident, obj, cond, opts):
    t = Trap()
    t.id, t.obj, t.opts = ident, obj, opts
    t.room = re.search(r"room=(\w+)", cond).group(1)
    body = block(obj, cond)
    if "inner" in opts: body = inner(body, opts["inner"])
    code = body[1:-1]      # (the code inside the braces)
    # the barriers: the trap's (its trigger's) and every one the code makes
    groups = barriers_in(code, t.room)
    if not groups: raise SystemExit("traps: %s makes no barriers" % ident)
    blocks = if_blocks(code)
    # (each place's trigger: the innermost if around it that names the player; the trap's: the trigger-th of them)
    trigs = []
    for pos in sorted({g[0] for g in groups}):
        around = [b for b in blocks if b[4] < pos < b[5] and "oPlayer1" in b[1]]
        if not around: raise SystemExit("traps: %s: no if about the player around its barriers" % ident)
        tb = max(around, key=lambda b: b[4])
        if tb not in trigs: trigs.append(tb)
    k = opts.get("trigger", 0)
    if k >= len(trigs): raise SystemExit("traps: %s: no trigger %d" % (ident, k))
    trig = trigs[k]
    t.bars = [g[1] for g in groups if trig[4] < g[0] < trig[5]]
    t.box = opts.get("box") or arena(t.bars)
    if t.box is None: raise SystemExit("traps: %s: its barriers don't make an arena (give it a box)" % ident)
    # the code changed: the trigger (and the player inside, no other trap going; the trap going from then on), the end
    # (the barriers gone: beaten)
    c = code[:trig[2]] + "(" + trig[1] + ") and rndTrapIn()" + code[trig[3]:trig[4] + 1] + " global.rndTrapActive=trapId;" + code[trig[4] + 1:]
    # (the room's event barriers a trap slides in are gone past the story, in the Randomizer's world: enemy barriers
    # made where they'd be instead)
    evb = [g[1] for g in groups if re.match(r"oEventBarrier", code[g[0]:g[0] + 13])]
    if evb:
        made = "{var tRndBar; " + " ".join("tRndBar=instance_create(%s,%s,oEnemyBarrier); tRndBar.image_xscale=%s; tRndBar.image_yscale=%s;"
                                           % (num(b[0]), num(b[1]), num(b[2]), num(b[3])) for b in evb) + "}"
        c = re.sub(r"oEventBarrier\.y\s*\+=\s*\d+", lambda m: made, c)
        c = re.sub(r"(with\s*\(?\s*)oEventBarrier(\s*\)?\s*\{\s*instance_destroy\(\)\s*;?\s*\})", r"\1oEnemyBarrier\2", c)
    c = re.sub(r"(with\s*\(?\s*o(?:Enemy|Event)Barrier\s*\)?\s*\{\s*instance_destroy\(\)\s*;?\s*\})", r"\1 rndTrapEnd();", c)
    if "oEventBarrier" in c: raise SystemExit("traps: %s still uses the room's event barriers" % ident)
    for p in STORY + opts.get("drop", []):
        c = drop_statements(c, p)
    left = re.findall(r"(?:^|[{;])\s*(global\.gameProgress\s*=(?!=)[^;\n]*)", c, flags=re.M)
    if left: raise SystemExit("traps: %s still sets the story: %s" % (ident, left))
    if "oPlayerIdle" in c or "oMessageCutscene" in c or re.search(r"gamePaused\s*=\s*true", c):
        raise SystemExit("traps: %s has the story's scenes in it" % ident)
    if "rndTrapEnd()" not in c: raise SystemExit("traps: %s: its barriers aren't taken away" % ident)
    t.code = c
    # its enemies, and what beats them
    if "enemies" in opts:
        t.enemies = list(opts["enemies"])
    else:
        made = re.findall(r"(?:delaySpawn|createEnemy)\(\s*[^,]+,\s*[^,]+,\s*(o\w+)", c) + \
               re.findall(r"instance_create\(\s*[^,]+,\s*[^,]+,\s*(o\w+)\s*\)", c)
        t.enemies = sorted({e for e in made if is_enemy(e)})
    if not t.enemies and "req" not in opts: raise SystemExit("traps: %s: no enemies found" % ident)
    t.area = rndgen.room_area(t.room)
    t.req = opts["req"] if "req" in opts else req_words(requirement(t.enemies, t.area))
    # the code's own variables (each set before it's read: 0, or the scene step it starts at)
    names = set(re.findall(r"(?:^|[{;])\s*([a-z][A-Za-z0-9_]*)\s*(?:\[[^\]]*\])?\s*[+\-*/]?=(?!=)", c, flags=re.M))
    declared = set()
    for v in re.findall(r"\bvar\s+([\w\s,]+);", c): declared |= {n.strip() for n in v.split(",")}
    names -= declared | BUILTINS
    t.locals = sorted(names | {"sceneProgress", "sceneDelay", "fadeAlpha", "fadeColor", "bWaitForInput"})
    # (the ones it reads that nothing here sets: listed by main, to look at)
    words = set(re.findall(r"(?<![.\w])([a-z][A-Za-z0-9_]*)\b(?!\s*\()", re.sub(r'"[^"]*"', "", re.sub(r"//[^\n]*", "", c))))
    t.unset = sorted(w for w in words - set(t.locals) - declared - BUILTINS - KEYWORDS
                     if not re.match(r"(o|s|r|b|snd|fnt|back|tile)[A-Z]", w))
    return t


def all_traps():
    return [make(*t) for t in TRAPS]


def room_ins():
    """where the player comes into each room: {room: [(x, y)]} (the exits' newMapX, newMapY that lead there, and the
    doors within a room)"""
    out = collections.defaultdict(list)
    for room in rndgen.room_names():
        for obj, x, y, hexid, code in rndgen.instances(room) or []:
            tr = re.search(r"\btoRoom\s*=\s*(\w+)", code)
            nx, ny = rndgen.num(code, "newMapX"), rndgen.num(code, "newMapY")
            if tr and nx is not None and ny is not None: out[tr.group(1)].append((nx, ny))
            ix, iy = rndgen.num(code, "newX"), rndgen.num(code, "newY")
            if obj == "oMapDoor" and ix is not None and iy is not None: out[room].append((ix, iy))
    return out


def room_gates(traps=None):
    """the room logic's gates: {room: [(sprite, x, y, xscale, yscale, angle, requirement)]} (a trap that needs nothing
    has none). An upright barrier where the player comes into the room from outside the arena (a door right beside it:
    in the game the barrier is made only once they're in the arena) is moved toward the arena till it's clear of their
    body (RoomLogic.cs's: x-7 to x+6), so the logic doesn't take them as stuck in it there"""
    out = collections.defaultdict(list)
    ins = room_ins()
    for t in traps or all_traps():
        if t.req in ("-", ""): continue
        x1, y1, x2, y2 = t.box
        for b in t.bars:
            bx, by, bxs, bys, ang = b
            if int(ang) % 180 == 0:
                r = rect(b)
                for nx, ny in ins.get(t.room, []):
                    if not (r[0] - 6 <= nx <= r[2] + 6 and r[1] <= ny and ny - 32 <= r[3]): continue
                    if nx > x2: bx = nx - 24 - (r[2] - r[0] - 16)
                    elif nx < x1: bx = nx + 8
            out[t.room].append((BARRIER_SPRITE, bx, by, bxs, bys, ang, t.req))
    return out


# ---------------------------------------------------------------- the mod
def num(v):
    return ("%d" % v) if float(v) == int(v) else ("%g" % v)


def write_mod(out, traps):
    """the traps' mod objects (objects\\oRndTrap<n>: their parent, oRndTrapBase, is mod\\objects') and rndData's lines for
    them (returned)"""
    L = ["global.rndTrapN=%d" % len(traps)]
    for k, t in enumerate(traps):
        name = "oRndTrap%d" % k
        d = os.path.join(out, "objects", name)
        os.makedirs(d, exist_ok=True)
        with open(os.path.join(d, "object.ini"), "w", encoding="utf-8", newline="\n") as f:
            f.write("[object]\nsprite=\nmask=\nparent=oRndTrapBase\ndepth=0\nsolid=0\nvisible=1\npersistent=0\n")
        x1, y1, x2, y2 = t.box
        init = ["//Randomizer: the enemy trap %s (traps.py: the game's own %s, changed): its number, its arena (where the" % (t.id, t.obj),
                "//player's feet are inside it) and the variables its code uses",
                "event_inherited()",
                "trapId=%d" % k,
                "ax1=%s; ay1=%s; ax2=%s; ay2=%s" % (num(x1), num(y1), num(x2), num(y2))]
        for n in t.locals:
            if n == "fadeColor": init.append("fadeColor=c_black")
            elif n == "bWaitForInput": init.append("bWaitForInput=false")
            else: init.append("%s=0" % n)
        if "start" in t.opts: init.append("sceneProgress=%d" % t.opts["start"])
        if "off" in t.opts:
            v, val = t.opts["off"]
            init.append("//(the game's own copy of it kept from running: its flag is something the Randomizer changes)")
            init.append("with (%s) {%s=%s}" % (t.obj, v, val))
        with open(os.path.join(d, "Create_0.gml"), "w", encoding="utf-8", newline="\n") as f:
            f.write("\n".join(init) + "\n")
        with open(os.path.join(d, "Step_0.gml"), "w", encoding="utf-8", newline="\n") as f:
            f.write("//Randomizer: the game's own enemy trap from %s's Step (its block for %s), as traps.py changes it: it\n"
                    "//starts with the player inside its arena (rndTrapIn), ends as its barriers go (rndTrapEnd), and leaves\n"
                    "//the story's own parts out. Made by rndgen.py from the game's code: change traps.py, not this\n"
                    % (t.obj, t.room) + t.code.strip("\n") + "\n")
        L.append("global.rndTrapRoom[%d]=%s; global.rndTrapObj[%d]=%s; global.rndTrapName[%d]=%s"
                 % (k, t.room, k, name, k, rndgen.gml_str(t.id)))
    return L


def main():
    traps = all_traps()
    for t in traps:
        print("%-22s %-20s box %-28s req %-60s enemies %s%s" % (t.id, t.room, t.box, t.req, ", ".join(t.enemies),
                                                                 ("   READS UNSET: " + ", ".join(t.unset)) if t.unset else ""))
    print(len(traps), "traps")


if __name__ == "__main__":
    main()
