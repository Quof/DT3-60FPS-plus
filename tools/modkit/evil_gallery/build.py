r"""
Builds the Evil Boss Gallery mod: a second boss gallery (rEvgGallery, a copy of rBossGallery) behind a gate at the end
of the Boss Gallery's entrance floor, with evil versions of its fights. So far Evil Bowser, Evil Helmethead and Evil
Death (his first form); the other doors are sealed. See README.txt for the fights.

  python tools\modkit\evil_gallery\build.py <output folder>      (then copy it to Mods\EvilGallery)

The mod is mod\ (objects, scripts, hooks; mod\roomcode\<room>.gml is the creation code of each of its rooms) plus what
this makes from the game's own files, so build it again after those change:
  - the evil sprites: the game's (sprites\) recoloured (recolor.py), the gate's arch (from the gallery's tiles) and the
    swirl in it
  - the rooms: copies of the game's (rooms\), the gallery's doors made evil ones (oEvgDoor) and its signs rewritten, the
    exits to the story's rooms taken out of the fight rooms
  - the patch putting the gate in the Boss Gallery (moving its first score sign out of the way)
"""
import math, os, shutil, sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
sys.path.insert(0, os.path.dirname(HERE))
import png, recolor

PROJ = recolor.PROJ
MOD = os.path.join(HERE, "mod")

MOD_INI = """[mod]
name=Evil Boss Gallery
author=DT3+
version=1.0
description=A second boss gallery behind a gate at the end of the Boss Gallery's entrance: evil versions of the bosses with new attacks. So far Evil Bowser, Evil Helmethead and Evil Death, each with best times, fewest hits and medals.
legacy=0
order=0
fallbackRoom=rBossGallery
fallbackX=648
fallbackY=1376
"""

# (the game's sprite, palette, the mod's name: None for sEvg + the name without its s)
SPRITES = [
    # Evil Bowser
    ("sBowserStand", "bowser", None), ("sBowserStomp", "bowser", None), ("sBowserFire1", "fire", None),
    ("sRedParatroopa", "minion", None), ("sBulletBill", "minion", None),
    ("sEfThwompHit", "fire", "sEvgThwompHit"), ("sG2_PoeFlame", "fire", "sEvgPoeFlame"),
    # Evil Helmethead
    ("sHelmetHeadBody", "helmet", None), ("sHelmetHeadA", "helmet", None), ("sHelmetHeadB", "helmet", None),
    ("sHelmetHeadB", "helmet_dark", "sEvgHelmetHeadC"), ("sHelmetShield", "helmet", None),
    ("sWolfHeadShot", "helmet", None), ("sLinkArrow", "helmet", None),
    # Evil Death
    ("sDeathWalk", "death", None), ("sDeathJump", "death", None), ("sDeathRoll", "death", None),
    ("sDeathBlock", "death", None), ("sDeathDuck", "death", None), ("sDeathReadyA", "death", None),
    ("sDeathReadyB", "death", None), ("sDeathReadyC", "death", None), ("sDeathSwingA", "death", None),
    ("sDeathSwingB", "death", None), ("sDeathStandBack", "death", None), ("sDeathScytheSlashA", "death", None),
    ("sDeathScytheSlashB", "death", None), ("sDeathScytheSlashC", "death", None), ("sDeathSpinScythe", "death", None),
    ("sDeathPentagramShield", "death", None),
]

# the gallery's arch over a door (in its tiles, tileBossRoomA): left, top, width, height
ARCH = (0, 64, 112, 112)

