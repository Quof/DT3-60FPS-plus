"""
The bosses' previews in their rooms (the mod's oRndBossPreview, made by the roomStart hook): each boss's look as one
picture, made here from the game's sprites (sprites\\sRndBossPv<type>.png in the mod), the smoke a boss place shows
with Boss Rando till its fight has been seen (sRndBossSmoke), and where each boss place's arena has its middle.

A boss's look: the sprite the tracker's head is cut from, with the same layers (tracker.py's BOSS_ICONS), drawn whole;
Final Nightmare and Defective as the tracker draws them (their sprites alone aren't them), twice the size. A look
bigger than BIG either way is made half the size. BOSS_LOOK has the bosses the tracker doesn't show, and any look of
its own.

An arena's middle: where its fight holds the camera (the room code's bossTrack part: the object the view follows, or
the view's own place), else halfway between its barriers, else halfway between where the player and the boss start;
up and down, the middle of the view the player has there.
"""
import os, re, sys
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.dirname(HERE))
import png
import rndgen
import tracker

VIEW_W, VIEW_H = 480, 352
BIG = 240
# (type: (sprite, frame, options as BOSS_ICONS has them)) for the bosses BOSS_ICONS leaves out, or a look of their own
BOSS_LOOK = {
    63: ("sHexor_Main", 0, {}),
    64: ("sPT_FE_ArmsOut", 0, {}),   # (The Executive: oTheExecutive's own sprite)
    # (whole bodies where the tracker has a head: placed as their objects place them, each layer's corner from the
    # boss's place and its sprite's origin; a fifth value: True mirrored, "xy" turned round, as image_angle 180)
    6: ("sBarbaHead", 0, {"layers": [("sBarbaBody", 0, -11, 56), ("sBarbaBody", 0, -12, 40), ("sBarbaBody", 0, -10, 24),
                                     ("sBarbaBody", 0, -8, 8), ("sBarbaHead", 0, -8, -8)]}),          # (oBarba, oBarbaBody)
    7: ("sThunderbirdBody", 0, {"layers": [("sThunderbirdBody", 0, -15, -24), ("sThunderbirdWing", 0, 15, -23),
                                           ("sThunderbirdWing", 0, -24, -23, True)]}),              # (oThunderbird's Draw)
    24: ("sSigmaA_Walk", 0, {}),
    35: ("sRidleyBody", 0, {"layers": [("sRidleyTailEnd", 0, -113, 34, "xy")] +
                            [("sRidleyTailSeg", 0, -48 - 8 * s, 21 + 2 * s) for s in range(5, -1, -1)] +
                            [("sRidleyArms", 0, -40, 30), ("sRidleyWings", 0, -69, -45), ("sRidleyBody", 0, -55, -3),
                             ("sRidleyHead", 0, -15, -31)]}),                                       # (oRidley, oRidleyParts)
}
BARRIERS = ("oBossBarrier", "oEnemyBarrier", "oSolidVirusBlock")


def load(s, f):
    p = os.path.join(rndgen.PROJ, "sprites", s, "%d.png" % f)
    if not os.path.exists(p): raise SystemExit("bosspv: the sprite %s has no frame %d" % (s, f))
    return png.read(p)


def look_of(t):
    """the boss's look: (sprite, frame, options), from BOSS_LOOK or BOSS_ICONS, or None"""
    if t in BOSS_LOOK: return BOSS_LOOK[t]
    for b in tracker.BOSS_ICONS:
        if b[0] == t: return b[1], b[2], b[4]
    return None


