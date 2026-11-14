"""Phase F.3, item-spot fit: every place with every item's look. A pickup takes its item's look (rndItemLookKP's
sprite and frame) and is moved as the mod's rndItemFit moves it (its opaque pixels' bottom where its own sprite's was
when it stands on something or would reach into the ground; its top where its own sprite's was under a ceiling it would
reach into). The player touches its look's collision box there, and the room logic got to the place by touching its own
sprite's. A look whose box, where it's moved to, takes in none of the open pixels (not in a solid) of its own sprite's
box, or is outside the room, is listed (the room logic's way to the place may not touch it). Only the pickups that take
their item's look (LOOK_TYPES); a story pickup keeps its own sprite's mask, moved with it. The keys fall onto their
look's bottom with the game's own collision box (setCollisionBounds): left out.

    python fitcheck.py        writes fitcheck.txt"""
import collections, os, re, sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.dirname(os.path.dirname(HERE)))
import png

PROJ = os.path.normpath(os.path.join(HERE, "..", "..", "..", ".."))
ROOMS_TXT = os.path.join(HERE, "work", "rooms.txt")
LOOKS = os.path.join(HERE, "..", "mod", "scripts", "rndItemLookKP.gml")
OUT = os.path.join(HERE, "fitcheck.txt")
FALLING = {"sDoorKey"}      # (oDoorKey: setCollisionBounds)
# the location types whose pickups take their item's look (rndPickupSetup: rndgen.SIMPLE_PICKUPS, the Spring Ball, the
# gates' rewards, the story's ability pickups); the chests (2) keep their own, as do the Item Finder and the X Charge
# Capsule
LOOK_TYPES = {1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14, 17, 18, 19}
STORY = 19

_spr = {}


def sprite(name):
    """(frames: [(opaque box from the origin) or None], collision box from the origin, frame count)"""
    if name in _spr: return _spr[name]
    d = os.path.join(PROJ, "sprites", name)
    if not os.path.exists(os.path.join(d, "sprite.txt")): _spr[name] = None; return None
    k = dict(l.strip().split("=", 1) for l in open(os.path.join(d, "sprite.txt"), encoding="utf-8") if "=" in l)
    ox, oy = int(k.get("origin_x", 0)), int(k.get("origin_y", 0))
    n = int(k.get("frames", 1))
    frames, W, H = [], 0, 0
    pix = set()
    for i in range(n):
        w, h, rows = png.read(os.path.join(d, "%d.png" % i))
        W, H = max(W, w), max(H, h)
        l = t = 1 << 30; r = b = -1
        for y, row in enumerate(rows):
            for x in range(w):
                if row[x * 4 + 3] > int(k.get("alpha_tolerance", 0)):
                    l = min(l, x); r = max(r, x); t = min(t, y); b = y
                    if i == 0: pix.add((x - ox, y - oy))
        frames.append((l - ox, t - oy, r - ox, b - oy) if r >= 0 else None)
    bt = int(k.get("bbox_type", 0))
    known = [f for f in frames if f]
    if bt == 1: cb = (-ox, -oy, W - 1 - ox, H - 1 - oy)
    elif bt == 2: cb = (int(k["bbox_left"]) - ox, int(k["bbox_top"]) - oy, int(k["bbox_right"]) - ox, int(k["bbox_bottom"]) - oy)
    else: cb = (min(f[0] for f in known), min(f[1] for f in known), max(f[2] for f in known), max(f[3] for f in known)) if known else None
    # (a precise mask, collision_shape 0: its first frame's opaque pixels; else None, the box)
    _spr[name] = (frames, cb, n, pix if int(k.get("collision_shape", 0)) == 0 else None)
    return _spr[name]


def looks():
    """each item look: (sprite, frame or -1 when it animates), from rndItemLookKP"""
    text = open(LOOKS, encoding="utf-8").read()
    out = set()
    for block in re.split(r"\n(?=\s*(?:if|else)\b)", text):
        for m in re.finditer(r"sprite_index=(s\w+)", block):
            rest = block[m.end():]
            fr = re.search(r"image_index=(\d+)", rest)
            sp = re.search(r"image_speed=([0-9.]+)", rest)
            anim = sp is not None and float(sp.group(1)) > 0
            out.add((m.group(1), -1 if anim or not fr else int(fr.group(1))))
    return sorted(out)


def box_at(b, x, y, xs=1, ys=1):
    l, t, r, bt = b
    # (mirrored, xscale -1: the sprite's column c at x-c-1)
    xa, xb = sorted((x + l * xs, x + (r + 1) * xs - 1)) if xs >= 0 else sorted((x + (r + 1) * xs, x + l * xs - 1))
    ya, yb = sorted((y + t * ys, y + (bt + 1) * ys - 1))
    return (int(round(xa)), int(round(ya)), int(round(xb)), int(round(yb)))


def rooms():
    """{room: (w, h, [solid boxes], [platform boxes], [(sprite, x, y, frame, place label)])}"""
    out, cur = {}, None
    for line in open(ROOMS_TXT, encoding="utf-8"):
        f = line.rstrip("\n").split("\t")
        if f[0] == "R":
            cur = f[1]; out[cur] = (int(f[2]), int(f[3]), [], [], [])
        elif cur and f[0] in ("S", "P", "L") and len(f) >= 7:
            s = sprite(f[1])
            if not s or not s[1]: continue
            x, y, xs, ys = float(f[2]), float(f[3]), float(f[4]), float(f[5])
            if f[0] == "L":
                out[cur][4].append((f[1], int(round(x)), int(round(y)), " ".join(f[-1:]) if len(f) > 10 else "%s %s" % (f[7], f[8]),
                                    int(f[7])))
            elif float(f[6]) == 0:
                b = box_at(s[1], x, y, xs, ys)
                exact = s[3] if xs != 0 and ys > 0 and xs == int(xs) and ys == int(ys) else None
                out[cur][2 if f[0] == "S" else 3].append(b + (x, y, int(xs), int(ys), exact))
    return out


