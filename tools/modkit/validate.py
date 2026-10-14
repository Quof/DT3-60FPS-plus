"""
Checks a DT3+ mod folder the way the game's loader (scrModInit and the scripts it calls) reads it, without the game:
names in mod.ini, object.ini, room.txt, instances.txt, tile layers and patch.txt resolve to the game's resources or
the mod's own; event file names are events; patch lines find their instances in the game's rooms; the code's syntax is
GameMaker 8's (gmlcheck.py); and the functions the code calls exist (GameMaker's, the game's scripts, or the mod's
scripts). Code that doesn't compile is a fatal error when the game loads the mod (the game ends), so those are errors.

usage: python validate.py <mod folder> <DT3+ project folder>
"""
import os, re, sys, collections, configparser
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import gml, gmlcheck

HOOKS = {"init", "save", "load", "roomStart", "titleCode", "gameOverHint", "gameOverRetry", "exitPlayer", "drawHUD",
         "playerHit", "mechShield", "drawTitle"}
EVENT_KINDS = {"Create", "Destroy", "Alarm", "Step", "Collision", "Keyboard", "Mouse", "Other", "Draw", "KeyPress",
               "KeyRelease", "Trigger"}

def read(p):
    return open(p, "rb").read().decode("cp1252", "replace").replace("\r\n", "\n")

def index(proj, folder):
    p = os.path.join(proj, folder, "index.yyd")
    return set(l.strip() for l in open(p, encoding="utf-8").read().split("\n") if l.strip()) if os.path.exists(p) else set()

def ini(p):
    c = configparser.RawConfigParser(strict=False, comment_prefixes=(";", "#"), inline_comment_prefixes=None)
    c.optionxform = str
    c.read_string(read(p))
    return c