# the evil gallery's entrance signs (rBossGallery's, by instance): the new text, the sign's size
SIGNS = {
    "000BFAF0": ("This is the Evil Boss Gallery. Behind its doors are evil versions of bosses you've beaten: more life, new attacks, no mercy. You fight them with the abilities the Boss Gallery gives you for each.", 3),
    "000B4850": ("Your best time and fewest hits are kept for each evil boss. Win with 4 hits or fewer for bronze, 2 or fewer for silver, none for gold.", 3),
    "00288016": ("You can press [Skip] in the evil boss rooms to instantly reset the battle. The gods are still on your side: it does not count as a death in your records.", 3),
    "000AF355": ("Assist Mode can be used, but the times and hits will not be counted.", 1),
    "00025716": ("Only a few of these doors have been broken open so far. The rest are still sealed.", 1),
}

# the mod's rooms: (the game's room, the mod's, caption, objects taken out, renamed objects, instance code changes)
ROOMS = [
    ("rBossGallery", "rEvgGallery", "Evil Boss Gallery", {"oBossScoreSign"}, {"oBossGalleryDoor": "oEvgDoor"}, []),
    ("rMario1_4Boss", "rEvgBowser", "Evil Bowser", {"oExit"}, {}, []),
    ("rLink2_PalaceA_11", "rEvgHelmet", "Evil Helmethead", {"oExit"}, {}, []),
    ("rBelmont3_7G", "rEvgDeath", "Evil Death", {"oExit"}, {}, [("sprite_index=sDeathWalk", "sprite_index=sEvgDeathWalk")]),
]

PATCH = """# Evil Boss Gallery: the gate to the evil gallery at the end of the entrance's floor, where the first score sign was
# (that sign moved next to the entrance's signs)
move|oBossScoreSign|656|1376|206|1376
add|oEvgGate|640|1344|0|-
"""

# the evil fights in the game's own rooms (evgKind 2): as the fight starts there, its controller (oEvgFight) makes the
# game's boss objects the mod's evil ones (each a child of the game's) and puts recoloured copies of the fight's
# sprites in place of the game's for the fight (loaded then from evil\, not as the game starts). Each: the gallery
# type, the boss's name, [(the game's object, the evil one)], [the game's sprites to recolour: a name, or (name, palette)
# for one in a palette of its own], the palette (a name in recolor.PALETTES, or None: recolor.auto_palette, the
# boss's own colours darker and pulled toward crimson), [the game over hints, 3]
B_FIGHTS = [
    dict(type=2, name="Cackletta", swap=[("oCackletta", "oEvgCackletta")],
         sprites=["sCacklettaIdle", "sCacklettaWings", "sCacklettaArmSwing", "sCacklettaLaugh", "sCacklettaPhone1",
                  "sCacklettaPhone2", "sCacklettaDefeat", "sCacklettaHands", "sCackBat", "sCackLightning",
                  ("sBowserFire1", "fire")],
         palette=None,
         hints=["Look for the gap in her lightning, where there are no warnings. It's always on solid ground.",
                "Her bats fly at where you were. Keep moving, or stomp one for a lift.",
                "Once the floor's gone, watch for the lava bubbling before you jump a pit."]),
    dict(type=3, name="Kamek", swap=[("oKamek", "oEvgKamek")],
         sprites=["sKamekIdle", "sKamekWalk", "sKamekHandsUp", "sKamekHit", "sKamekWand", "sKamekShape", "sKamAtkBall",
                  "sKamAtkBFade", ("sKamFlame", "fire")],
         palette=None,
         hints=["His wand guards him from the start. Stomp it when it swoops low, then go for him.",
                "The giant orb rolls under the side platforms. Wait up there, or clear it with a full jump.",
                "When he flies up he shows you his line. Step off it before he dives."]),
    dict(type=5, name="Dead Hand", swap=[("oDeadHand", "oEvgDeadHand")],
         sprites=["sDeadHand_Idle", "sDeadHand_Jump", "sGrabbingHand", "sWolfHeadShot", "sG2_ForestPoe"],
         palette=None,
         hints=["When the ground shakes at your feet, move. It's coming up right there.",
                "Its claws run along the floor. Jump them, or wait on a block.",
                "When only its head shows, the sword and arrows do nothing. Drop a bomb on it."]),
    dict(type=6, name="Barba", swap=[("oBarba", "oEvgBarba")],
         sprites=["sBarbaHead", "sBarbaBody", ("sBarbaFire", "fire"), ("sFireBroFire", "fire")],
         palette=None,
         hints=["Before it lunges, its eyes glow in a pit: low means jump, high means duck.",
                "When a pit bubbles, don't jump across it. The lava goes up right after.",
                "When it roars, watch the islands for the rocks' shadows."]),
    dict(type=7, name="Thunderbird", swap=[("oThunderbird", "oEvgThunderbird")],
         sprites=["sThunderbirdBody", "sThunderbirdWing", ("sFireBroFire", "fire"), "sFireBroBlueFire", "sCackLightning"],
         palette=None,
         hints=["When it screeches up high, three bolts are coming. Get off the warnings.",
                "Walk into its wind. Jump the low fireballs, duck the high ones.",
                "When its eyes flash, move: it dives at where you are. Then cut it while it's low."]),
    dict(type=8, name="Aqua Serpent", swap=[("oAquaSerpent", "oEvgAquaSerpent")],
         sprites=["sAquaSer_HeadA", "sAquaSer_HeadB", "sAquaSer_HeadC", "sAquaSer_Body", "sAquaSer_WaterShot",
                  "sWolfHeadShot"],
         palette=None,
         hints=["When the water heaves at one end of the platform, a wave's coming. Jump it.",
                "Its rings of shots always have a gap. Move to it before the ring reaches you.",
                "When the water pulls, walk against it and keep moving: the spouts come up under you."]),
]


