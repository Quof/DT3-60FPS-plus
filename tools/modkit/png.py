"""Minimal PNG reader/writer (standard library only) for the mod tools: reads 8-bit grey, grey+alpha, RGB, RGBA and
palette images (bit depths 1-8 for palette/grey), always returning RGBA rows; writes RGBA."""
import struct, zlib

def _paeth(a, b, c):
    p = a + b - c
    pa, pb, pc = abs(p - a), abs(p - b), abs(p - c)
    if pa <= pb and pa <= pc: return a
    if pb <= pc: return b
    return c

def read(path):
    """Returns (width, height, rows) where rows is a list of bytearrays of width*4 RGBA bytes."""
    data = open(path, "rb").read()
    if data[:8] != b"\x89PNG\r\n\x1a\n":
        raise ValueError("not a PNG: %s" % path)
    pos = 8; idat = []; palette = None; trns = None
    w = h = depth = ctype = interlace = None
    while pos < len(data):
        ln, typ = struct.unpack(">I4s", data[pos:pos + 8]); chunk = data[pos + 8:pos + 8 + ln]; pos += 12 + ln
        if typ == b"IHDR":
            w, h, depth, ctype, _, _, interlace = struct.unpack(">IIBBBBB", chunk)
        elif typ == b"PLTE": palette = chunk
        elif typ == b"tRNS": trns = chunk
        elif typ == b"IDAT": idat.append(chunk)
        elif typ == b"IEND": break
    if interlace: raise ValueError("interlaced PNG not supported: %s" % path)
    raw = zlib.decompress(b"".join(idat))
    chans = {0: 1, 2: 3, 3: 1, 4: 2, 6: 4}[ctype]
    bpp_bits = chans * depth
    stride = (w * bpp_bits + 7) // 8
    bpp = max(1, bpp_bits // 8)
    rows = []; prev = bytearray(stride); i = 0
    for _ in range(h):
        f = raw[i]; line = bytearray(raw[i + 1:i + 1 + stride]); i += 1 + stride
        if f == 1:
            for x in range(bpp, stride): line[x] = (line[x] + line[x - bpp]) & 255
        elif f == 2:
            for x in range(stride): line[x] = (line[x] + prev[x]) & 255
        elif f == 3:
            for x in range(stride): line[x] = (line[x] + ((line[x - bpp] if x >= bpp else 0) + prev[x]) // 2) & 255
        elif f == 4:
            for x in range(stride): line[x] = (line[x] + _paeth(line[x - bpp] if x >= bpp else 0, prev[x], prev[x - bpp] if x >= bpp else 0)) & 255
        rows.append(line); prev = line
    out = []
    for line in rows:
        o = bytearray(w * 4)
        if depth == 8:
            for x in range(w):
                if ctype == 6: o[x*4:x*4+4] = line[x*4:x*4+4]
                elif ctype == 2:
                    r, g, b = line[x*3:x*3+3]; a = 255
                    if trns and len(trns) >= 6 and (r, g, b) == (trns[1], trns[3], trns[5]): a = 0
                    o[x*4:x*4+4] = bytes((r, g, b, a))
                elif ctype == 0:
                    v = line[x]; a = 0 if (trns and len(trns) >= 2 and v == trns[1]) else 255
                    o[x*4:x*4+4] = bytes((v, v, v, a))
                elif ctype == 4:
                    v, a = line[x*2], line[x*2+1]; o[x*4:x*4+4] = bytes((v, v, v, a))
                elif ctype == 3:
                    p = line[x]; o[x*4:x*4+3] = palette[p*3:p*3+3]; o[x*4+3] = trns[p] if (trns and p < len(trns)) else 255
        elif depth == 16:
            for x in range(w):
                px = [line[(x*chans+c)*2] for c in range(chans)]
                if ctype == 6: o[x*4:x*4+4] = bytes(px)
                elif ctype == 2: o[x*4:x*4+4] = bytes(px + [255])
                elif ctype == 0: o[x*4:x*4+4] = bytes([px[0]] * 3 + [255])
                elif ctype == 4: o[x*4:x*4+4] = bytes([px[0]] * 3 + [px[1]])
        else:
            per = 8 // depth; mask = (1 << depth) - 1
            for x in range(w):
                v = (line[x // per] >> ((per - 1 - x % per) * depth)) & mask
                if ctype == 3:
                    o[x*4:x*4+3] = palette[v*3:v*3+3]; o[x*4+3] = trns[v] if (trns and v < len(trns)) else 255
                else:
                    g = v * 255 // mask; o[x*4:x*4+4] = bytes((g, g, g, 255))
        out.append(o)
    return w, h, out

def write(path, w, h, rows):
    raw = bytearray()
    for r in rows:
        raw.append(0); raw.extend(r)
    def chunk(t, d):
        return struct.pack(">I", len(d)) + t + d + struct.pack(">I", zlib.crc32(t + d) & 0xffffffff)
    png = b"\x89PNG\r\n\x1a\n" + chunk(b"IHDR", struct.pack(">IIBBBBB", w, h, 8, 6, 0, 0, 0)) + \
          chunk(b"IDAT", zlib.compress(bytes(raw), 9)) + chunk(b"IEND", b"")
    open(path, "wb").write(png)

def strip(frames):
    """frames: list of (w, h, rows), all the same size. Returns (w*n, h, rows) laid out left to right."""
    w, h = frames[0][0], frames[0][1]
    rows = []
    for y in range(h):
        r = bytearray()
        for fw, fh, fr in frames:
            if fw != w or fh != h: raise ValueError("frames differ in size")
            r.extend(fr[y])
        rows.append(r)
    return w * len(frames), h, rows

def pixels_equal(a, b):
    return a[0] == b[0] and a[1] == b[1] and all(x == y for x, y in zip(a[2], b[2]))
