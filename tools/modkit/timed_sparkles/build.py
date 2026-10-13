r"""
Builds the Timed Sparkles mod: the Gate 6 enemies with parryable attacks get their weapon sparkle (oG6_CounterSpark,
10 ticks long) timed so it has gone 7 ticks before the attack's most horizontal hitbox frame (the one most likely to hit
the player), following the weapon. Where the attack starts too late for all 10 ticks, the sparkle starts part-way into
its animation, so it still ends on time; with fewer than 3 ticks of it left, there's none.

  enemy                 most horizontal hit frame         hit at        sparkle
  Slime                 bite frame 2 (the lunge)          biteDelay+15  from the bite's start, 2 ticks in (8 shown)
  Skeleton              swing frame 3 (blade level)       atkDelay+26   atkDelay+9 to +19, at the blade's tip
  Sword Armor, swing 1  swing frame 2 (blade level)       atkDelay+14   from the swing's start, 3 ticks in (7 shown)
  Sword Armor, swing 2  the same                          25 ticks after the pause starts: from 8 ticks into it
  Stone Golem           the slam (hammer on the ground)   hammerDelay+20  hammerDelay+3 to +13 (the leap has none)
  High Heels Girl A, B  frame 1 (the sweep / the thrust)  actTime 15    from the start, 3 ticks in (7 shown); sped up
                                                                        6 ticks in (4 shown); fastest versions none

The mod's events are the game's own, read from objects\ when it's built, with these changes (marked "timed sparkles
change"), so build it again after the game's code for these enemies changes:

  python tools\modkit\timed_sparkles\build.py <output folder>      (then copy it to Mods\TimedSparkles)
"""
import os, re, sys

HERE = os.path.dirname(os.path.abspath(__file__))
PROJ = os.path.normpath(os.path.join(HERE, "..", "..", ".."))
MOD_INI = """[mod]
name=Timed Sparkles
author=DT3+
version=1.0
description=The weapon sparkle of the Gate 6 enemies with parryable attacks (Slime, Skeleton, Sword Armor, the Stone Golem, High Heels Girl) follows the weapon and has gone 7 ticks before the attack's most horizontal hit frame. An attack that starts too late for the whole sparkle shows the end of it, and none when that would be under 3 ticks.
legacy=0
order=0
"""
SHOW_MIN = 3     # ticks of the sparkle that must be left to show it
SPARK_LEN = 10   # ticks the sparkle lasts (oG6_CounterSpark: image_number+1)


def events(obj):
    """{event: code} of a game object (objects\\<obj>.gml), without the action headers"""
    t = open(os.path.join(PROJ, "objects", obj + ".gml"), encoding="utf-8", newline="").read().replace("\r\n", "\n")
    parts = re.split(r"^#define (\w+)[ \t]*\n", t, flags=re.M)
    ev = {}
    for i in range(1, len(parts), 2):
        body = re.sub(r"^/\*\"/\*'/\*\*//\* YYD ACTION.*?\*/[ \t]*\n", "", parts[i + 1], count=1, flags=re.S)
        ev[parts[i]] = body.rstrip("\n") + "\n"
    return ev


def rep(t, a, b, what):
    c = t.count(a)
    if c != 1: raise SystemExit("%s: %d matches for %r (the game's code changed: update build.py)" % (what, c, a[:80]))
    return t.replace(a, b)


def spawn(ind, var, ox, oy, ticks, keep_id=False):
    """GML at indent ind: a sparkle `ticks` ticks into its animation, at (ox, oy) from this instance and following it"""
    s = ["var %s;" % var,
         "%s=instance_create(x+(%d*image_xscale),y+(%d),oG6_CounterSpark)" % (var, ox, oy),
         "%s.frameCount=%s; %s.image_index=%s; %s.image_angle=10*(%s)" % (var, ticks, var, ticks, var, ticks),
         "%s.followID=id; %s.followX=%d; %s.followY=%d" % (var, var, ox, var, oy)]
    if keep_id: s.append("sparkID=%s" % var)
    return "".join(ind + l + "\n" for l in s)