def b_sprite_name(t, src):
    return "Ev%d_%s" % (t, src[1:] if src.startswith("s") else src)


def write_b_fights(out):
    """the evil sprites of the fights in the game's rooms (in evil) and the scripts saying what each fight is"""
    ev = os.path.join(out, "evil")
    os.makedirs(ev, exist_ok=True)
    with open(os.path.join(ev, "evil.txt"), "w", encoding="utf-8", newline="\n") as f:
        f.write("The Evil Boss Gallery's sprites for its fights in the game's own rooms (loaded as each fight starts).\n")
    kinds = {1: 1, 4: 1, 14: 1}
    swaps, sprs, hints = [], [], []
    names = []
    for b in B_FIGHTS:
        t = b["type"]
        kinds[t] = 2
        swaps.append("  case %d:\n" % t + "".join(
            "    with (%s) {if object_index=%s {instance_change(%s,false)}}\n" % (o, o, e) for o, e in b["swap"]) + "    break\n")
        pal = b.get("palette")
        if pal is None:
            pal = recolor.auto_palette()
        elif isinstance(pal, str):
            pal = recolor.PALETTES[pal]
        lines = []
        for src in b["sprites"]:
            spal = pal
            if isinstance(src, tuple): src, spal = src[0], recolor.PALETTES[src[1]]
            frames, kv = recolor.sprite_info(src)
            nm = b_sprite_name(t, src)
            recolor.write_mod_sprite(ev, nm, [recolor.recolor_image(fr, spal) for fr in frames], kv)
            lines.append('    evgSprOne(%s,"%s")\n' % (src, nm))
            names.append(nm)
        sprs.append("  case %d:\n" % t + "".join(lines) + "    break\n")
        h = b["hints"]
        hints.append("  case %d:\n" % t + "".join('    if argument1=%d {return %s}\n' % (k, gml_string(s)) for k, s in enumerate(h)) + "    break\n")
    sd = os.path.join(out, "scripts")
    os.makedirs(sd, exist_ok=True)
    def put_script(name, head, body):
        with open(os.path.join(sd, name + ".gml"), "w", encoding="utf-8", newline="\n") as f:
            f.write(head + body)
    put_script("evgKind", "//Evil Boss Gallery: what kind of evil fight the boss gallery's type argument0 has (the build writes this): 0 none\n"
               "//yet, 1 one in the mod's own copy of its room, 2 one in the game's own room\n",
               "".join("if argument0=%d {return %d}\n" % (k, v) for k, v in sorted(kinds.items())) + "return 0\n")
    put_script("evgSwapObjs", "//Evil Boss Gallery: the game's boss objects of the evil fight argument0 made the mod's evil ones (oEvgFight's begin\n"
               "//step; the build writes this from build.py's B_FIGHTS)\n",
               "switch (argument0)\n{\n" + "".join(swaps) + "}\n")
    put_script("evgSprList", "//Evil Boss Gallery: the game's sprites recoloured for the evil fight argument0 (evgSprSwap; the build writes this\n"
               "//from build.py's B_FIGHTS)\n",
               "switch (argument0)\n{\n" + "".join(sprs) + "}\n")
    put_script("evgHintB", "//Evil Boss Gallery: the game over hint argument1 (0-2) of the evil fight argument0 in the game's room (the\n"
               "//gameOverHint hook; the build writes this from build.py's B_FIGHTS)\n",
               "switch (argument0)\n{\n" + "".join(hints) + "}\nreturn \"\"\n")
    return names



