"""
Converts a DT3 mod that was made as an edited copy of the game (split with gmksplit) into a DT3+ mod folder (see
Mods/README.txt for the format):
  - new rooms, objects, scripts, sprites, backgrounds and fonts
  - patches for the original rooms it changed (instances added, removed, moved or given extra creation code, extra room
    creation code, tiles added or removed)
  - copies ("clones", <name>__AI style suffix from the config) of the original objects it changed that its new content
    uses, so the changes only apply to that content and the original objects stay as they are in DT3+
  - the sound effects and music it adds, and its new music tracks, locations and sounds (from the config)
Changes to the original scripts and to the game's own system objects can't be expressed as mod files. They're listed in
report.txt and kept in unported/ (the mod's version and a diff against the original) to be ported by hand, as hooks.
A mod whose changes to the game's scripts and objects were merged into DT3+'s versions (mergemod.py, the config's
"merge" section) has those merged versions in it instead, replacing the game's.

Config keys for a mod made into more than one DT3+ mod (as Altered Insanity is: Virtual Insanity and Altered Beast):
  select_new        {"code": [folders], "rooms": [rooms]}: only the new resources this code (and these rooms, and what
                    the room patches add) uses, and what those use in turn
  drop_new_of       another config: its selected new resources are left out, except those this mod's own rooms, room
                    patches and extras use too
  new_objects_legacy  1: the new objects are 30fps code (object.ini legacy=1) in a mod that's otherwise DT3+ code
  patch_rooms       the original rooms to patch (default: every one the mod changed)
  rename_sprites    {"the game's sprite": "new name"}: the mod's version of a sprite of the game's, under a name of its own
  edits             {"where": [["old text", "new text"], ...]}: changes to the mod's code, where being as report.txt
                    names it (an object's event "oName/Step_0", "script name", "<room> instance <id>"...)
  clones, unported  false: no clones of the original objects (a merged mod's are merged instead), no unported folder
  ported            folder (default: ported) of the mod's objects and scripts ported to DT3+'s 60fps code by hand:
                    ported/objects/<name as written>/<event>.gml (all its events) and ported/scripts/<name>.gml. They're
                    used instead of the mod's own, as DT3+ code (not 30fps code: object.ini legacy=0 in a 30fps mod)

usage: python convert.py config.json
"""
import os, sys, re, json, shutil, difflib, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import png, gml, merge3, gmlcheck
from sources import GmkSplit, Gm82Project

def enc(text):
    """The game reads these files with GameMaker 8's file functions, which take ANSI text: Windows-1252, with any
    character it doesn't have kept as its UTF-8 bytes (the way the split had it; such a character ends up in a text
    file the game writes as it was, e.g. Mystery.txt)"""
    out = bytearray()
    for ch in text:
        try: out += ch.encode("cp1252")
        except UnicodeEncodeError: out += ch.encode("utf-8")
    return bytes(out)

def wtext(path, text):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    open(path, "wb").write(enc(text.replace("\r\n", "\n").replace("\n", "\r\n")))

# gm82core's code_compile turns 'return' into its own code wherever it comes after a space or one of {}(); and before a
# space or one of (+- -- inside strings too. A string with such a 'return' in it is split there ("..."+"return...") so
# the text stays as it is
_RET_IN_STR = re.compile(r"(?<=[\s{}();])return(?=[ (+\-])")
def protect_strings(code):
    toks = gml.tokens(code); changed = 0
    for i, (k, t) in enumerate(toks):
        if k == "str" and _RET_IN_STR.search(t):
            q = t[0]
            toks[i] = (k, _RET_IN_STR.sub(q + "+" + q + "return", t)); changed += 1
    return gml.join(toks), changed

def norm(code):
    return "\n".join(l.rstrip() for l in (code or "").replace("\r\n", "\n").split("\n")).strip("\n")

def appended(old, new):
    """If new is old with lines added at the end (blank lines ignored at the join), the added part, else None"""
    o, n = norm(old).split("\n"), norm(new).split("\n")
    if norm(old) == "": return norm(new)
    if n[:len(o)] == o: return "\n".join(n[len(o):]).strip("\n")
    return None

# the order a patch's lines are written in (scrModRoomPatch runs them in order): tiles; instances taken out, then moved
# (later lines find a moved instance at its new place, where the mod has it), then given to GID() and added (so code
# that refers to them finds them), then extra creation code, then extra room code
OP_ORDER = ("tileremove", "tileadd", "remove", "move", "gid", "add", "code", "roomcode")