def lazy_init(code):
    return ("//timed sparkles change (added): sparkDone: the sparkle made further on for the current attack has been made\n"
            "if !variable_local_exists(\"sparkDone\") {sparkDone=1}\n") + code


def main():
    if len(sys.argv) < 2: raise SystemExit(__doc__)
    out = sys.argv[1]
    files = {}

    # ---------------- Slime ----------------
    o = "oPT_Slime"; t = events(o)["Step_0"]
    t = rep(t, "          instance_create(x-(18*image_xscale),y-43,oG6_CounterSpark)\n",
            "          //instance_create(x-(18*image_xscale),y-43,oG6_CounterSpark)\n"
            "          //timed sparkles change: the bite's most horizontal frame (2, the lunge) is at biteDelay+15. To be gone 7 ticks\n"
            "          //before it, the sparkle would start 2 ticks before the bite is decided on, so it starts here 2 ticks in\n"
            + spawn("          ", "tSparkA", -18, -43, "2"), o)
    files[(o, "Step_0")] = t

    # ---------------- Skeleton (the game's Skeleton Sparkle dipswitch timing, always) ----------------
    o = "oPT_Skeleton"; t = events(o)["Step_0"]
    old = ("if global.skeletonSparkle=0 {instance_create(x-(74*image_xscale),y-19,oG6_CounterSpark)} else {sparkDone=0}"
           " //skeleton sparkle change: made below\n")
    t = rep(t, "            " + old,
            "            //" + old +
            "            sparkDone=0 //timed sparkles change: the Skeleton Sparkle dipswitch's sparkle (made below, at atkDelay+9), always\n", o)
    files[(o, "Step_0")] = t

    # ---------------- Sword Armor ----------------
    o = "oPT_SwordArmor"; t = events(o)["Step_0"]
    t = rep(t, "          sprite_index=sPT_SwordArmor_Swing\n          instance_create(x-(44*image_xscale),y-101,oG6_CounterSpark)\n",
            "          sprite_index=sPT_SwordArmor_Swing\n"
            "          //instance_create(x-(44*image_xscale),y-101,oG6_CounterSpark)\n"
            "          //timed sparkles change: the swing's most horizontal frame (2) is at atkDelay+14. To be gone 7 ticks before it,\n"
            "          //the sparkle would start 3 ticks before the swing is decided on, so it starts here 3 ticks in\n"
            + spawn("          ", "tSparkA", -44, -101, "3"), o)
    t = rep(t, "          instance_create(x-(44*image_xscale),y-101,oG6_CounterSpark)\n          image_index=0\n          bParryOpp=0\n",
            "          //instance_create(x-(44*image_xscale),y-101,oG6_CounterSpark)\n"
            "          sparkDone=0 //timed sparkles change: the second swing's sparkle is made below\n"
            "          image_index=0\n          bParryOpp=0\n", o)
    end = "      else if atkTime=atkDelay+32 {atkTime=atkDelay+1}\n    }\n"
    t = rep(t, end, end +
            "    //timed sparkles change (added): the second swing's sparkle. The pause runs from atkDelay+20 to atkDelay+32, then the\n"
            "    //swing from atkDelay+1 reaches its most horizontal frame at atkDelay+14, 25 ticks on: made at atkDelay+28 (8 ticks\n"
            "    //in), the sparkle has gone 7 ticks before that\n"
            "    if sparkDone=0 and atkTime>=atkDelay+28\n    {\n      sparkDone=1\n"
            "      if atkTime-(atkDelay+28)<=%d\n      {\n" % (SPARK_LEN - SHOW_MIN)
            + spawn("        ", "tSparkB", -44, -101, "atkTime-(atkDelay+28)") + "      }\n    }\n", o)
    files[(o, "Step_0")] = lazy_init(t)

    # ---------------- Stone Golem ----------------
    o = "oPT_StoneGolem"; t = events(o)["Step_0"]
    t = rep(t, "          instance_create(x-(33*image_xscale),y-85,oG6_CounterSpark)\n",
            "          //instance_create(x-(33*image_xscale),y-85,oG6_CounterSpark)\n"
            "          sparkDone=0 //timed sparkles change: the sparkle is made below\n", o)
    anchor = "          else {hammerTime=hammerDelay-5}\n        }\n      }\n      if jumpAtk<2 //Normal attack\n"
    t = rep(t, anchor, anchor[:-len("      if jumpAtk<2 //Normal attack\n")] +
            "      //timed sparkles change (added): the sparkle (10 ticks) is made at hammerDelay+3, so it has gone 7 ticks before the\n"
            "      //slam (the hammer flat on the ground) at hammerDelay+20. The leaping attack has none, as in the game\n"
            "      if sparkDone=0 and jumpAtk<2 and hammerTime>=hammerDelay+3\n      {\n        sparkDone=1\n"
            "        if hammerTime-(hammerDelay+3)<=%d\n        {\n" % (SPARK_LEN - SHOW_MIN)
            + spawn("          ", "tSparkA", -33, -85, "hammerTime-(hammerDelay+3)") + "        }\n      }\n"
            "      if jumpAtk<2 //Normal attack\n", o)
    files[(o, "Step_0")] = lazy_init(t)

    # ---------------- High Heels Girl ----------------
    o = "oPT_HighHeelsGirl"; ev = events(o)
    for evn, ox, oy, spr, skip, what in (
            ("Other_10", -20, -9, "sHHG_AtkA", "  if atkSpd=1 {actTime=4}\n  if atkSpd=2 {actTime=10}\n", "slash's most horizontal frame (1, the sweep)"),
            ("Other_11", -17, -44, "sHHG_AtkB", "  if atkSpd=1 {actTime=4}\n  if altAtk=2 {actTime=14}\n", "spin's most horizontal frame (1, the thrust)")):
        t = ev[evn]
        old = "  instance_create(x-(%d*image_xscale),y-%d,oG6_CounterSpark)\n  sprite_index=%s\n  image_index=0\n" % (-ox, -oy, spr) + skip
        t = rep(t, old,
                "  //instance_create(x-(%d*image_xscale),y-%d,oG6_CounterSpark)\n  sprite_index=%s\n  image_index=0\n" % (-ox, -oy, spr)
                + skip +
                "  //timed sparkles change (added): the %s is at actTime 15. To be gone 7 ticks before\n"
                "  //it, the sparkle would start at actTime -2, so it starts here actTime+2 ticks in (the faster versions skip ahead);\n"
                "  //none with fewer than %d ticks of it left\n" % (what, SHOW_MIN) +
                "  if actTime+2<=%d\n  {\n" % (SPARK_LEN - SHOW_MIN)
                + spawn("    ", "tSparkA", ox, oy, "actTime+2") + "  }\n", o + " " + evn)
        files[(o, evn)] = t

    # ---------------- write ----------------
    os.makedirs(out, exist_ok=True)
    with open(os.path.join(out, "mod.ini"), "w", encoding="utf-8", newline="\n") as f: f.write(MOD_INI)
    for (o, evn), code in files.items():
        d = os.path.join(out, "objects", o)
        os.makedirs(d, exist_ok=True)
        with open(os.path.join(d, "object.ini"), "w", encoding="utf-8", newline="\n") as f: f.write("[object]\nevents=replace\n")
        with open(os.path.join(d, evn + ".gml"), "w", encoding="utf-8", newline="\n") as f:
            f.write("//(the game's own %s %s, with the Timed Sparkles changes: tools/modkit/timed_sparkles/build.py)\n" % (o, evn) + code)
    print("built:", ", ".join("%s %s" % k for k in files))


if __name__ == "__main__":
    main()
