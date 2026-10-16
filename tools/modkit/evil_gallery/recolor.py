"""
The evil bosses' colours: each sprite the mod uses is the game's own (sprites\\<name>) with its colours moved to an evil
palette (sprites\\sEvg<name> in the mod: the same frames, origin and size). A palette is a list of bands: a band takes
the colours whose hue is in its range (and saturation at least its least, so greys go to the grey band) to its hue,
with its saturation and value multiplied. A pixel whose value is under DARK stays as it is (outlines, shadows), and
greys (saturation under GREY) take the palette's grey band.
"""
import colorsys, os, sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.dirname(HERE))
import png

PROJ = os.path.normpath(os.path.join(HERE, "..", "..", ".."))
SPRITES = os.path.join(PROJ, "sprites")
DARK = 0.12
GREY = 0.14

# (hue from, hue to (degrees; from > to wraps past 0), new hue, saturation x, value x); "grey": (saturation x, value x,
# tint hue, tint amount)
PALETTES = {
    # Bowser: the shell a dark violet, the skin crimson, the hair pale bone, the fire violet
    "bowser": {"bands": [(70, 175, 272, 0.95, 0.72), (15, 44, 352, 0.95, 0.78), (44, 68, 40, 0.25, 1.0),
                         (330, 15, 318, 0.9, 0.78), (175, 330, 255, 1.0, 0.8)],
               "grey": (1.0, 0.72, 280, 0.12)},
    # his fire (and the evil fire everywhere): violet with a pale core
    "fire": {"bands": [(0, 70, 285, 0.95, 0.95), (70, 360, 285, 0.95, 0.9)], "grey": (1.0, 1.0, 290, 0.35)},
    # the Mario enemies he calls: dark, cold
    "minion": {"bands": [(330, 30, 285, 0.9, 0.7), (30, 70, 45, 0.5, 0.85), (70, 330, 230, 0.8, 0.75)],
               "grey": (1.0, 0.65, 280, 0.15)},
    # Helmethead: crimson armour, the light parts rose, the shield black-violet
    "helmet": {"bands": [(185, 275, 352, 1.0, 0.82), (15, 50, 280, 0.6, 0.55), (275, 330, 340, 1.0, 0.8),
                         (330, 15, 0, 1.0, 0.85), (50, 185, 20, 0.9, 0.85)],
               "grey": (1.0, 0.85, 350, 0.25)},
    # his third head (under the second helmet): the same, darker and more violet
    "helmet_dark": {"bands": [(185, 275, 330, 1.0, 0.6), (15, 50, 280, 0.6, 0.4), (275, 330, 320, 1.0, 0.6),
                              (330, 15, 345, 1.0, 0.65), (50, 185, 10, 0.9, 0.65)],
                    "grey": (1.0, 0.6, 330, 0.3)},
    # Death: a blood-red robe, the blade red steel, the shaft black
    "death": {"bands": [(35, 95, 350, 1.25, 0.78), (95, 215, 355, 0.55, 0.95), (10, 35, 270, 0.45, 0.45),
                        (215, 330, 330, 0.9, 0.8), (330, 10, 345, 1.0, 0.85)],
              "grey": (1.0, 0.9, 355, 0.2)},
    # the gallery's evil gate: the gold and stone of the gallery's arches as dark crimson stone
    "gate": {"bands": [(20, 75, 352, 0.85, 0.7), (75, 200, 300, 0.6, 0.6), (200, 20, 330, 0.7, 0.6)],
             "grey": (1.0, 0.7, 350, 0.3)},
}


def in_band(h, lo, hi):
    return lo <= h < hi if lo <= hi else (h >= lo or h < hi)


def recolor_px(px, pal):
    r, g, b, a = px
    if a == 0: return px
    h, s, v = colorsys.rgb_to_hsv(r / 255.0, g / 255.0, b / 255.0)
    if v < DARK: return px
    if s < GREY:
        sm, vm, th, tw = pal["grey"]
        v = min(1.0, v * vm)
        # (a grey takes a little of the tint's colour)
        tr, tg, tb = colorsys.hsv_to_rgb(th / 360.0, 1.0, v)
        r2, g2, b2 = v * (1 - tw) + tr * tw, v * (1 - tw) + tg * tw, v * (1 - tw) + tb * tw
        return (int(r2 * 255 + 0.5), int(g2 * 255 + 0.5), int(b2 * 255 + 0.5), a)
    hd = h * 360
    for lo, hi, nh, sm, vm in pal["bands"]:
        if in_band(hd, lo, hi):
            r2, g2, b2 = colorsys.hsv_to_rgb((nh % 360) / 360.0, min(1.0, s * sm), min(1.0, v * vm))
            return (int(r2 * 255 + 0.5), int(g2 * 255 + 0.5), int(b2 * 255 + 0.5), a)
    return px


def recolor_image(img, pal):
    w, h, rows = img
    out = []
    for row in rows:
        o = bytearray(len(row))
        for x in range(w):
            o[x * 4:x * 4 + 4] = bytes(recolor_px(tuple(row[x * 4:x * 4 + 4]), pal))
        out.append(o)
    return w, h, out


def sprite_info(name):
    """the game's sprite: (frames [(w, h, rows)], settings from its sprite.txt)"""
    d = os.path.join(SPRITES, name)
    kv = dict(l.strip().split("=", 1) for l in open(os.path.join(d, "sprite.txt"), encoding="utf-8") if "=" in l)
    n = int(kv.get("frames", 1))
    return [png.read(os.path.join(d, "%d.png" % k)) for k in range(n)], kv


def write_mod_sprite(folder, name, frames, kv):
    """a mod sprite (sprites\\<name>.png, its frames left to right, and .ini) with the game sprite's settings"""
    w, h = frames[0][0], frames[0][1]
    for f in frames:
        if (f[0], f[1]) != (w, h): raise SystemExit("recolor: %s's frames aren't all one size" % name)
    rows = [bytearray(b"".join(bytes(f[2][y]) for f in frames)) for y in range(h)]
    png.write(os.path.join(folder, name + ".png"), w * len(frames), h, rows)
    # (the collision box as the game's sprite has it: automatic for none (bbox_type 0), else its box)
    bt = int(kv.get("bbox_type", 0))
    lines = ["[sprite]", "frames=%d" % len(frames), "xorig=%s" % kv.get("origin_x", 0), "yorig=%s" % kv.get("origin_y", 0),
             "transparent=0", "smooth=0", "sepmasks=%s" % kv.get("per_frame_colliders", 0), "bboxmode=%d" % (2 if bt == 2 else (1 if bt == 1 else 0)),
             "left=%s" % kv.get("bbox_left", 0), "top=%s" % kv.get("bbox_top", 0), "right=%s" % kv.get("bbox_right", w - 1),
             "bottom=%s" % kv.get("bbox_bottom", h - 1), "kind=%s" % kv.get("collision_shape", 1),
             "tolerance=%s" % kv.get("alpha_tolerance", 0)]
    with open(os.path.join(folder, name + ".ini"), "w", encoding="utf-8", newline="\n") as f:
        f.write("\n".join(lines) + "\n")


def evil_sprite(folder, src, palette, name=None):
    """sprites\\sEvg<src> (or name): the game's sprite src in the palette; returns its name"""
    frames, kv = sprite_info(src)
    pal = PALETTES[palette]
    name = name or ("sEvg" + src[1:] if src.startswith("s") else "sEvg" + src)
    write_mod_sprite(folder, name, [recolor_image(f, pal) for f in frames], kv)
    return name