class Converter:
    def __init__(self, cfg):
        self.cfg = cfg
        self.mod = GmkSplit(cfg["mod"]); self.van = GmkSplit(cfg["vanilla"]); self.proj = Gm82Project(cfg["project"])
        self.out = cfg["out"]; self.suffix = cfg.get("clone_suffix", "__AI")
        self.report = collections.defaultdict(list)
        self.warn = []
        self.mod_legacy = int(cfg["mod_ini"]["mod"].get("legacy", 0)) == 1
        self.edits_used = set()
        self.compile_errors = []
        self.arg_errors = []
        self._takes = None

    # ---------------------------------------------------------------- what changed
    def survey(self):
        cfg = self.cfg
        self.new = {}; self.new_all = {}
        for typ in ("Rooms", "Objects", "Scripts", "Sprites", "Backgrounds", "Fonts"):
            self.new_all[typ] = sorted(self.mod.names(typ) - self.van.names(typ))
            self.new[typ] = sorted(set(self.new_all[typ]) - set(cfg.get("exclude", {}).get(typ, [])))
        # objects really changed (code or properties)
        self.changed_objects = {}
        for n in sorted(self.mod.names("Objects") & self.van.names("Objects")):
            a, b = self.van.object(n), self.mod.object(n)
            pa = {k: a[k] for k in a if k != "events"}; pb = {k: b[k] for k in b if k != "events"}
            ea = {k: norm(v) for k, v in a["events"].items()}; eb = {k: norm(v) for k, v in b["events"].items()}
            if pa != pb or ea != eb: self.changed_objects[n] = (a, b)
        self.changed_scripts = {}
        for n in sorted(self.mod.names("Scripts") & self.van.names("Scripts")):
            a, b = self.van.script(n), self.mod.script(n)
            if norm(a) != norm(b): self.changed_scripts[n] = (a, b)
        # every instance id in the mod's rooms (new and original), for turning instance id literals into GID() lookups
        self.inst_where = {}
        for r in self.mod.names("Rooms"):
            for i in self.mod.room(r)["instances"]: self.inst_where[i["id"]] = (r, i["object"], i["x"], i["y"])
        self.project_gid = self.proj.gid_map()

    # ---------------------------------------------------------------- which new resources
    def _refs(self, typ, name):
        """(code, other names) of one of the mod's resources: what it can refer to"""
        if typ in ("Objects", "Changed"):
            ob = self.mod.object(name)
            return "\n".join(ob["events"].values()), {ob["sprite"], ob["mask"], ob["parent"]}
        if typ == "Scripts": return self.mod.script(name), set()
        if typ == "Rooms":
            d = self.mod.room(name)
            names = set(i["object"] for i in d["instances"]) | set(t["bg"] for t in d["tiles"])
            names |= set(b["image"] for b in d["bgs"]) | set(v["target"] for v in d["views"])
            return "\n".join([d["code"]] + [i["code"] for i in d["instances"]]), names
        return "", set()

    def closure(self, code, names=(), follow_changed=False):
        """{name: type} of the new resources code and names use, and those use in turn (through their code, parents,
        sprites, rooms' contents). follow_changed: also through the mod's versions of the original objects it changed
        (which clones copy)"""
        where = {n: t for t, ns in self.new_all.items() for n in ns}
        if follow_changed:
            for n in self.changed_objects:
                if n not in self.cfg.get("no_clone", []): where.setdefault(n, "Changed")
        got = {}
        todo = [x for x in gml.identifiers(code or "") | set(names) if x in where]
        while todo:
            n = todo.pop()
            if n in got: continue
            got[n] = where[n]
            c, nm = self._refs(where[n], n)
            todo += [x for x in gml.identifiers(c or "") | nm if x in where and x not in got]
        return {n: t for n, t in got.items() if t != "Changed"}

    def _folder_text(self, folder):
        out = []
        if folder and os.path.isdir(folder):
            for dp, dn, fn in os.walk(folder):
                for f in sorted(fn):
                    if f.endswith((".gml", ".txt", ".ini")):
                        out.append(open(os.path.join(dp, f), encoding="utf-8", errors="replace").read())
        return "\n".join(out)

    @staticmethod
    def _inst_wanted(rule, iid):
        if "only_instances" in rule: return iid in rule["only_instances"]
        return iid not in rule.get("skip_instances", [])

    @staticmethod
    def _tile_wanted(rule, tid):
        if rule.get("skip_tiles"): return False
        if "only_tile_ids" in rule: return tid in rule["only_tile_ids"]
        return tid not in rule.get("skip_tile_ids", [])

    def _patch_seed(self):
        """(code, names) the room patches bring in: the instances they add or give code, the room code they add"""
        code, names = [], set()
        only = self.cfg.get("patch_rooms")
        for n in sorted(self.mod.names("Rooms") & self.van.names("Rooms")):
            rule = self.cfg.get("patch_rules", {}).get(n, {})
            if (only is not None and n not in only) or rule.get("skip"): continue
            a, b = self.van.room(n), self.mod.room(n)
            ia = {i["id"]: i for i in a["instances"]}
            for i in b["instances"]:
                j = ia.get(i["id"])
                if not self._inst_wanted(rule, i["id"]) or (j is not None and norm(j["code"]) == norm(i["code"])): continue
                if j is None: names.add(i["object"])
                if i["id"] not in rule.get("skip_code", []): code.append(i["code"])
            if rule.get("room_code") is not None: code.append(rule["room_code"])
            elif norm(a["code"]) != norm(b["code"]): code.append(b["code"])
            code += list(rule.get("extra_files", {}).values())
            ta = {t["id"]: t for t in a["tiles"]}
            names |= set(t["bg"] for t in b["tiles"] if self._tile_wanted(rule, t["id"]) and ta.get(t["id"]) != t)
        return "\n".join(code), names

    def select_new(self):
        """narrows the new resources down to what the mod uses (select_new), and leaves out another mod's (drop_new_of)"""
        cfg = self.cfg
        sel = cfg.get("select_new")
        if sel:
            code = "\n".join(self._folder_text(os.path.join(cfg["_base"], f)) for f in sel.get("code", []))
            pc, pn = self._patch_seed()
            keep = self.closure(code + "\n" + pc, set(sel.get("rooms", [])) | pn)
            for t in self.new: self.new[t] = [n for n in self.new[t] if n in keep]
        other = cfg.get("drop_new_of")
        if other:
            oc = Converter(load_config(os.path.join(cfg["_base"], other)))
            oc.survey(); oc.select_new()
            theirs = set(n for ns in oc.new.values() for n in ns)
            pc, pn = self._patch_seed()
            mine = self.closure(self._folder_text(cfg.get("extras")) + "\n" + pc, (set(self.new["Rooms"]) - theirs) | pn, follow_changed=True)
            for t in self.new:
                gone = [n for n in self.new[t] if n in theirs and n not in mine]
                if gone:
                    self.new[t] = [n for n in self.new[t] if n not in gone]
                    self.report["left out, as %s has them (%s)" % (oc.cfg["mod_ini"]["mod"]["name"], t)].append(", ".join(gone))

    def _obj_legacy(self, name):
        """whether an object's code is 30fps code (not if it's been ported: see ported_dir)"""
        if self.ported_events(name) is not None: return False
        if self.mod_legacy: return True
        return bool(self.cfg.get("new_objects_legacy")) and name in self.new["Objects"]

    def ported_dir(self):
        return os.path.join(self.cfg["_base"], self.cfg.get("ported", "ported"))

    def ported_events(self, name):
        """{event: code} of an object ported to 60fps code by hand (ported/objects/<name>/), or None"""
        d = os.path.join(self.ported_dir(), "objects", name)
        if not os.path.isdir(d): return None
        return {f[:-4]: open(os.path.join(d, f), encoding="utf-8").read() for f in sorted(os.listdir(d)) if f.endswith(".gml")}

    def ported_script(self, name):
        p = os.path.join(self.ported_dir(), "scripts", name + ".gml")
        return open(p, encoding="utf-8").read() if os.path.exists(p) else None

    # ---------------------------------------------------------------- clones
    def plan_clones(self):
        cfg = self.cfg; system = set(cfg.get("no_clone", []))
        changed = set(self.changed_objects)
        used = set()
        for r in self.new["Rooms"]:
            d = self.mod.room(r)
            for i in d["instances"]:
                if i["object"] in changed: used.add(i["object"])
            codes = [d["code"]] + [i["code"] for i in d["instances"]]
            for c in codes: used |= self._created_in(c)
        for o in self.new["Objects"]:
            ob = self.mod.object(o)
            for c in ob["events"].values(): used |= self._created_in(c)
            if ob["parent"] in changed: used.add(ob["parent"])
        for s in self.new["Scripts"]: used |= self._created_in(self.mod.script(s))
        used &= changed
        if self.cfg.get("clones", True) is False:
            # (the original objects the mod changed are merged into DT3+'s instead, or left as DT3+ has them)
            merged = set()
            md = os.path.join(self.cfg["_base"], self.cfg.get("merge", {}).get("merged", "merged"), "objects")
            if os.path.isdir(md): merged = set(os.listdir(md))
            self.clones = []; self.clone_map = {}
            self.clone_skipped = sorted(used - merged)
            return
        # and what the clones make and inherit from, in turn: their code is the mod's, so the changed objects it creates
        # are the mod's versions too, and a changed parent's events are the mod's (a clone's event_inherited() runs its
        # clone)
        frontier = set(o for o in used if o not in system)
        while frontier:
            nxt = set()
            for o in frontier:
                ob = self.mod.object(o)
                for c in ob["events"].values(): nxt |= self._created_in(c)
                if ob["parent"] in changed: nxt.add(ob["parent"])
            nxt = (nxt & changed) - used
            used |= nxt
            frontier = set(o for o in nxt if o not in system)
        self.clones = sorted(o for o in used if o not in system)
        self.clone_skipped = sorted(o for o in used if o in system)
        self.clone_map = {o: o + self.suffix for o in self.clones}

    # functions that make an instance of an object given as an argument (delaySpawn: the game's delayed enemy spawner)
    CREATORS = ("instance_create", "instance_change", "delaySpawn")

    def _created_in(self, code):
        out = set(); toks = gml.tokens(code or ""); depth = 0
        for i, (k, t) in enumerate(toks):
            if k == "id" and t in self.CREATORS:
                # arguments up to the matching ')'
                j = i + 1; level = 0
                while j < len(toks):
                    kk, tt = toks[j]
                    if tt == "(": level += 1
                    elif tt == ")":
                        level -= 1
                        if level == 0: break
                    elif kk == "id" and level >= 1 and tt in self.changed_objects: out.add(tt)
                    j += 1
        return out

    def _rename_created(self, code):
        if not self.clone_map: return code
        toks = gml.tokens(code); i = 0
        while i < len(toks):
            k, t = toks[i]
            if k == "id" and t in self.CREATORS:
                j = i + 1; level = 0
                while j < len(toks):
                    kk, tt = toks[j]
                    if tt == "(": level += 1
                    elif tt == ")":
                        level -= 1
                        if level == 0: break
                    elif kk == "id" and level >= 1 and tt in self.clone_map: toks[j] = (kk, self.clone_map[tt])
                    j += 1
                i = j
            i += 1
        return gml.join(toks)

    # ---------------------------------------------------------------- code rewriting
    def fix_code(self, code, where, legacy=None, ported=False):
        """code readied for the mod folder. legacy: whether it's 30fps code (default: the mod's setting). ported: code
        ported by hand (ported/), which already has the config's edits for it"""
        if legacy is None: legacy = self.mod_legacy
        code = code or ""
        # the config's changes to this code (made first, so they're written against the mod's own text)
        for old, new in ([] if ported else self.cfg.get("edits", {}).get(where, [])):
            if old not in code: raise SystemExit("edits: %s doesn't have %r" % (where, old))
            code = code.replace(old, new)
            self.edits_used.add(where)
            self.report["changed by hand (the config's edits)"].append(where)
        if ported and where in self.cfg.get("edits", {}): self.edits_used.add(where)
        code = gml.normalize_event_inherited(code)
        if legacy:
            # a 30fps mod's code runs on 30fps ticks, where oGame.time (the game's frames) goes up 2 or 4 a tick at
            # 60/120fps; oGame.time30 counts 30fps ticks, as oGame.time did in the original
            code, c = gml.rename_member(code, "oGame", "time", "time30")
            if c: self.report["30fps code: oGame.time read as oGame.time30 (30fps ticks)"].append("%s (%d)" % (where, c))
        def gid(n):
            if n >= 100000 and n in self.inst_where:
                room = self.inst_where[n][0]
                if room not in self.new["Rooms"] and n not in self.project_gid:
                    self.gid_needed.setdefault(room, set()).add(n)
                return "GID(%d)" % n
            return None
        # only an id alone in brackets is an instance: numbers like maxLife=300000 can be the same as some instance's id
        code, c = gml.rewrite_paren_numbers(code, gid)
        if c: self.report["instance id literals turned into GID() lookups"].append("%s (%d)" % (where, c))
        code = self._rename_created(code)
        for rule in self.cfg.get("assign_rules", []):
            def fn(num, rule=rule):
                v = rule["values"].get(num)
                return v
            code, c = gml.replace_assign(code, rule["name"], fn)
            if c: self.report["rewritten: %s" % rule["why"]].append(where)
        for a, b in self.cfg.get("text_rules", []):
            if a in code:
                code = code.replace(a, b); self.report["rewritten: %s -> %s" % (a, b)].append(where)
        # GameMaker 8.2 stops on a call to a script with another number of arguments than the script reads (GameMaker 8.1
        # let extra ones go): a call to one of the game's scripts with more than DT3+'s version takes loses the extra
        # ones; one with fewer stops the build (see run)
        code, cut, short = gml.fit_call_args(code, self.game_script_takes())
        for name, given, takes in cut:
            self.report["calls to the game's scripts with more arguments than DT3+'s versions take: the extra ones left out"].append(
                "%s: %s (%d of %d)" % (where, name, takes, given))
        for name, given, takes, line in short:
            self.arg_errors.append("%s line %d: %s given %d argument(s), DT3+'s takes %d" % (where, line, name, given, takes))
        code, c = protect_strings(code)
        if c: self.report["strings with 'return' in them split so the runtime compiler leaves them alone"].append("%s (%d)" % (where, c))
        # a /* comment left open runs to the end of the code (GameMaker allows it); closed, so nothing added after it
        # is commented out too
        toks = gml.tokens(code)
        if toks and toks[-1][0] == "cm2" and not toks[-1][1].endswith("*/"): code = code.rstrip("\n") + "\n*/"
        # code that doesn't compile is a fatal error when the game loads the mod: the build stops (see run)
        for line, msg in gmlcheck.check(code): self.compile_errors.append("%s line %d: %s" % (where, line, msg))
        return code

    def game_script_takes(self):
        """{script: arguments} for DT3+'s scripts that take a set number (not the mod's own scripts, which it calls
        through scrModCall, which gives them what they take)"""
        if self._takes is None:
            self._takes = {}
            for n in self.proj.names["Scripts"]:
                if n in self.new["Scripts"]: continue
                k, anyn = gml.script_arg_count(self.proj.script(n) or "")
                if not anyn: self._takes[n] = k
        return self._takes

    # ---------------------------------------------------------------- writers
    def write_object(self, name, ob, parent=None, inherit=None, block=()):
        d = os.path.join(self.out, "objects", name)
        lines = ["[object]",
                 "sprite=%s" % ob["sprite"], "solid=%d" % (ob["solid"] == "true"), "visible=%d" % (ob["visible"] == "true"),
                 "depth=%s" % ob["depth"], "persistent=%d" % (ob["persistent"] == "true"),
                 "parent=%s" % (ob["parent"] if parent is None else parent), "mask=%s" % ob["mask"]]
        if inherit is not None: lines.append("inherit=%s" % inherit)
        if block: lines.append("block=%s" % ",".join(sorted(block)))
        legacy = self._obj_legacy(name)
        if legacy and not self.mod_legacy:
            lines.append("legacy=1")
            self.report["30fps objects (object.ini legacy=1)"].append(name)
        ported = self.ported_events(name)
        if ported is not None:
            if self.mod_legacy: lines.append("legacy=0")
            self.report["objects ported to 60fps code (ported/objects)"].append(name)
        wtext(os.path.join(d, "object.ini"), "\n".join(lines) + "\n")
        for ev, code in (ported if ported is not None else ob["events"]).items():
            code = self.fix_code(code, "%s/%s" % (name, ev), legacy, ported=ported is not None)
            if legacy and ev.startswith("Draw_"):
                # a 30fps mod's draw event runs every frame: what it changes in the instance is put back between 30fps
                # ticks (scrModDrawRun), so its animations keep their speed
                keep = gml.assigned_vars(code)
                if keep:
                    code = "//tickvars:" + ",".join(keep) + "\n" + code
                    self.report["30fps draw events whose changes only count on 30fps ticks (//tickvars:)"].append("%s/%s: %s" % (name, ev, ", ".join(keep)))
            wtext(os.path.join(d, ev + ".gml"), code + "\n")

    def write_room(self, name, d):
        rd = os.path.join(self.out, "rooms", name)
        col = d["bgcolor"].rjust(6, "0")
        r, g, b = int(col[0:2], 16), int(col[2:4], 16), int(col[4:6], 16)
        # (laid out as GameMaker 8.2 writes it, so the folder can also be opened in the project)
        L = ["caption=%s" % d["caption"], "width=%d" % d["width"], "height=%d" % d["height"], "snap_x=16", "snap_y=16",
             "isometric=0", "roomspeed=%d" % d["speed"], "roompersistent=%d" % d["persistent"],
             "bg_color=%d" % (r + g * 256 + b * 65536), "clear_screen=%d" % d["drawbg"], "clear_view=1", ""]
        for i, bg in enumerate(d["bgs"]):
            L += ["bg_visible%d=%d" % (i, bg["visible"]), "bg_is_foreground%d=%d" % (i, bg["fore"]), "bg_source%d=%s" % (i, bg["image"]),
                  "bg_xoffset%d=%d" % (i, bg["x"]), "bg_yoffset%d=%d" % (i, bg["y"]), "bg_tile_h%d=%d" % (i, bg["htile"]),
                  "bg_tile_v%d=%d" % (i, bg["vtile"]), "bg_hspeed%d=%g" % (i, bg["hspeed"]), "bg_vspeed%d=%g" % (i, bg["vspeed"]),
                  "bg_stretch%d=%d" % (i, bg["stretch"])]
        L += ["", "views_enabled=%d" % d["views_on"]]
        for i, v in enumerate(d["views"]):
            L += ["view_visible%d=%d" % (i, v["visible"]), "view_xview%d=%d" % (i, v["x"]), "view_yview%d=%d" % (i, v["y"]),
                  "view_wview%d=%d" % (i, v["w"]), "view_hview%d=%d" % (i, v["h"]), "view_xport%d=%d" % (i, v["px"]),
                  "view_yport%d=%d" % (i, v["py"]), "view_wport%d=%d" % (i, v["pw"]), "view_hport%d=%d" % (i, v["ph"]),
                  "view_fol_hbord%d=%d" % (i, v["hborder"]), "view_fol_vbord%d=%d" % (i, v["vborder"]),
                  "view_fol_hspeed%d=%d" % (i, v["hspeed"]), "view_fol_vspeed%d=%d" % (i, v["vspeed"]),
                  "view_fol_target%d=%s" % (i, self.clone_map.get(v["target"], v["target"]))]
        wtext(os.path.join(rd, "room.txt"), "\n".join(L) + "\n")
        if norm(d["code"]): wtext(os.path.join(rd, "code.gml"), self.fix_code(d["code"], name + " room code") + "\n")
        inst = []
        blocked = self.cfg.get("block_rooms", {})  # rooms whose doors are left out: {room: why}
        for i in d["instances"]:
            obj = self.clone_map.get(i["object"], i["object"]); hexid = "%08X" % i["id"]
            code = i["code"]
            for br, why in blocked.items():
                if re.search(r"\btoRoom\s*=\s*%s\b" % re.escape(br), code or ""):
                    code = norm(code) + "\n//(left out of the conversion: %s)\ninstance_destroy()" % why
                    self.report["doors left out (see config)"].append("%s instance %d (%s) to %s: %s" % (name, i["id"], i["object"], br, why))
            # (the last field: 1 when the instance has creation code, as GameMaker 8.2 writes it)
            inst.append("%s,%d,%d,%s,0,1,1,4294967295,0,%d" % (obj, i["x"], i["y"], hexid, 1 if norm(code) else 0))
            if norm(code): wtext(os.path.join(rd, hexid + ".gml"), self.fix_code(code, "%s instance %d" % (name, i["id"])) + "\n")
        wtext(os.path.join(rd, "instances.txt"), "\n".join(inst) + ("\n" if inst else ""))
        layers = collections.defaultdict(list)
        for t in d["tiles"]:
            layers[t["depth"]].append("%s,%d,%d,%d,%d,%d,%d,0,1,1,4294967295" % (t["bg"], t["x"], t["y"], t["u"], t["v"], t["w"], t["h"]))
        for dep, rows in layers.items(): wtext(os.path.join(rd, "%d.txt" % dep), "\n".join(rows) + "\n")
        wtext(os.path.join(rd, "layers.txt"), "\n".join(str(k) for k in sorted(layers)) + ("\n" if layers else ""))

    def write_sprite(self, name, sp, replace=False):
        frames = [png.read(f) for f in sp["frames"]]
        if not frames:
            self.warn.append("sprite %s has no images" % name); return
        w0, h0 = frames[0][0], frames[0][1]
        frames = [f if (f[0], f[1]) == (w0, h0) else self._fit(f, w0, h0) for f in frames]
        W, H, rows = png.strip(frames)
        d = os.path.join(self.out, "sprites"); os.makedirs(d, exist_ok=True)
        png.write(os.path.join(d, name + ".png"), W, H, rows)
        kind = {"PRECISE": 0, "RECTANGLE": 1, "DISK": 2, "DIAMOND": 3}.get(sp["shape"], 0)
        mode = {"AUTO": 0, "FULL": 1, "MANUAL": 2}.get(sp["mode"], 0)
        # an image that already has transparent pixels had its background colour taken out when it was made: loading
        # it with transparent=1 would also take out every opaque pixel of the bottom left pixel's colour
        has_alpha = any(r[x] < 255 for f in frames for r in f[2] for x in range(3, len(r), 4))
        transparent = 1 if (sp["transparent"] and not has_alpha) else 0
        ini = ["[sprite]", "frames=%d" % len(frames), "xorig=%d" % sp["xorig"], "yorig=%d" % sp["yorig"],
               "transparent=%d" % transparent, "smooth=%d" % sp["smooth"], "sepmasks=%d" % sp["separate"],
               "bboxmode=%d" % mode, "left=%d" % sp["left"], "top=%d" % sp["top"], "right=%d" % sp["right"],
               "bottom=%d" % sp["bottom"], "kind=%d" % kind, "tolerance=%d" % sp["tolerance"]]
        wtext(os.path.join(d, name + ".ini"), "\n".join(ini) + "\n")

    def _fit(self, f, w, h):
        rows = []
        for y in range(h):
            r = bytearray(w * 4)
            if y < f[1]:
                src = f[2][y][:min(w, f[0]) * 4]; r[:len(src)] = src
            rows.append(r)
        return (w, h, rows)

    def write_background(self, name, bg):
        d = os.path.join(self.out, "backgrounds"); os.makedirs(d, exist_ok=True)
        w, h, rows = png.read(bg["png"]); png.write(os.path.join(d, name + ".png"), w, h, rows)
        wtext(os.path.join(d, name + ".ini"), "[background]\ntransparent=%d\nsmooth=%d\n" % (bg["transparent"], bg["smooth"]))

    def write_font(self, name, f):
        wtext(os.path.join(self.out, "fonts", name + ".ini"), "[font]\nface=%s\nsize=%d\nbold=%d\nitalic=%d\nfirst=%d\nlast=%d\n" %
              (f["face"], f["size"], f["bold"], f["italic"], f["first"], f["last"]))

    # ---------------------------------------------------------------- room patches
    def patch_room(self, name):
        cfg = self.cfg.get("patch_rules", {}).get(name, {})
        if cfg.get("skip"):
            self.report["room changes left out (see config)"].append("%s: %s" % (name, cfg.get("why", ""))); return
        a, b = self.van.room(name), self.mod.room(name)
        ops = []; files = {}
        proj_inst = self.proj.room_instances(name)
        def present(obj, x, y):
            return any(p["object"] == obj and p["x"] == x and p["y"] == y for p in proj_inst)
        skip_inst = set(cfg.get("skip_instances", []))
        skip_code = set(cfg.get("skip_code", []))
        for iid in sorted(skip_inst | skip_code):
            self.report["room changes left out (see config)"].append("%s instance %d: %s" % (name, iid, cfg.get("why_instances", {}).get(str(iid), cfg.get("why", ""))))
        if "only_instances" in cfg or "only_tile_ids" in cfg or "skip_tile_ids" in cfg:
            self.report["room changes left out (see config)"].append("%s: only some of its instances and tiles: %s" % (name, cfg.get("why", "")))
        ia = {i["id"]: i for i in a["instances"]}; ib = {i["id"]: i for i in b["instances"]}
        for iid, i in ib.items():
            if not self._inst_wanted(cfg, iid): continue
            if iid not in ia:
                fn = "-"
                if norm(i["code"]):
                    fn = "add_%d.gml" % iid; files[fn] = self.fix_code(i["code"], "%s added instance %d" % (name, iid))
                ops.append("add|%s|%d|%d|%d|%s" % (self.clone_map.get(i["object"], i["object"]), i["x"], i["y"], iid, fn))
        for iid, i in ia.items():
            if not self._inst_wanted(cfg, iid): continue
            if iid not in ib:
                ops.append("remove|%s|%d|%d" % (i["object"], i["x"], i["y"]))
                if not present(i["object"], i["x"], i["y"]): self.warn.append("%s: instance to remove isn't in DT3+: %s %d,%d" % (name, i["object"], i["x"], i["y"]))
                continue
            j = ib[iid]
            moved = (i["x"], i["y"]) != (j["x"], j["y"]) or i["object"] != j["object"]
            recoded = norm(i["code"]) != norm(j["code"]) and iid not in skip_code
            if (moved or recoded) and not present(i["object"], i["x"], i["y"]):
                self.warn.append("%s: instance to patch isn't in DT3+: %s %d,%d" % (name, i["object"], i["x"], i["y"]))
            cx, cy = i["x"], i["y"]  # where later lines find it
            if (i["x"], i["y"]) != (j["x"], j["y"]) or i["object"] != j["object"]:
                if i["object"] != j["object"]:
                    self.report["room changes not converted"].append("%s instance %d changed object %s -> %s" % (name, iid, i["object"], j["object"])); continue
                ops.append("move|%s|%d|%d|%d|%d" % (i["object"], i["x"], i["y"], j["x"], j["y"]))
                cx, cy = j["x"], j["y"]
            if norm(i["code"]) != norm(j["code"]) and iid not in skip_code:
                ad = appended(i["code"], j["code"])
                if ad is not None and ad.strip():
                    fn = "code_%d.gml" % iid; files[fn] = self.fix_code(ad, "%s instance %d extra code" % (name, iid))
                    ops.append("code|%s|%d|%d|%s" % (i["object"], cx, cy, fn))
                else:
                    self.report["room changes not converted"].append("%s instance %d (%s at %d,%d): creation code changed, not just added to" % (name, iid, i["object"], i["x"], i["y"]))
        if norm(a["code"]) != norm(b["code"]):
            override = cfg.get("room_code")
            if override is not None:
                if override:
                    files["room_code.gml"] = override; ops.append("roomcode|room_code.gml")
                self.report["room code changes replaced by hand-written code (see config)"].append("%s: %s" % (name, cfg.get("why_room_code", "")))
            else:
                ad = appended(a["code"], b["code"])
                if ad is not None and ad.strip():
                    files["room_code.gml"] = self.fix_code(ad, name + " extra room code"); ops.append("roomcode|room_code.gml")
                elif ad is None:
                    self.report["room changes not converted"].append("%s: room creation code changed, not just added to" % name)
        if a["caption"] != b["caption"]:
            self.report["room changes left out"].append("%s: caption %r -> %r" % (name, a["caption"], b["caption"]))
        if not cfg.get("skip_tiles"):
            ta = {t["id"]: t for t in a["tiles"]}; tb = {t["id"]: t for t in b["tiles"]}
            for tid, t in tb.items():
                if (tid not in ta or ta[tid] != t) and self._tile_wanted(cfg, tid):
                    ops.append("tileadd|%s|%d|%d|%d|%d|%d|%d|%d" % (t["bg"], t["x"], t["y"], t["u"], t["v"], t["w"], t["h"], t["depth"]))
            for tid, t in ta.items():
                if (tid not in tb or tb[tid] != t) and self._tile_wanted(cfg, tid):
                    # tile_layer_find finds a tile by a point on it: its middle, so a tile next to it can't be found instead
                    ops.append("tileremove|%d|%d|%d" % (t["depth"], t["x"] + t["w"] // 2, t["y"] + t["h"] // 2))
        for fn, code in cfg.get("extra_files", {}).items(): files[fn] = code
        for rule in cfg.get("extra_ops", []): ops.append(rule)
        if not ops: return
        pd = os.path.join(self.out, "patches", name)
        for fn, code in files.items(): wtext(os.path.join(pd, fn), code + "\n")
        self.patch_ops[name] = ops

    def write_patches(self):
        # GID registrations for original-room instances that the mod's code refers to by id and DT3+ doesn't register
        # (not those the patch adds: an add line gives its instance to GID() itself)
        for room, ids in self.gid_needed.items():
            added = set(int(o.split("|")[4]) for o in self.patch_ops.get(room, []) if o.startswith("add|"))
            for n in sorted(ids - added):
                _, obj, x, y = self.inst_where[n]
                self.patch_ops.setdefault(room, []).append("gid|%s|%d|%d|%d" % (obj, x, y, n))
        for room, ops in self.patch_ops.items():
            head = ["# patch for %s (made by tools/modkit/convert.py)" % room]
            ops = sorted(ops, key=lambda o: OP_ORDER.index(o.split("|")[0]))  # stable: the order within a kind stays
            wtext(os.path.join(self.out, "patches", room, "patch.txt"), "\n".join(head + ops) + "\n")

    # ---------------------------------------------------------------- unported
    def write_unported(self):
        base = os.path.join(self.out, "unported")
        cloned = set(self.clones)
        for n, (a, b) in self.changed_scripts.items():
            wtext(os.path.join(base, "scripts", n + ".gml"), b + "\n")
            d = difflib.unified_diff(norm(a).split("\n"), norm(b).split("\n"), "original/" + n, "mod/" + n, lineterm="")
            wtext(os.path.join(base, "scripts", n + ".diff"), "\n".join(d) + "\n")
        for n, (a, b) in self.changed_objects.items():
            if n in cloned: continue
            lines = []
            for ev in sorted(set(a["events"]) | set(b["events"])):
                x, y = norm(a["events"].get(ev, "")), norm(b["events"].get(ev, ""))
                if x == y: continue
                lines += ["##### %s" % ev] + list(difflib.unified_diff(x.split("\n"), y.split("\n"), "original", "mod", lineterm=""))
            pa = {k: a[k] for k in a if k != "events"}; pb = {k: b[k] for k in b if k != "events"}
            if pa != pb: lines.insert(0, "properties: %s -> %s" % (pa, pb))
            wtext(os.path.join(base, "objects", n + ".diff"), "\n".join(lines) + "\n")

    # ---------------------------------------------------------------- run
    def run(self):
        cfg = self.cfg
        if os.path.isdir(self.out): shutil.rmtree(self.out)
        os.makedirs(self.out)
        self.survey(); self.select_new(); self.plan_clones()
        self.gid_needed = {}; self.patch_ops = {}
        # objects
        for n in self.new["Objects"]:
            ob = self.mod.object(n)
            par = self.clone_map.get(ob["parent"], ob["parent"])
            self.write_object(n, ob, parent=par)
        for n in self.clones:
            ob = self.mod.object(n)
            inherit = self.clone_map.get(ob["parent"], ob["parent"])
            dt3 = set(self.proj.object_events(n)) if n in self.proj.names["Objects"] else set()
            block = dt3 - set(ob["events"])
            self.write_object(n + self.suffix, ob, parent=n, inherit=inherit, block=block)
            self.report["clones of changed original objects (used only by the mod's own content)"].append(
                "%s -> %s%s" % (n, n + self.suffix, ("  (blocks DT3+ events: %s)" % ", ".join(sorted(block))) if block else ""))
        # scripts
        for n in self.new["Scripts"]:
            p = self.ported_script(n)
            if p is not None:
                self.report["scripts ported to 60fps code (ported/scripts)"].append(n)
                wtext(os.path.join(self.out, "scripts", n + ".gml"), self.fix_code(p, "script " + n, False, ported=True) + "\n")
            else:
                wtext(os.path.join(self.out, "scripts", n + ".gml"), self.fix_code(self.mod.script(n), "script " + n) + "\n")
        # the game's scripts and object events, merged with the mod's changes (mergemod.py)
        if cfg.get("merge"): self.write_merged()
        # rooms
        for n in self.new["Rooms"]: self.write_room(n, self.mod.room(n))
        changed_rooms = []
        only = cfg.get("patch_rooms")
        for n in sorted(self.mod.names("Rooms") & self.van.names("Rooms")):
            a, b = self.van.room(n), self.mod.room(n)
            # (instances in another order only, as when a room is saved again, isn't a change)
            ka = (a["caption"], a["code"], sorted((i["id"], i["object"], i["x"], i["y"], norm(i["code"])) for i in a["instances"]), a["tiles"], a["bgs"], a["views"], a["width"], a["height"])
            kb = (b["caption"], b["code"], sorted((i["id"], i["object"], i["x"], i["y"], norm(i["code"])) for i in b["instances"]), b["tiles"], b["bgs"], b["views"], b["width"], b["height"])
            if ka != kb:
                changed_rooms.append(n)
                if only is not None and n not in only: continue
                if (a["bgs"], a["views"], a["width"], a["height"]) != (b["bgs"], b["views"], b["width"], b["height"]):
                    self.report["room changes not converted"].append("%s: room settings (size/backgrounds/views) changed" % n)
                self.patch_room(n)
        # sprites, backgrounds, fonts
        for n in self.new["Sprites"]: self.write_sprite(n, self.mod.sprite(n))
        for n in cfg.get("replace_sprites", []):
            self.write_sprite(n, self.mod.sprite(n), replace=True)
            self.report["sprites replaced"].append(n)
        for n, new in cfg.get("rename_sprites", {}).items():
            self.write_sprite(new, self.mod.sprite(n))
            self.report["the mod's versions of the game's sprites, under names of their own"].append("%s -> %s" % (n, new))
        for n in self.new["Backgrounds"]: self.write_background(n, self.mod.background(n))
        for n in self.new["Fonts"]: self.write_font(n, self.mod.font(n))
        # sounds and music (renamed where the config says: mod.ini can't be trusted with a '#' in a file name)
        ren = cfg.get("rename_files", {})
        for kind, src_key, dst in (("sound", "sound_dir", "sound"), ("music", "music_dir", "music")):
            src = cfg.get(src_key)
            if src and os.path.isdir(src):
                for f in sorted(os.listdir(src)):
                    os.makedirs(os.path.join(self.out, dst), exist_ok=True)
                    shutil.copy2(os.path.join(src, f), os.path.join(self.out, dst, ren.get(f, f)))
                    if f in ren: self.report["files renamed"].append("%s/%s -> %s" % (dst, f, ren[f]))
        # other files from the mod's release, copied as they are ({"path in the mod folder": "source"})
        for dst, src in cfg.get("copy", {}).items():
            p = os.path.join(self.out, dst); os.makedirs(os.path.dirname(p), exist_ok=True)
            shutil.copy2(src, p)
        # hand-written files (hooks, readme)
        extras = cfg.get("extras")
        if extras and os.path.isdir(extras):
            for dp, dn, fn in os.walk(extras):
                for f in sorted(fn):
                    rel = os.path.relpath(os.path.join(dp, f), extras)
                    dst = os.path.join(self.out, rel); os.makedirs(os.path.dirname(dst), exist_ok=True)
                    if f.endswith((".gml", ".ini", ".txt")):
                        wtext(dst, open(os.path.join(dp, f), encoding="utf-8").read())
                    else: shutil.copy2(os.path.join(dp, f), dst)
                    if rel.replace("\\", "/").startswith("hooks/"): self.report["hooks (hand-written: the mod's changes to the game's own scripts and system objects that could be ported)"].append(rel.replace("\\", "/"))
        # a save made with the original game keeps its room as the room's number there: the mod's rooms are numbered
        # differently in DT3+, so a hook (the load hook, with the save open) turns those numbers into the rooms
        ori = cfg.get("original_room_ids")
        if ori:
            cases = ["    case %d: roomToPlace=%s; break" % (self.mod.room_id(n), n) for n in self.new["Rooms"] if self.mod.room_id(n) is not None]
            hp = os.path.join(self.out, "hooks", ori["hook"] + ".gml")
            text = open(hp, "rb").read().decode("cp1252", "replace").replace("\r\n", "\n") if os.path.exists(hp) else ""
            text = text.rstrip("\n") + ("\n\n//(made by convert.py) a save made with the original in one of its own rooms keeps that room as its number "
                    "there:\n//the same room here\nif %s\n{\n  switch (roomToPlace)\n  {\n%s\n  }\n}\n" % (ori["when"], "\n".join(cases)))
            wtext(hp, text)
            self.report["original room numbers the %s hook turns into the mod's rooms" % ori["hook"]].append("%d rooms" % len(cases))
        self.write_mod_ini()
        self.write_patches()
        if cfg.get("unported", True) is not False: self.write_unported()
        unused = set(cfg.get("edits", {})) - self.edits_used
        if unused: raise SystemExit("edits: no code was written for %s" % ", ".join(sorted(unused)))
        self.write_report(changed_rooms)
        if self.compile_errors:
            raise SystemExit("code that wouldn't compile (the game would end when loading the mod):\n  " + "\n  ".join(self.compile_errors))
        if self.arg_errors:
            raise SystemExit("calls to the game's scripts with fewer arguments than DT3+'s versions take (the game stops on them):\n  "
                             + "\n  ".join(self.arg_errors))

    def write_merged(self):
        """the merged versions (mergemod.py) of the game's scripts, which replace them, and of the game's objects' events,
        which replace the events (object.ini events=replace, nothing else of the object changed)"""
        cfg = self.cfg
        md = os.path.join(cfg["_base"], cfg["merge"].get("merged", "merged"))
        for dp, dn, fn in os.walk(md):
            for f in fn:
                if f.endswith(".gml") and merge3.MARK_D in open(os.path.join(dp, f), encoding="utf-8").read():
                    raise SystemExit("%s still has conflicts to merge (python mergemod.py check <config>)" % os.path.join(dp, f))
        sd = os.path.join(md, "scripts")
        for f in sorted(os.listdir(sd)) if os.path.isdir(sd) else []:
            if not f.endswith(".gml"): continue
            n = f[:-4]
            code = open(os.path.join(sd, f), encoding="utf-8").read()
            wtext(os.path.join(self.out, "scripts", f), self.fix_code(code, "script " + n, False) + "\n")
            self.report["the game's scripts the mod's versions replace (merged with DT3+'s)"].append(n)
        od = os.path.join(md, "objects")
        for o in sorted(os.listdir(od)) if os.path.isdir(od) else []:
            evs = sorted(f[:-4] for f in os.listdir(os.path.join(od, o)) if f.endswith(".gml"))
            for ev in evs:
                code = open(os.path.join(od, o, ev + ".gml"), encoding="utf-8").read()
                wtext(os.path.join(self.out, "objects", o, ev + ".gml"), self.fix_code(code, "%s/%s" % (o, ev), False) + "\n")
            if o not in self.new["Objects"]: wtext(os.path.join(self.out, "objects", o, "object.ini"), "[object]\nevents=replace\n")
            self.report["the game's object events the mod's versions replace (merged with DT3+'s)"].append("%s: %s" % (o, ", ".join(evs)))

    def write_mod_ini(self):
        m = self.cfg["mod_ini"]
        L = ["[mod]"] + ["%s=%s" % (k, v) for k, v in m["mod"].items()]
        for sec in ("locations", "music", "sounds"):
            items = m.get(sec, [])
            L += ["", "[%s]" % sec, "count=%d" % len(items)]
            for i, it in enumerate(items):
                for k, v in it.items(): L.append("%s%d=%s" % (k, i, v))
        wtext(os.path.join(self.out, "mod.ini"), "\n".join(L) + "\n")

    def write_report(self, changed_rooms):
        R = ["Conversion report for %s" % self.cfg["mod_ini"]["mod"]["name"], "=" * 60, ""]
        R.append("New: %d rooms, %d objects, %d scripts, %d sprites, %d backgrounds, %d fonts" % tuple(len(self.new[t]) for t in ("Rooms", "Objects", "Scripts", "Sprites", "Backgrounds", "Fonts")))
        R.append("Original rooms patched: %d of %d changed (%s)" % (len(self.patch_ops), len(changed_rooms), ", ".join(sorted(self.patch_ops))))
        unported = self.cfg.get("unported", True) is not False
        R.append("Changed original objects: %d (%d cloned for the mod's content)" % (len(self.changed_objects), len(self.clones)))
        R.append("Changed original scripts: %d%s" % (len(self.changed_scripts), " (not portable as mod files; see unported/scripts)" if unported else ""))
        R.append("")
        for k, v in self.report.items():
            R.append("--- %s (%d)" % (k, len(v)))
            R += ["   " + x for x in v]; R.append("")
        if unported:
            unported_objects = sorted(set(self.changed_objects) - set(self.clones))
            R.append("--- changed original objects not converted (%d): see unported/objects/<name>.diff" % len(unported_objects))
            R += ["   " + x for x in unported_objects]; R.append("")
        if self.clone_skipped:
            R.append("--- changed original objects the mod's content uses, kept as DT3+ has them (%d)" % len(self.clone_skipped))
            R += ["   " + x for x in self.clone_skipped]; R.append("")
        if unported:
            R.append("--- changed original scripts (%d): see unported/scripts/<name>.diff" % len(self.changed_scripts))
            R += ["   %s (+%d -%d lines)" % (n, *self._linecount(a, b)) for n, (a, b) in self.changed_scripts.items()]; R.append("")
        if self.warn:
            R.append("--- warnings (%d)" % len(self.warn)); R += ["   " + w for w in self.warn]; R.append("")
        wtext(os.path.join(self.out, "report.txt"), "\n".join(R) + "\n")
        print("\n".join(R[:12]))
        if self.warn: print("warnings:", len(self.warn))

    def _linecount(self, a, b):
        d = list(difflib.unified_diff(norm(a).split("\n"), norm(b).split("\n"), lineterm=""))
        return (sum(1 for l in d if l.startswith("+") and not l.startswith("+++")), sum(1 for l in d if l.startswith("-") and not l.startswith("---")))

PATH_KEYS = ("mod", "vanilla", "project", "out", "extras", "sound_dir", "music_dir")

def load_config(path):
    """the config, with its paths taken from the config's own folder when they aren't absolute"""
    cfg = json.load(open(path, encoding="utf-8"))
    base = os.path.dirname(os.path.abspath(path))
    for k in PATH_KEYS:
        if k in cfg and not os.path.isabs(cfg[k]): cfg[k] = os.path.normpath(os.path.join(base, cfg[k]))
    for k, v in list(cfg.get("copy", {}).items()):
        if not os.path.isabs(v): cfg["copy"][k] = os.path.normpath(os.path.join(base, v))
    cfg["_base"] = base
    return cfg

if __name__ == "__main__":
    Converter(load_config(sys.argv[1])).run()