def image(t):
    """boss type t's look: (width, height, [(r, g, b, a) rows]) cropped to its pixels, or None"""
    lk = look_of(t)
    if lk is None: return None
    sprite, frame, opts = lk
    if opts.get("special") in ("defective", "finalnightmare"):
        img = tracker.defective_head() if opts["special"] == "defective" else tracker.final_nightmare_head(load)
        # (twice the size: each pixel two by two)
        img = [[p for p in row for _ in (0, 1)] for row in img for _ in (0, 1)]
    else:
        layers = opts.get("layers") or [(sprite, frame, 0, 0)]
        parts = [(load(l[0], l[1]), l[2], l[3], len(l) > 4 and l[4]) for l in layers]
        x0 = min(lx for (w, h, rows), lx, ly, m in parts); y0 = min(ly for (w, h, rows), lx, ly, m in parts)
        x1 = max(lx + w for (w, h, rows), lx, ly, m in parts); y1 = max(ly + h for (w, h, rows), lx, ly, m in parts)
        tint, recolor, solid = opts.get("tint"), opts.get("recolor"), opts.get("solid")
        img = []
        for y in range(y0, y1):
            row = []
            for x in range(x0, x1):
                out = (0, 0, 0, 0)
                for (w, h, rows), lx, ly, mirror in parts:
                    if 0 <= x - lx < w and 0 <= y - ly < h:
                        c = (w - 1 - (x - lx)) if mirror else (x - lx)
                        v = (h - 1 - (y - ly)) if mirror == "xy" else (y - ly)
                        q = rows[v][c * 4:c * 4 + 4]
                        if q[3]: out = tuple(q)
                r, g, b, a = out
                if a and solid: a = 255
                if tint: r, g, b = r * tint[0] // 255, g * tint[1] // 255, b * tint[2] // 255
                if recolor:
                    l = min(255, int((r * 0.3 + g * 0.59 + b * 0.11) * 1.25))
                    r, g, b = l * recolor[0] // 255, l * recolor[1] // 255, l * recolor[2] // 255
                row.append((r, g, b, a))
            img.append(row)
        if opts.get("silhouette"):
            img = [[(r, g, b, 255) if a >= 100 else (0, 0, 0, 0) for r, g, b, a in row] for row in img]
        if opts.get("flip"): img = [row[::-1] for row in img]
    # cropped to its pixels
    ys = [y for y, row in enumerate(img) if any(p[3] for p in row)]
    xs = [x for x in range(len(img[0])) if any(row[x][3] for row in img)]
    img = [row[min(xs):max(xs) + 1] for row in img[min(ys):max(ys) + 1]]
    while max(len(img), len(img[0])) > BIG:
        # (half the size: each 2x2 block averaged, its colours by how opaque each pixel is)
        h, w = (len(img) + 1) // 2, (len(img[0]) + 1) // 2
        nimg = []
        for y in range(h):
            row = []
            for x in range(w):
                rs = gs = bs = at = n = 0
                for dy in (0, 1):
                    for dx in (0, 1):
                        if 2 * y + dy < len(img) and 2 * x + dx < len(img[0]):
                            r, g, b, a = img[2 * y + dy][2 * x + dx]
                            rs += r * a; gs += g * a; bs += b * a; at += a
                        n += 1
                row.append((rs // at, gs // at, bs // at, at // n) if at else (0, 0, 0, 0))
            nimg.append(row)
        img = nimg
    return len(img[0]), len(img), img


def write_sprite(folder, name, frames, w, h, xo, yo):
    """a mod sprite: sprites\\<name>.png (the frames left to right) and its .ini"""
    rows = [bytearray(v for fr in frames for p in fr[y] for v in p) for y in range(h)]
    png.write(os.path.join(folder, name + ".png"), w * len(frames), h, rows)
    with open(os.path.join(folder, name + ".ini"), "w", encoding="utf-8", newline="\n") as f:
        f.write("[sprite]\nframes=%d\nxorig=%d\nyorig=%d\ntransparent=0\nsmooth=0\nsepmasks=0\nbboxmode=0\nleft=0\ntop=0\n"
                "right=%d\nbottom=%d\nkind=0\ntolerance=0\n" % (len(frames), xo, yo, w - 1, h - 1))


def smoke(folder):
    """sRndBossSmoke: puffs of smoke, in greys (the preview tints them), as pixel art: 4 frames of 40x40, each a cloud
    of a few round lobes, lit from the top left in four shades, its edge a pixel of half opacity"""
    import math, random
    rnd = random.Random(7)
    S = 40
    frames = []
    for k in range(4):
        lobes = [(S / 2, S / 2 + 2, 11.0)]
        for _ in range(rnd.choice((3, 4))):
            a = rnd.uniform(0, 2 * math.pi)
            r = rnd.uniform(6.5, 9.5)
            lobes.append((S / 2 + math.cos(a) * (17 - r), S / 2 + 2 + math.sin(a) * (15 - r) * 0.8, r))
        fr = []
        for y in range(S):
            row = []
            for x in range(S):
                px, py = x + 0.5, y + 0.5
                inside = [(cx, cy, r) for cx, cy, r in lobes if math.hypot(px - cx, py - cy) <= r]
                near = any(math.hypot(px - cx, py - cy) <= r + 1 for cx, cy, r in lobes)
                if not inside:
                    row.append((150, 150, 150, 128) if near else (0, 0, 0, 0))
                    continue
                # (lit: the nearer to a lobe's top left, the lighter; four shades)
                lit = max(1 - math.hypot(px - (cx - r * 0.35), py - (cy - r * 0.35)) / (r * 1.45) for cx, cy, r in inside)
                g = (110, 155, 200, 240)[min(3, max(0, int(lit * 4)))]
                row.append((g, g, g, 255))
            fr.append(row)
        frames.append(fr)
    write_sprite(folder, "sRndBossSmoke", frames, S, S, S // 2, S // 2)


def arena_middle(room, fx, fy, bx, by):
    """boss place's arena middle in its room (room: its name; fx, fy: where its fight starts; bx, by: where the
    boss gallery puts the player): (x, y)"""
    rt = rndgen.read(os.path.join(rndgen.ROOMS, room, "room.txt"))
    rw = int(re.search(r"^width=(\d+)", rt, re.M).group(1)); rh = int(re.search(r"^height=(\d+)", rt, re.M).group(1))
    rc = rndgen.read(os.path.join(rndgen.ROOMS, room, "code.gml"))
    m = re.search(r"if global\.bossTrack\s*(>=|=)\s*1", rc)
    part = rc[m.end():m.end() + 2500] if m else ""
    # (the bossTrack part's own block: up to its else)
    e = re.search(r"\n\s*\}\s*\n\s*else\b", part)
    if e: part = part[:e.start()]
    num = lambda s: int(s) if re.match(r"^-?\d+$", s.strip()) else None
    cx = cy = None
    # the view following an object the fight makes (oMisc, the camera held still)
    vo = re.search(r"view_object\[0\]\s*=\s*(\w+)", part)
    if vo:
        mk = re.search(r"%s\s*=\s*instance_create\(([^,]+),([^,]+),\w+\)" % re.escape(vo.group(1)), part)
        if mk and num(mk.group(1)) is not None and num(mk.group(2)) is not None: cx, cy = num(mk.group(1)), num(mk.group(2))
    if cx is None:
        vx = re.search(r"view_xview\[0\]\s*=\s*(-?\d+)\s*[\n;]", part)
        if vx: cx = int(vx.group(1)) + VIEW_W // 2
    if cx is None:
        # (barriers on both sides: one wall in two pieces, at one x, isn't two)
        bars = [num(x) for x, y, o in re.findall(r"instance_create\(([^,]+),([^,]+),(\w+)\)", part) if o in BARRIERS]
        bars = [b for b in bars if b is not None]
        if bars and max(bars) - min(bars) >= VIEW_W // 4: cx = (min(bars) + max(bars)) // 2
    if cx is None:
        # (a room little wider than the view: its middle; a wider one: halfway between the player and the boss)
        boss = [(num(x), num(y)) for x, y, o in re.findall(r"instance_create\(([^,]+),([^,]+),(\w+)\)", part)
                if o not in BARRIERS + ("oMisc", "oGameCamera", "oExit", "oInvisibleSolid")]
        boss = [b for b in boss if b[0] is not None]
        if rw <= VIEW_W * 3 // 2: cx = rw // 2
        else: cx = (fx + boss[0][0]) // 2 if boss else fx
    if cy is None:
        cy = min(max(fy - VIEW_H // 2, 0), max(rh - VIEW_H, 0)) + VIEW_H // 2
    cx = min(max(cx, VIEW_W // 2), max(rw - VIEW_W // 2, VIEW_W // 2))
    cy = min(max(cy, VIEW_H // 2), max(rh - VIEW_H // 2, VIEW_H // 2))
    return cx, cy


def write_mod(out, blist, bstart, via):
    """the previews' sprites in the mod (out\\sprites) and their data's lines for rndData: each boss's look
    (rndBossPv: its sprite, -1 none) and each boss place's arena middle (rndBossMX, rndBossMY: -1 for a place without
    one to show it in: a fight gone into by an exit, BOSS_VIA, or one that starts as its room is come into)"""
    folder = os.path.join(out, "sprites")
    os.makedirs(folder, exist_ok=True)
    smoke(folder)
    L = []
    for i, ((t, room, bx, by, name), (fx, fy, fe)) in enumerate(zip(blist, bstart)):
        img = image(t)
        spr = "-1"
        if img:
            w, h, px = img
            spr = "sRndBossPv%d" % t
            write_sprite(folder, spr, [px], w, h, w // 2, h // 2)
        mx, my = (-1, -1) if (t in via or fe) else arena_middle(room, fx, fy, bx, by)
        L.append("global.rndBossPv[%d]=%s; global.rndBossMX[%d]=%d; global.rndBossMY[%d]=%d" % (i, spr, i, mx, i, my))
    return L
