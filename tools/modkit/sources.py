"""Readers for the mod tools: a game split with gmksplit (GameMaker 8.1 XML) and a GameMaker 8.2 project folder (the
format this project is in)."""
import os, re
import xml.etree.ElementTree as ET

def _read_text(p):
    return open(p, encoding="utf-8", errors="replace").read().replace("\r\n", "\n")

def clean_code(t):
    t = (t or "").replace("\r\n", "\n")
    t = re.sub(r"^/\* !scriptId=\d+ \*/\n?", "", t)
    return t.rstrip("\n")

# GameMaker 8.1 event categories -> (event type number, name prefix in the 8.2 project format)
EV_TYPES = {"CREATE": (0, "Create"), "DESTROY": (1, "Destroy"), "ALARM": (2, "Alarm"), "STEP": (3, "Step"),
            "COLLISION": (4, "Collision"), "KEYBOARD": (5, "Keyboard"), "MOUSE": (6, "Mouse"), "OTHER": (7, "Other"),
            "DRAW": (8, "Draw"), "KEYPRESS": (9, "KeyPress"), "KEYRELEASE": (10, "KeyRelease"), "TRIGGER": (11, "Trigger")}

class GmkSplit:
    """A gmksplit folder. Resources are found by name wherever they are in the folder tree."""
    def __init__(self, root):
        self.root = root
        self.files = {}
        for typ in ("Objects", "Rooms", "Scripts", "Sprites", "Backgrounds", "Fonts", "Paths", "Sounds", "Time Lines"):
            m = {}
            base = os.path.join(root, typ)
            for dp, dn, fn in os.walk(base):
                # an object's events and a sprite's images are in <name>.events / <name>.images: not resources
                if os.path.basename(dp).endswith((".events", ".images")): continue
                for f in fn:
                    if f == "_resources.list.xml": continue
                    for suf in (".xml", ".gml", ".png"):
                        if f.endswith(suf): m.setdefault(f[:-len(suf)], {})[suf] = os.path.join(dp, f)
                for d in dn:
                    for suf in (".events", ".images"):
                        if d.endswith(suf): m.setdefault(d[:-len(suf)], {})[suf] = os.path.join(dp, d)
            self.files[typ] = m

    def names(self, typ):
        return set(self.files[typ])

    def script(self, name):
        return clean_code(_read_text(self.files["Scripts"][name][".gml"]))

    def object(self, name):
        """{'sprite','solid','visible','depth','persistent','parent','mask', 'events': {evname: code}}"""
        e = self.files["Objects"][name]
        r = ET.parse(e[".xml"]).getroot()
        o = {k: (r.findtext(k) or "").strip() for k in ("sprite", "solid", "visible", "depth", "persistent", "parent", "mask")}
        o["events"] = {}
        folder = e.get(".events")
        if folder and os.path.isdir(folder):
            for f in sorted(os.listdir(folder)):
                if not f.endswith(".xml"): continue
                er = ET.parse(os.path.join(folder, f)).getroot()
                cat = er.get("category")
                typ, prefix = EV_TYPES[cat]
                num = er.get("with") if cat == "COLLISION" else er.get("id")
                evname = "%s_%s" % (prefix, num)
                parts = []
                for act in er.iter("action"):
                    if act.get("id") != "603" or (act.findtext("appliesTo") or ".self") != ".self":
                        raise ValueError("%s %s: only code actions applied to self are supported" % (name, f))
                    for a in act.iter("argument"): parts.append(clean_code(a.text))
                o["events"][evname] = "\n".join(parts)
        return o

    def room_id(self, name):
        """the room's index in the game the split came from (gmksplit --preserve-ids keeps it), or None"""
        r = ET.parse(self.files["Rooms"][name][".xml"]).getroot()
        return int(r.get("id")) if r.get("id") is not None else None

    def room(self, name):
        r = ET.parse(self.files["Rooms"][name][".xml"]).getroot()
        d = {"caption": r.findtext("caption") or "", "width": int(r.find("size").get("width")), "height": int(r.find("size").get("height")),
             "speed": int(r.findtext("speed") or 30), "persistent": (r.findtext("persistent") == "true"),
             "code": clean_code(r.findtext("creationCode")), "bgcolor": r.findtext("backgroundColor") or "000000",
             "drawbg": (r.findtext("drawBackgroundColor") == "true"), "views_on": (r.findtext("enableViews") == "true")}
        bgs = []
        for b in r.find("backgrounds"):
            off = b.find("offset").attrib; spd = b.find("speed").attrib
            bgs.append({"visible": b.findtext("visibleOnRoomStart") == "true", "fore": b.findtext("isForeground") == "true",
                        "image": (b.findtext("backgroundImage") or "").strip(), "x": int(off.get("x")), "y": int(off.get("y")),
                        "hspeed": float(spd.get("x")), "vspeed": float(spd.get("y")), "htile": b.findtext("tileHorizontally") == "true",
                        "vtile": b.findtext("tileVertically") == "true", "stretch": b.findtext("stretch") == "true"})
        d["bgs"] = bgs
        views = []
        for v in r.find("views"):
            vr = v.find("viewInRoom").attrib; po = v.find("portOnScreen").attrib; fo = v.find("objectFollowing")
            views.append({"visible": v.findtext("visibleOnRoomStart") == "true", "x": int(vr["x"]), "y": int(vr["y"]), "w": int(vr["width"]),
                          "h": int(vr["height"]), "px": int(po["x"]), "py": int(po["y"]), "pw": int(po["width"]), "ph": int(po["height"]),
                          "hborder": int(fo.get("hBorder")), "vborder": int(fo.get("vBorder")), "hspeed": int(fo.get("hSpeed")),
                          "vspeed": int(fo.get("vSpeed")), "target": (fo.text or "").strip()})
        d["views"] = views
        inst = []
        for i in r.find("instances"):
            p = i.find("position").attrib
            inst.append({"id": int(i.get("id")), "object": i.findtext("object"), "x": int(float(p["x"])), "y": int(float(p["y"])),
                         "code": clean_code(i.findtext("creationCode"))})
        d["instances"] = inst
        tiles = []
        t = r.find("tiles")
        if t is not None:
            for tl in t:
                bp = tl.find("backgroundPosition").attrib; rp = tl.find("roomPosition").attrib; sz = tl.find("size").attrib
                tiles.append({"id": int(tl.get("id")), "bg": tl.findtext("background"), "u": int(bp["x"]), "v": int(bp["y"]),
                              "x": int(rp["x"]), "y": int(rp["y"]), "w": int(sz["width"]), "h": int(sz["height"]),
                              "depth": int(tl.findtext("depth"))})
        d["tiles"] = tiles
        return d

    def sprite(self, name):
        e = self.files["Sprites"][name]
        r = ET.parse(e[".xml"]).getroot()
        o = r.find("origin").attrib; m = r.find("mask"); b = m.find("bounds")
        frames = []
        if ".images" in e:
            fs = [f for f in os.listdir(e[".images"]) if f.endswith(".png")]
            fs.sort(key=lambda s: int(re.findall(r"\d+", s)[0]))
            frames = [os.path.join(e[".images"], f) for f in fs]
        return {"xorig": int(o["x"]), "yorig": int(o["y"]), "separate": m.findtext("separate") == "true",
                "shape": m.findtext("shape"), "mode": b.get("mode"), "tolerance": int(b.get("alphaTolerance") or 0),
                "left": int(b.findtext("left") or 0), "right": int(b.findtext("right") or 0), "top": int(b.findtext("top") or 0),
                "bottom": int(b.findtext("bottom") or 0), "smooth": r.findtext("smoothEdges") == "true",
                "transparent": r.findtext("transparent") == "true", "preload": r.findtext("preload") == "true", "frames": frames}

    def background(self, name):
        e = self.files["Backgrounds"][name]
        r = ET.parse(e[".xml"]).getroot()
        return {"png": e.get(".png"), "smooth": r.findtext("smoothEdges") == "true", "transparent": r.findtext("transparent") == "true"}

    def font(self, name):
        r = ET.parse(self.files["Fonts"][name][".xml"]).getroot()
        return {"face": r.findtext("fontName"), "size": int(r.findtext("size")), "bold": r.findtext("bold") == "true",
                "italic": r.findtext("italic") == "true", "first": int(r.findtext("rangeMin")), "last": int(r.findtext("rangeMax"))}