def solid_at(b, px, py):
    """a solid (its box, where it is, its scale, its precise mask or None) at a pixel"""
    if not (b[0] <= px <= b[2] and b[1] <= py <= b[3]): return False
    if b[8] is None: return True
    lx = (px - b[4]) // b[6] if b[6] > 0 else (px + 1 - b[4]) // b[6]
    return (int(lx), int((py - b[5]) // b[7])) in b[8]


def hit(boxes, a):
    for b in boxes:
        if not (b[0] <= a[2] and a[0] <= b[2] and b[1] <= a[3] and a[1] <= b[3]): continue
        if b[8] is None: return True
        if any(solid_at(b, px, py) for py in range(max(a[1], b[1]), min(a[3], b[3]) + 1)
               for px in range(max(a[0], b[0]), min(a[2], b[2]) + 1)): return True
    return False


def covered(boxes, a):
    """the share of box a's pixels inside the boxes"""
    n = (a[2] - a[0] + 1) * (a[3] - a[1] + 1)
    if n <= 0: return 0.0
    c = 0
    for yy in range(a[1], a[3] + 1):
        for xx in range(a[0], a[2] + 1):
            if any(b[0] <= xx <= b[2] and b[1] <= yy <= b[3] for b in boxes): c += 1
    return c / n


def fit(own, own_frame, look, look_frame, x, y, solids, plats):
    """rndItemFit: where the pickup ends up (x, y)"""
    of, ocb, on = sprite(own)[:3]
    nf, ncb, nn = sprite(look)[:3]
    ou = [b for b in of if b]; nu = [b for b in nf if b]
    union = lambda bs: (min(b[0] for b in bs), min(b[1] for b in bs), max(b[2] for b in bs), max(b[3] for b in bs))
    ol, ot, orr, ob = union(ou) if own_frame < 0 or own_frame >= on or not of[own_frame] else of[own_frame]
    nl, nt, nr, nb = union(nu) if look_frame < 0 or look_frame >= nn or not nf[look_frame] else nf[look_frame]
    under = (x + ol, y + ob - 1, x + orr, y + ob + 3)
    move = hit(solids, under) or hit(plats, under) or (nb > ob and hit(solids, (x + nl, y + ob + 1, x + nr, y + nb)))
    if move: return x + round((ol + orr) / 2 - (nl + nr) / 2), y + ob - nb
    if nt < ot and hit(solids, (x + nl, y + nt, x + nr, y + ot - 1)):
        return x + round((ol + orr) / 2 - (nl + nr) / 2), y + ot - nt
    return x, y


def main():
    lk = looks()
    rs = rooms()
    found, n_spots, n_pairs = [], 0, 0
    per_look = collections.Counter()
    for room in sorted(rs):
        w, h, solids, plats, locs = rs[room]
        for own, x, y, label, kind in locs:
            if kind not in LOOK_TYPES or own in FALLING or not sprite(own): continue
            n_spots += 1
            # (one hidden below the room till a trial is done: fitted where it will be, as rndItemFit does)
            if y >= h: y -= h
            oc = box_at(sprite(own)[1], x, y)
            open_px = [(px, py) for py in range(oc[1], oc[3] + 1) for px in range(oc[0], oc[2] + 1)
                       if not any(solid_at(q, px, py) for q in solids)]
            bad = []
            for look, fr in lk:
                s = sprite(look)
                if not s or not s[1]: continue
                n_pairs += 1
                nx, ny = fit(own, 0 if sprite(own)[2] == 1 else -1, look, fr, x, y, solids, plats)
                # (a story pickup keeps its own sprite's mask: rndStorySpr, the roomStart hook)
                nc = box_at(sprite(own)[1] if kind == STORY else s[1], nx, ny)
                why = []
                # (the player got to the place touching its own box's open pixels: the look's box must take in some)
                if not any(nc[0] <= px <= nc[2] and nc[1] <= py <= nc[3] for px, py in open_px):
                    why.append("its box %d,%d-%d,%d takes in none of its own sprite's box's open pixels" % nc)
                if nc[2] < 0 or nc[3] < 0 or nc[0] >= w or nc[1] >= h: why.append("outside the room")
                if why:
                    bad.append("%s%s at %d,%d: %s" % (look, "" if fr < 0 else " frame %d" % fr, nx, ny, "; ".join(why)))
                    per_look[look] += 1
            if bad:
                found.append("%s %s (at %d,%d, %s; its box %d,%d-%d,%d): %d of %d looks\n    %s"
                             % ((room, label, x, y, own) + oc + (len(bad), len(lk), "\n    ".join(bad))))
    out = ["# Phase F.3, item-spot fit (fitcheck.py): %d places, %d looks; %d places where some look, where rndItemFit "
           "puts it, may be out of the room logic's reach there" % (n_spots, len(lk), len(found)),
           "# by look (places): " + ", ".join("%s %d" % kv for kv in per_look.most_common()), ""] + found
    with open(OUT, "w", encoding="utf-8", newline="\n") as fh: fh.write("\n".join(out) + "\n")
    print(out[0])


if __name__ == "__main__":
    main()