class Check:
    def __init__(self, mod, proj):
        self.mod, self.proj = mod, proj
        self.err, self.warn = [], []
        self.obj = index(proj, "objects"); self.room = index(proj, "rooms"); self.spr = index(proj, "sprites")
        self.bg = index(proj, "backgrounds"); self.font = index(proj, "fonts"); self.scr = index(proj, "scripts")
        self.mod_scripts = set()
        self.game_funcs = self._game_functions()

    def _game_functions(self):
        """every function the game's own code calls (it compiles, so they exist), plus its scripts"""
        out = set(self.scr)
        for folder in ("objects", "scripts", "rooms"):
            for dp, dn, fn in os.walk(os.path.join(self.proj, folder)):
                for f in fn:
                    if f.endswith(".gml"): out |= self._calls(open(os.path.join(dp, f), encoding="utf-8", errors="replace").read())
        return out

    @staticmethod
    def _calls(code):
        s = [t for t in gml.tokens(code) if t[0] not in ("ws", "cm1", "cm2")]
        out = set()
        for i, (k, t) in enumerate(s[:-1]):
            if k == "id" and s[i + 1] == ("op", "(") and (i == 0 or s[i - 1] != ("op", ".")): out.add(t)
        return out

    def e(self, m): self.err.append(m)
    def w(self, m): self.warn.append(m)

    def run(self):
        m = self.mod
        if not os.path.exists(os.path.join(m, "mod.ini")): self.e("no mod.ini"); return
        mi = ini(os.path.join(m, "mod.ini"))
        # ----- declare (scrModDeclare): objects, rooms, script slots
        objs = sorted(d for d in os.listdir(os.path.join(m, "objects"))) if os.path.isdir(os.path.join(m, "objects")) else []
        self.new_obj = set(o for o in objs if o not in self.obj)
        rooms = sorted(d for d in os.listdir(os.path.join(m, "rooms"))) if os.path.isdir(os.path.join(m, "rooms")) else []
        for r in rooms:
            if r in self.room: self.e("room %s is already one of the game's rooms" % r)
        self.new_room = set(rooms)
        sd = os.path.join(m, "scripts")
        self.mod_scripts = set(f[:-4] for f in os.listdir(sd) if f.endswith(".gml")) if os.path.isdir(sd) else set()
        sp = os.path.join(m, "sprites")
        self.new_spr = set(f[:-4] for f in os.listdir(sp) if f.endswith(".png")) if os.path.isdir(sp) else set()
        bd = os.path.join(m, "backgrounds")
        self.new_bg = set(f[:-4] for f in os.listdir(bd) if f.endswith(".png")) if os.path.isdir(bd) else set()
        fd = os.path.join(m, "fonts")
        self.new_font = set(f[:-4] for f in os.listdir(fd) if f.endswith(".ini")) if os.path.isdir(fd) else set()
        for n in self.new_obj | self.new_room | self.new_spr | self.new_bg | self.new_font:
            if not re.match(r"^[A-Za-z_][A-Za-z0-9_]*$", n): self.e("not usable as a name in code: %s" % n)
        O = self.obj | self.new_obj; R = self.room | self.new_room; S = self.spr | self.new_spr
        B = self.bg | self.new_bg
        self.O, self.R, self.S, self.B = O, R, S, B
        # ----- assets
        for n in self.new_spr:
            if not os.path.exists(os.path.join(sp, n + ".ini")): self.w("sprite %s has no .ini (1 frame, origin 0,0)" % n)
        for sec, d in (("sounds", "sound"), ("music", "music")):
            if mi.has_section(sec):
                miss = []
                for k in range(int(mi.get(sec, "count", fallback="0"))):
                    f = mi.get(sec, "file%d" % k, fallback="")
                    if "#" in f or ";" in f: self.w("[%s] file%d has a # or ; in it: %s" % (sec, k, f))
                    if not os.path.exists(os.path.join(m, d, f)):
                        # a music track whose file isn't there plays the game's track of that number (or nothing), so
                        # a mod can leave its music for the player to add; a sound effect's variable would be missing
                        if sec == "music": miss.append(f)
                        else: self.e("[%s] file%d missing: %s" % (sec, k, f))
                if miss: self.w("[music] %d file(s) not in music\\ (the first: %s): the game's track plays instead, or nothing for a new track number" % (len(miss), miss[0]))
        fb = mi.get("mod", "fallbackRoom", fallback="")
        if fb and fb not in R: self.e("fallbackRoom %s isn't a room" % fb)
        # ----- objects
        for o in objs:
            od = os.path.join(m, "objects", o)
            if os.path.exists(os.path.join(od, "object.ini")):
                oi = ini(os.path.join(od, "object.ini"))
                for key, names, what in (("sprite", S, "sprite"), ("mask", S, "sprite"), ("parent", O, "object"), ("inherit", O, "object")):
                    v = oi.get("object", key, fallback="")
                    if v and v not in names: self.e("%s: %s %s isn't a%s %s" % (o, key, v, "n" if what[0] == "o" else "", what))
                for b in [x for x in oi.get("object", "block", fallback="").split(",") if x]:
                    if not self._event(b, O): self.e("%s: block: not an event: %s" % (o, b))
                for b in [x.strip() for x in oi.get("object", "append", fallback="").split(",") if x.strip()]:
                    if not self._event(b, O): self.e("%s: append: not an event: %s" % (o, b))
                    elif not os.path.exists(os.path.join(od, b + ".gml")): self.w("%s: append names %s, which it has no file for" % (o, b))
                    if o in self.new_obj: self.w("%s: append is for the game's own objects (a new object's events are its own)" % o)
            elif o in self.new_obj: self.w("%s: no object.ini" % o)
            for f in os.listdir(od):
                if f.endswith(".gml"):
                    if not self._event(f[:-4], O): self.e("%s: not an event: %s" % (o, f))
                    self.code(read(os.path.join(od, f)), "objects/%s/%s" % (o, f))
        # ----- scripts (one named like the game's replaces it: only those scrModInit's modOvrList names can be)
        ovr = self._override_list()
        for s in self.mod_scripts:
            if s in self.scr and s not in ovr: self.e("scripts/%s.gml: the game's script %s can't be replaced (it isn't in scrModInit's modOvrList)" % (s, s))
            self.code(read(os.path.join(sd, s + ".gml")), "scripts/%s.gml" % s)
        for o in objs:
            p = os.path.join(m, "objects", o, "object.ini")
            if os.path.exists(p) and ini(p).get("object", "legacy", fallback="0") not in ("0", "1"): self.e("%s: legacy must be 0 or 1" % o)
        # ----- rooms
        for r in rooms: self.room_check(r)
        # ----- patches
        pd = os.path.join(m, "patches")
        if os.path.isdir(pd):
            for r in sorted(os.listdir(pd)): self.patch_check(r)
        # ----- the game's events mods can replace without clearing them (scrModEvInit's list, addevoverride.py), and
        # the events this mod replaces by clearing them that take long to clear (many objects inherit from the object)
        if os.path.exists(os.path.join(self.proj, "scripts", "scrModEvInit.gml")):
            import addevoverride
            for x in addevoverride.check(self.proj): self.e("the game's events mods can replace without clearing them: %s (python addevoverride.py <project> --check)" % x)
            listed = set(addevoverride.get_list(self.proj)[0])
            for o in objs:
                for f in os.listdir(os.path.join(m, "objects", o)):
                    if f.endswith(".gml") and "global.modEvOvr[" in read(os.path.join(m, "objects", o, f)):
                        self.e("objects/%s/%s has the game's line that runs a mod's version of an event (global.modEvOvr): a mod's version must not have it (made from the game's event with it? mergemod.dt3_event leaves it out)" % (o, f))
            kids = self._descendants()
            for o in objs:
                if o in self.new_obj or kids.get(o, 0) < 50: continue
                p = os.path.join(m, "objects", o, "object.ini")
                kv = dict(l.split("=", 1) for l in read(p).split("\n") if "=" in l) if os.path.exists(p) else {}
                app = set(x.strip() for x in kv.get("append", "").split(",") if x.strip())
                for f in os.listdir(os.path.join(m, "objects", o)):
                    ev = f[:-4]
                    if not f.endswith(".gml") or kv.get("events") == "append" or ev in app or (o, ev) in listed: continue
                    self.w("objects/%s/%s replaces the game's event by clearing it, which takes long when the mod loads (%d objects inherit from %s): append to it if it can be (object.ini append), or make it one mods can replace without clearing (addevoverride.py)" % (o, f, kids[o], o))
        # ----- hooks
        hd = os.path.join(m, "hooks")
        if os.path.isdir(hd):
            for f in sorted(os.listdir(hd)):
                if not f.endswith(".gml"): continue
                if f[:-4] not in HOOKS: self.w("hooks/%s: the game has no hook named %s" % (f, f[:-4]))
                self.code(read(os.path.join(hd, f)), "hooks/" + f)

    def _descendants(self):
        """{object: how many of the game's objects inherit from it} (the project's objects' parent= settings)"""
        par = {}
        od = os.path.join(self.proj, "objects")
        for f in os.listdir(od):
            if f.endswith(".txt"):
                for l in read(os.path.join(od, f)).split("\n"):
                    if l.startswith("parent="): par[f[:-4]] = l[7:].strip()
        out = collections.Counter()
        for o in par:
            p, seen = par[o], set()
            while p and p not in seen:
                seen.add(p); out[p] += 1; p = par.get(p, "")
        return out

    def _override_list(self):
        """the game's scripts a mod can replace (scrModInit's global.modOvrList)"""
        p = os.path.join(self.proj, "scripts", "scrModInit.gml")
        mm = re.search(r'global\.modOvrList\s*=\s*"([^"]*)"', read(p)) if os.path.exists(p) else None
        return set(x.strip() for x in mm.group(1).split(",")) if mm else set()

    def _event(self, name, O):
        mm = re.match(r"^([A-Za-z]+)_(\w+)$", name)
        if not mm or mm.group(1) not in EVENT_KINDS: return False
        if mm.group(1) == "Collision": return mm.group(2) in O
        return mm.group(2).isdigit()

    def room_check(self, r):
        rd = os.path.join(self.mod, "rooms", r)
        kv = dict(l.split("=", 1) for l in read(os.path.join(rd, "room.txt")).split("\n") if "=" in l) if os.path.exists(os.path.join(rd, "room.txt")) else {}
        if not kv: self.e("%s: no room.txt" % r)
        for k, v in kv.items():
            if k.startswith("bg_source") and v and v not in self.B: self.e("%s: %s %s isn't a background" % (r, k, v))
            if k.startswith("view_fol_target") and v and v not in self.O: self.e("%s: %s %s isn't an object" % (r, k, v))
        names = set()
        ip = os.path.join(rd, "instances.txt")
        if os.path.exists(ip):
            for l in read(ip).split("\n"):
                if not l: continue
                p = l.split(",")
                if len(p) < 4: self.e("%s: bad instance line %r" % (r, l)); continue
                if p[0] not in self.O: self.e("%s: instance object %s doesn't exist" % (r, p[0]))
                if not re.match(r"^[0-9A-F]{8}$", p[3]): self.e("%s: instance name %s isn't 8 hex digits" % (r, p[3]))
                names.add(p[3])
        for f in os.listdir(rd):
            if f.endswith(".gml"):
                if f != "code.gml" and f[:-4] not in names: self.w("%s: %s belongs to no instance" % (r, f))
                self.code(read(os.path.join(rd, f)), "rooms/%s/%s" % (r, f))
        lp = os.path.join(rd, "layers.txt")
        if os.path.exists(lp):
            for dep in [l for l in read(lp).split("\n") if l]:
                tp = os.path.join(rd, dep + ".txt")
                if not os.path.exists(tp): self.e("%s: layer %s has no file" % (r, dep)); continue
                for l in read(tp).split("\n"):
                    if l and l.split(",")[0] not in self.B: self.e("%s: tile background %s doesn't exist" % (r, l.split(",")[0]))

    def patch_check(self, r):
        pd = os.path.join(self.mod, "patches", r)
        if r not in self.R: self.e("patch for a room that doesn't exist: %s" % r); return
        if not os.path.exists(os.path.join(pd, "patch.txt")): self.e("patches/%s: no patch.txt" % r); return
        # the room's instances in DT3+, as (object, xstart, ystart), as the lines change them
        inst = []
        ip = os.path.join(self.proj, "rooms", r, "instances.txt")
        if os.path.exists(ip):
            for l in read(ip).split("\n"):
                p = l.split(",")
                if len(p) >= 4: inst.append([p[0], int(float(p[1])), int(float(p[2]))])
        used_files = set()
        for n, l in enumerate(read(os.path.join(pd, "patch.txt")).split("\n"), 1):
            if not l or l.startswith("#"): continue
            p = l.split("|"); k = p[0]; where = "patches/%s line %d" % (r, n)
            def codefile(f):
                if f in ("-", ""): return
                used_files.add(f)
                if not os.path.exists(os.path.join(pd, f)): self.e("%s: no file %s" % (where, f))
                else: self.code(read(os.path.join(pd, f)), "patches/%s/%s" % (r, f))
            if k == "roomcode" or k == "roomcodeset":
                if len(p) < 2: self.e("%s: bad line" % where); continue
                codefile(p[1]); continue
            # lines that change the room itself (scrModLoadPatches)
            if k == "caption": continue
            if k == "roomsize" or k == "roomcolor":
                if len(p) < 3 or not all(re.match(r"^-?\d+(\.\d+)?$", v) for v in p[1:3]): self.e("%s: bad line %r" % (where, l))
                continue
            if k == "roombg":
                if len(p) < 11: self.e("%s: bad line %r" % (where, l))
                elif p[4] not in ("", "-") and p[4] not in self.B: self.e("%s: no background %s" % (where, p[4]))
                continue
            if k == "tileadd":
                if len(p) < 9: self.e("%s: bad line" % where)
                elif p[1] not in self.B: self.e("%s: no background %s" % (where, p[1]))
                continue
            if k == "tileremove":
                if len(p) < 4: self.e("%s: bad line" % where)
                continue
            if k not in ("add", "remove", "move", "code", "precode", "gid") or len(p) < 4: self.e("%s: bad line %r" % (where, l)); continue
            if p[1] not in self.O: self.e("%s: no object %s" % (where, p[1])); continue
            x, y = int(p[2]), int(p[3])
            if k == "add":
                if len(p) < 6: self.e("%s: bad add line" % where); continue
                codefile(p[5]); inst.append([p[1], x, y]); continue
            hits = [i for i in inst if i[0] == p[1] and i[1] == x and i[2] == y]
            if not hits: self.e("%s: %s finds no %s at %d,%d in the game's room" % (where, k, p[1], x, y)); continue
            if k == "remove":
                for h in hits: inst.remove(h)
            elif k == "move":
                if len(p) < 6: self.e("%s: bad move line" % where); continue
                for h in hits: h[1], h[2] = int(p[4]), int(p[5])
            elif k == "code" or k == "precode":
                if len(p) < 5: self.e("%s: bad %s line" % (where, k)); continue
                codefile(p[4])
            elif k == "gid":
                if len(p) < 5: self.e("%s: bad gid line" % where)
        for f in os.listdir(pd):
            if f != "patch.txt" and f not in used_files: self.w("patches/%s/%s isn't used by a line" % (r, f))

    def code(self, text, where):
        for line, msg in gmlcheck.check(text): self.e("%s line %d: doesn't compile: %s" % (where, line, msg))
        toks = gml.tokens(text)
        # brackets, outside strings and comments
        stack = []
        for k, t in toks:
            if k == "cm2" and not t.endswith("*/"): self.e("%s: comment not closed" % where)
            if k == "str" and (len(t) < 2 or t[-1] != t[0]): self.e("%s: string not closed" % where)
            if k != "op": continue
            if t in "([{": stack.append(t)
            elif t in ")]}":
                if not stack or "([{"[")]}".index(t)] != stack[-1]: self.e("%s: unbalanced %s" % (where, t)); break
                stack.pop()
        if stack: self.e("%s: unclosed %s" % (where, "".join(stack)))
        # GameMaker 8.2 stops on a call to a script with another number of arguments than the script reads (the mod's
        # own scripts are called through scrModCall, which gives them what they take)
        takes = self.script_takes()
        for name, given, line in gml.call_arg_counts(text, takes):
            if name not in self.mod_scripts and given != takes[name]:
                self.e("%s line %d: %s given %d argument(s), the game's script takes %d (the game stops on that)" % (where, line, name, given, takes[name]))
        for f in self._calls(text):
            if f not in self.game_funcs and f not in self.mod_scripts and f not in self.KNOWN:
                self.unknown_calls[f].append(where)

    _takes = None
    def script_takes(self):
        """{script: arguments} for the game's scripts that take a set number"""
        if self._takes is None:
            self._takes = {}
            for n in self.scr:
                p = os.path.join(self.proj, "scripts", n + ".gml")
                if not os.path.exists(p): continue
                k, anyn = gml.script_arg_count(read(p))
                if not anyn: self._takes[n] = k
        return self._takes

    # GameMaker 8 functions the game's own code never calls (checked against the manual)
    KNOWN = {"distance_to_point", "move_towards_point", "string_format", "draw_vertex", "ini_key_exists"}
    unknown_calls = collections.defaultdict(list)

if __name__ == "__main__":
    c = Check(sys.argv[1], sys.argv[2]); c.run()
    for x in c.err: print("ERROR", x)
    for x in c.warn: print("warning", x)
    for f, w in sorted(c.unknown_calls.items()):
        print("CALL %s (not called by the game's own code; is it a GameMaker 8 function?) in %s%s" % (f, ", ".join(w[:3]), " ..." if len(w) > 3 else ""))
    print("%d errors, %d warnings, %d functions to check" % (len(c.err), len(c.warn), len(c.unknown_calls)))