def gml_string(s):
    """s as a GameMaker 8 string literal (either quote, whichever s doesn't have)"""
    if '"' not in s: return '"' + s + '"'
    if "'" not in s: return "'" + s + "'"
    raise SystemExit("build: a sign's text has both kinds of quote: %r" % s)


def copy_mod(out):
    for root, dirs, files in os.walk(MOD):
        rel = os.path.relpath(root, MOD)
        if rel.split(os.sep)[0] == "roomcode": continue
        d = os.path.join(out, rel) if rel != "." else out
        os.makedirs(d, exist_ok=True)
        for f in files:
            shutil.copyfile(os.path.join(root, f), os.path.join(d, f))


def arch_sprite(folder):
    """sEvgGateArch: the gallery's arch over a door, from its tiles, in the gate palette (origin its top left)"""
    w, h, rows = png.read(os.path.join(PROJ, "backgrounds", "tileBossRoomA.png"))
    l, t, aw, ah = ARCH
    if l + aw > w or t + ah > h: raise SystemExit("build: tileBossRoomA is smaller than the arch's place in it")
    crop = (aw, ah, [bytearray(rows[t + y][l * 4:(l + aw) * 4]) for y in range(ah)])
    img = recolor.recolor_image(crop, recolor.PALETTES["gate"])
    recolor.write_mod_sprite(folder, "sEvgGateArch", [img],
                             {"origin_x": 0, "origin_y": 0, "bbox_type": 1, "collision_shape": 1})


def portal_sprite(folder):
    """sEvgPortal: the swirl in the gate's arch, 4 frames: an oval of dark crimson and violet turning (48x72, origin its
    bottom middle, the foot on the floor)"""
    W, H, CX, CY, RX, RY = 48, 72, 24, 40, 20, 32
    frames = []
    for f in range(4):
        rows = []
        for y in range(H):
            row = bytearray(W * 4)
            for x in range(W):
                dx, dy = (x + 0.5 - CX) / RX, (y + 0.5 - CY) / RY
                r = math.hypot(dx, dy)
                if r >= 1: continue
                a = math.atan2(dy, dx)
                v = 0.5 + 0.5 * math.sin(3 * a + 9 * r - f * math.pi / 2)
                c0, c1 = (50, 0, 28), (176, 44, 150)
                k = v * (0.35 + 0.65 * r)
                col = [int(c0[i] + (c1[i] - c0[i]) * k) for i in range(3)]
                alpha = int(235 * min(1.0, (1 - r) * 4))
                row[x * 4:x * 4 + 4] = bytes(col + [alpha])
            rows.append(row)
        frames.append((W, H, rows))
    recolor.write_mod_sprite(folder, "sEvgPortal", frames,
                             {"origin_x": 24, "origin_y": 72, "bbox_type": 1, "collision_shape": 1})