class Gm82Project:
    """A GameMaker 8.2 project folder (objects/*.gml + *.txt, scripts/*.gml, rooms/<room>/...)."""
    def __init__(self, root):
        self.root = root
        self.names = {}
        for typ, folder in (("Objects", "objects"), ("Scripts", "scripts"), ("Sprites", "sprites"), ("Backgrounds", "backgrounds"),
                            ("Rooms", "rooms"), ("Fonts", "fonts"), ("Paths", "paths"), ("Time Lines", "timelines")):
            p = os.path.join(root, folder, "index.yyd")
            self.names[typ] = set(l.strip() for l in open(p, encoding="utf-8").read().split("\n") if l.strip()) if os.path.exists(p) else set()

    def object_props(self, name):
        p = os.path.join(self.root, "objects", name + ".txt"); d = {}
        for l in _read_text(p).split("\n"):
            if "=" in l:
                k, v = l.split("=", 1); d[k.strip()] = v.strip()
        return d

    def object_events(self, name):
        """{evname: code} with evname like Create_0, Step_2, Collision_oPlayer1, Other_10"""
        p = os.path.join(self.root, "objects", name + ".gml")
        if not os.path.exists(p): return {}
        ev = {}; cur = None; buf = []
        for l in _read_text(p).split("\n"):
            m = re.match(r"^#define (\w+)\s*$", l)
            if m:
                if cur: ev[cur] = "\n".join(buf)
                cur = m.group(1); buf = []
            else: buf.append(l)
        if cur: ev[cur] = "\n".join(buf)
        return ev

    def script(self, name):
        p = os.path.join(self.root, "scripts", name + ".gml")
        return _read_text(p) if os.path.exists(p) else None

    def gid_map(self):
        """{vanilla instance id: (room, object, x, y)} for instances the project registers with GID_SET"""
        out = {}
        rooms = os.path.join(self.root, "rooms")
        for r in os.listdir(rooms):
            rp = os.path.join(rooms, r)
            if not os.path.isdir(rp): continue
            inst = {}
            ip = os.path.join(rp, "instances.txt")
            if os.path.exists(ip):
                for l in _read_text(ip).split("\n"):
                    p = l.split(",")
                    if len(p) >= 4: inst[p[3]] = (p[0], int(float(p[1])), int(float(p[2])))
            for f in os.listdir(rp):
                if not f.endswith(".gml") or f == "code.gml": continue
                for m in re.finditer(r"GID_SET\(\s*(\d+)\s*,", _read_text(os.path.join(rp, f))):
                    o = inst.get(f[:-4])
                    if o: out[int(m.group(1))] = (r,) + o
        return out

    def room_instances(self, room):
        out = []
        ip = os.path.join(self.root, "rooms", room, "instances.txt")
        if os.path.exists(ip):
            for l in _read_text(ip).split("\n"):
                p = l.split(",")
                if len(p) >= 4: out.append({"object": p[0], "x": int(float(p[1])), "y": int(float(p[2])), "name": p[3]})
        return out