def text(p):
    """a room file's text, byte for byte (latin-1), and its line ending"""
    t = open(p, "rb").read().decode("latin-1")
    return t, ("\r\n" if "\r\n" in t else "\n")


def put(p, t):
    with open(p, "wb") as f: f.write(t.encode("latin-1"))


def copy_room(src, dst, caption, drop, rename, code_changes, out):
    s = os.path.join(PROJ, "rooms", src)
    d = os.path.join(out, "rooms", dst)
    os.makedirs(d, exist_ok=True)
    t, nl = text(os.path.join(s, "room.txt"))
    put(os.path.join(d, "room.txt"), nl.join("caption=" + caption if l.startswith("caption=") else l for l in t.split(nl)))
    shutil.copyfile(os.path.join(s, "layers.txt"), os.path.join(d, "layers.txt"))
    for l in text(os.path.join(s, "layers.txt"))[0].split():
        shutil.copyfile(os.path.join(s, l + ".txt"), os.path.join(d, l + ".txt"))
    t, nl = text(os.path.join(s, "instances.txt"))
    kept, dropped, signs = [], 0, 0
    for l in t.split(nl):
        if not l.strip(): continue
        p = l.split(",")
        if p[0] in drop:
            dropped += 1
            continue
        p[0] = rename.get(p[0], p[0])
        kept.append(",".join(p))
        if p[9] == "1":
            code, cnl = text(os.path.join(s, p[3] + ".gml"))
            if dst == "rEvgGallery" and p[3] in SIGNS:
                sign, size = SIGNS[p[3]]
                code = cnl.join(["//Evil Boss Gallery: the evil gallery's own sign (tools/modkit/evil_gallery/build.py)",
                                 "stringToShow=%s" % gml_string(sign), "signSize=%d" % size, ""])
                signs += 1
            for a, b in code_changes: code = code.replace(a, b)
            put(os.path.join(d, p[3] + ".gml"), code)
    if dst == "rEvgGallery" and signs != len(SIGNS): raise SystemExit("build: rBossGallery's signs changed (%d of %d found)" % (signs, len(SIGNS)))
    put(os.path.join(d, "instances.txt"), nl.join(kept) + nl)
    shutil.copyfile(os.path.join(MOD, "roomcode", dst + ".gml"), os.path.join(d, "code.gml"))
    return len(kept), dropped


def main():
    if len(sys.argv) < 2: raise SystemExit(__doc__)
    out = sys.argv[1]
    if os.path.exists(out) and os.listdir(out): raise SystemExit("build: %s isn't empty" % out)
    copy_mod(out)
    with open(os.path.join(out, "mod.ini"), "w", encoding="utf-8", newline="\n") as f: f.write(MOD_INI)

    spr = os.path.join(out, "sprites")
    os.makedirs(spr, exist_ok=True)
    names = [recolor.evil_sprite(spr, src, pal, name) for src, pal, name in SPRITES]
    arch_sprite(spr); portal_sprite(spr)
    names += ["sEvgGateArch", "sEvgPortal"]

    rooms = []
    for src, dst, caption, drop, rename, changes in ROOMS:
        n, dropped = copy_room(src, dst, caption, drop, rename, changes, out)
        rooms.append("%s (%s: %d instances, %d taken out)" % (dst, src, n, dropped))

    bnames = write_b_fights(out)

    pd = os.path.join(out, "patches", "rBossGallery")
    os.makedirs(pd, exist_ok=True)
    with open(os.path.join(pd, "patch.txt"), "w", encoding="utf-8", newline="\n") as f: f.write(PATCH)

    print("sprites: %d (%s)" % (len(names), ", ".join(names)))
    print("rooms: " + "; ".join(rooms))
    print("fights in the game's rooms: %d, their sprites %d" % (len(B_FIGHTS), len(bnames)))


if __name__ == "__main__":
    main()
