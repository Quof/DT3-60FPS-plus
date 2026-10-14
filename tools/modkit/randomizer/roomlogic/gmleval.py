"""
A small evaluator for GameMaker 8 creation code (an instance's code in a room, or a room's own code), for the room
logic: what the code leaves the instance as (its variables, where it is, whether it destroyed itself) in a given world
state. Values it can't know (random numbers, other instances, globals not given) are UNK; a condition on one runs both
ways, and the result says which variables the ways agree on.

run(code, start, world) -> Result: vars (name -> value or UNK), destroyed (0 no, 1 yes, 2 one way only), exact (False
when the code did something it doesn't follow: a loop, a switch, too many ways)
"""
import os, sys
sys.path.insert(0, os.path.normpath(os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..")))
import gmlcheck


class _Unk:
    def __repr__(self): return "UNK"
UNK = _Unk()


class Res(str):
    """a resource name (object, room, sprite...) used as a value"""


MAX_WAYS = 64
CONSTS = {"true": 1, "false": 0, "noone": -4, "all": -3, "self": -1, "other": -2, "c_white": 16777215, "c_black": 0,
          "c_red": 255, "c_green": 32768, "c_blue": 16711680, "c_yellow": 65535, "c_orange": 4235519, "c_purple": 8388736,
          "c_gray": 8421504, "c_ltgray": 12632256, "c_dkgray": 4210752, "c_aqua": 16776960, "c_fuchsia": 16711935,
          "c_lime": 65280, "c_maroon": 128, "c_navy": 8388608, "c_olive": 32896, "c_silver": 12632256, "c_teal": 8421376,
          "pi": 3.141592653589793}


# ---------------------------------------------------------------- parsing (to a tree)
class _Parser:
    def __init__(self, code):
        self.t = gmlcheck.lex(code); self.p = 0

    def peek(self, n=0): return self.t[min(self.p + n, len(self.t) - 1)]
    def at(self, *vals): return self.peek()[1] in vals and self.peek()[0] in ("op", "kw")
    def next(self):
        tok = self.t[self.p]; self.p = min(self.p + 1, len(self.t) - 1); return tok
    def expect(self, v):
        if not self.at(v): raise SyntaxError("%r expected at %r" % (v, self.peek()[1]))
        return self.next()

    def program(self):
        out = []
        while self.peek()[0] != "eof": out.append(self.statement())
        return ("block", out)

    def block(self, closer):
        self.next(); out = []
        while not self.at(closer):
            if self.peek()[0] == "eof": raise SyntaxError("block not closed")
            out.append(self.statement())
        self.next()
        return ("block", out)

    def opt_semi(self):
        if self.at(";"): self.next()

    def statement(self):
        k, t, line = self.peek()
        if k == "op" and t == ";": self.next(); return ("nop",)
        if k == "op" and t == "{": b = self.block("}"); self.opt_semi(); return b
        if k == "kw":
            if t == "begin": b = self.block("end"); self.opt_semi(); return b
            if t in ("var", "globalvar"):
                self.next(); names = []
                while self.peek()[0] == "id":
                    names.append(self.next()[1])
                    if self.at(","): self.next()
                    else: break
                self.opt_semi()
                return ("var", names) if t == "var" else ("nop",)
            if t == "if":
                self.next(); c = self.expr()
                if self.at("then"): self.next()
                a = self.statement()
                if self.at(";") and self.peek(1)[1] == "else" and self.peek(1)[0] == "kw": self.next()
                b = None
                if self.at("else"): self.next(); b = self.statement()
                return ("if", c, a, b)
            if t in ("while", "repeat", "with"):
                self.next(); e = self.expr()
                if self.at("do"): self.next()
                s = self.statement()
                return ("with", e, s) if t == "with" else ("opaque", s)
            if t == "do":
                self.next(); s = self.statement(); self.expect("until"); self.expr(); self.opt_semi()
                return ("opaque", s)
            if t == "for":
                self.next(); self.expect("("); parts = []
                if not self.at(";"): parts.append(self.simple())
                if self.at(";"): self.next()
                if not self.at(";"): self.expr()
                if self.at(";"): self.next()
                if not self.at(")"): parts.append(self.simple())
                self.expect(")")
                parts.append(self.statement())
                return ("opaque", ("block", parts))
            if t == "switch":
                self.next(); self.expr(); self.expect("{"); body = []
                while not self.at("}"):
                    if self.at("case"): self.next(); self.expr(); self.expect(":"); continue
                    if self.at("default"): self.next(); self.expect(":"); continue
                    body.append(self.statement())
                self.next(); self.opt_semi()
                return ("opaque", ("block", body))
            if t in ("break", "continue"): self.next(); self.opt_semi(); return ("opaque", ("block", []))
            if t == "exit": self.next(); self.opt_semi(); return ("exit",)
            if t == "return":
                self.next(); self.expr(); self.opt_semi(); return ("exit",)
        s = self.simple(); self.opt_semi()
        return s

    def simple(self):
        target = self.postfix()
        if self.at("=", ":=", "+=", "-=", "*=", "/=", "|=", "&=", "^="):
            op = self.next()[1]; e = self.expr()
            return ("assign", target, op, e)
        if target[0] == "call": return ("callst", target)
        raise SyntaxError("an assignment or a call expected")

    BIN = [("||", "or"), ("&&", "and"), ("^^", "xor"), ("<", "<=", "==", "!=", "<>", ">", ">=", "="), ("|", "&", "^"),
           ("<<", ">>"), ("+", "-"), ("*", "/", "div", "mod")]

    def expr(self, level=0):
        if level == len(self.BIN): return self.unary()
        a = self.expr(level + 1)
        while self.at(*self.BIN[level]):
            op = self.next()[1]; b = self.expr(level + 1)
            a = ("bin", op, a, b)
        return a

    def unary(self):
        if self.at("!", "not", "-", "+", "~"):
            op = self.next()[1]; return ("un", op, self.unary())
        return self.postfix()

    def postfix(self):
        k, t, line = self.peek()
        if k == "num":
            self.next()
            v = int(t[1:], 16) if t.startswith("$") else (float(t) if "." in t else int(t))
            node = ("num", v)
        elif k == "str":
            self.next(); node = ("str", t[1:-1])
        elif k == "id":
            self.next()
            if self.at("("):
                self.next(); args = []
                if not self.at(")"):
                    args.append(self.expr())
                    while self.at(","): self.next(); args.append(self.expr())
                self.expect(")")
                node = ("call", t, args)
            else:
                node = ("id", t)
        elif k == "op" and t == "(":
            self.next(); node = self.expr(); self.expect(")")
        else:
            raise SyntaxError("a value expected at %r" % t)
        while True:
            if self.at("."):
                self.next(); n = self.next()[1]
                node = ("global", n) if node == ("id", "global") else ("member", node, n)
            elif self.at("["):
                self.next(); idx = [self.expr()]
                if self.at(","): self.next(); idx.append(self.expr())
                self.expect("]")
                node = ("index", node, idx)
            else:
                break
        return node


_cache = {}


def parse(code):
    if code not in _cache:
        try:
            _cache[code] = _Parser(code).program()
        except (SyntaxError, IndexError) as e:
            _cache[code] = ("error", str(e))
    return _cache[code]


# ---------------------------------------------------------------- running
class Way:
    __slots__ = ("vars", "tmp", "destroyed", "exited", "maybe", "created", "destroys")

    def __init__(self, vars, tmp=None, destroyed=0, exited=False, maybe=False):
        self.vars = vars; self.tmp = tmp or {}; self.destroyed = destroyed; self.exited = exited; self.maybe = maybe
        # (a room's code: the instances it makes, [object, x, y, {variable: value}], and the ones it destroys with
        # with(...) instance_destroy(): ("gid", n) or ("obj", name))
        self.created = []; self.destroys = set()

    def copy(self):
        w = Way(dict(self.vars), dict(self.tmp), self.destroyed, self.exited, self.maybe)
        w.created = [[c[0], c[1], c[2], dict(c[3])] for c in self.created]; w.destroys = set(self.destroys)
        return w


class Made:
    """a local variable holding an instance the code made (its index in the way's created list)"""
    def __init__(self, i): self.i = i
    def __eq__(self, o): return isinstance(o, Made) and o.i == self.i
    def __hash__(self): return hash(self.i)


class Result:
    def __init__(self, vars, destroyed, exact):
        self.vars = vars; self.destroyed = destroyed; self.exact = exact

    def get(self, name, default=None):
        return self.vars.get(name, default)

    def __repr__(self):
        return "Result(%r, destroyed=%r, exact=%r)" % (self.vars, self.destroyed, self.exact)


def truth(v):
    if v is UNK: return UNK
    if isinstance(v, str): return UNK
    return v > 0.5


def _num(v):
    return isinstance(v, (int, float)) and not isinstance(v, bool) or isinstance(v, bool)


def binop(op, a, b):
    if op in ("&&", "and"):
        ta, tb = truth(a), truth(b)
        if ta is False or tb is False: return 0
        if ta is UNK or tb is UNK: return UNK
        return 1
    if op in ("||", "or"):
        ta, tb = truth(a), truth(b)
        if ta is True or tb is True: return 1
        if ta is UNK or tb is UNK: return UNK
        return 0
    if a is UNK or b is UNK: return UNK
    if op in ("^^", "xor"):
        ta, tb = truth(a), truth(b)
        if ta is UNK or tb is UNK: return UNK
        return int(ta != tb)
    if op in ("=", "=="): return int(a == b) if type(a) is type(b) or (_num(a) and _num(b)) else UNK
    if op in ("!=", "<>"): return int(a != b) if type(a) is type(b) or (_num(a) and _num(b)) else UNK
    if isinstance(a, str) or isinstance(b, str):
        if op == "+" and isinstance(a, str) and isinstance(b, str) and not isinstance(a, Res) and not isinstance(b, Res):
            return a + b
        return UNK
    try:
        if op == "<": return int(a < b)
        if op == "<=": return int(a <= b)
        if op == ">": return int(a > b)
        if op == ">=": return int(a >= b)
        if op == "+": return a + b
        if op == "-": return a - b
        if op == "*": return a * b
        if op == "/": return a / b if b != 0 else UNK
        if op == "div": return int(a / b) if b != 0 else UNK
        if op == "mod": return a - b * int(a / b) if b != 0 else UNK
        if op == "|": return int(a) | int(b)
        if op == "&": return int(a) & int(b)
        if op == "^": return int(a) ^ int(b)
        if op == "<<": return int(a) << int(b)
        if op == ">>": return int(a) >> int(b)
    except (TypeError, ValueError, OverflowError):
        return UNK
    return UNK


class Ctx:
    """what the code runs against: the world's globals (name -> value; a list or dict for an array), the names of the
    game's resources (a name that's one of them is that resource), and how to count variables the code can't follow"""
    def __init__(self, world, resources, write_globals=False):
        self.world = world; self.resources = resources; self.exact = True; self.write_globals = write_globals


def evaluate(node, way, ctx):
    k = node[0]
    if k == "num": return node[1]
    if k == "str": return node[1]
    if k == "id":
        n = node[1]
        if n in way.tmp: return way.tmp[n]
        if n in way.vars: return way.vars[n]
        if n in CONSTS: return CONSTS[n]
        if n in ctx.resources: return Res(n)
        return UNK
    if k == "global":
        v = ctx.world.get(node[1], UNK)
        return UNK if isinstance(v, (list, dict)) else v
    if k == "index":
        base = node[1]
        if base[0] == "global":
            arr = ctx.world.get(base[1])
            idx = [evaluate(e, way, ctx) for e in node[2]]
            if isinstance(arr, dict) and all(i is not UNK for i in idx):
                return arr.get(tuple(idx) if len(idx) > 1 else idx[0], UNK)
        return UNK
    if k == "member": return UNK
    if k == "un":
        v = evaluate(node[2], way, ctx)
        if v is UNK: return UNK
        if node[1] in ("!", "not"):
            t = truth(v)
            return UNK if t is UNK else int(not t)
        if isinstance(v, str): return UNK
        if node[1] == "-": return -v
        if node[1] == "~": return ~int(v)
        return v
    if k == "bin":
        op = node[1]
        a = evaluate(node[2], way, ctx)
        if op in ("&&", "and") and truth(a) is False: return 0
        if op in ("||", "or") and truth(a) is True: return 1
        return binop(op, a, evaluate(node[3], way, ctx))
    if k == "call":
        return call(node[1], [evaluate(a, way, ctx) for a in node[2]], way, ctx)
    return UNK


def call(name, args, way, ctx):
    known = all(a is not UNK for a in args)
    if name == "variable_local_exists":
        if args and isinstance(args[0], str): return int(args[0] in way.vars)
        return UNK
    if name == "variable_global_exists":
        if args and isinstance(args[0], str) and args[0] in ctx.world: return 1
        return UNK
    if not known: return UNK
    try:
        if name == "string_char_at":
            s, i = args; i = int(i)
            if isinstance(s, (int, float)): s = str(int(s)) if s == int(s) else str(s)
            return s[i - 1] if 1 <= i <= len(s) else ""
        if name == "string_length": return len(args[0])
        if name == "string_copy":
            s, i, n = args; i = max(1, int(i)); return s[i - 1:i - 1 + int(n)]
        if name == "string_pos": return args[1].find(args[0]) + 1
        if name == "string_count": return args[1].count(args[0])
        if name == "string": return str(args[0]) if not isinstance(args[0], float) or args[0] != int(args[0]) else str(int(args[0]))
        if name == "real": return float(args[0]) if isinstance(args[0], str) else args[0]
        if name == "abs": return abs(args[0])
        if name == "sign": return (args[0] > 0) - (args[0] < 0)
        if name == "floor":
            import math; return math.floor(args[0])
        if name == "ceil":
            import math; return math.ceil(args[0])
        if name == "round": return int(round(args[0]))
        if name == "min": return min(args)
        if name == "max": return max(args)
        if name == "make_color_rgb": return int(args[0]) | (int(args[1]) << 8) | (int(args[2]) << 16)
    except (TypeError, ValueError, IndexError):
        return UNK
    return UNK


def make(call_node, way, ctx):
    """instance_create(x, y, object) in a room's code: recorded in the way (with Made, to follow its variables)"""
    args = [evaluate(a, way, ctx) for a in call_node[2]]
    if len(args) != 3 or not isinstance(args[2], Res) or not all(isinstance(a, (int, float)) for a in args[:2]): return UNK
    way.created.append([str(args[2]), args[0], args[1], {}])
    return Made(len(way.created) - 1)


def assigned_names(node, out):
    """the instance variables a statement may assign, and whether it may destroy the instance"""
    k = node[0]
    if k == "block":
        for s in node[1]: assigned_names(s, out)
    elif k == "assign":
        if node[1][0] == "id": out.add(node[1][1])
    elif k == "callst":
        if node[1][1] in ("instance_destroy", "instance_change"): out.add("#destroy")
    elif k == "if":
        assigned_names(node[2], out)
        if node[3]: assigned_names(node[3], out)
    elif k in ("opaque",):
        assigned_names(node[1], out)
    elif k == "exit":
        out.add("#exit")


def execute(node, ways, ctx):
    """runs a statement on every way that hasn't exited; returns the ways after it"""
    k = node[0]
    live = [w for w in ways if not w.exited]
    done = [w for w in ways if w.exited]
    if not live: return ways
    if k == "block":
        cur = ways
        for s in node[1]:
            cur = execute(s, cur, ctx)
        return cur
    if k == "nop": return ways
    if k == "var":
        for w in live:
            for n in node[1]: w.tmp[n] = UNK
        return ways
    if k == "exit":
        for w in live: w.exited = True
        return ways
    if k == "assign":
        tgt, op, e = node[1], node[2], node[3]
        if ctx.write_globals and (tgt[0] == "global" or (tgt[0] == "index" and tgt[1][0] == "global")):
            # (a script that sets the game's globals up: they go to the world)
            for w in live:
                v = evaluate(e, w, ctx)
                if tgt[0] == "global":
                    if op not in ("=", ":="): v = binop(op[0], ctx.world.get(tgt[1], UNK), v)
                    ctx.world[tgt[1]] = v
                else:
                    idx = [evaluate(i, w, ctx) for i in tgt[2]]
                    arr = ctx.world.get(tgt[1][1])
                    if not isinstance(arr, dict): arr = ctx.world[tgt[1][1]] = {}
                    if any(i is UNK for i in idx): continue
                    key = tuple(idx) if len(idx) > 1 else idx[0]
                    if op not in ("=", ":="): v = binop(op[0], arr.get(key, UNK), v)
                    arr[key] = v
            return ways
        if tgt[0] == "member" and tgt[1][0] == "id":
            # a variable of an instance the code made (t=instance_create(...); t.image_xscale=2)
            for w in live:
                ref = w.tmp.get(tgt[1][1], w.vars.get(tgt[1][1]))
                if isinstance(ref, Made) and op in ("=", ":="): w.created[ref.i][3][tgt[2]] = evaluate(e, w, ctx)
            return ways
        if tgt[0] != "id": return ways   # other.x, obj.x, global.x, arrays: not the instance's own
        n = tgt[1]
        if e[0] == "call" and e[1] == "instance_create" and op in ("=", ":="):
            for w in live:
                ref = make(e, w, ctx)
                if n in w.tmp: w.tmp[n] = ref
                else: w.vars[n] = ref
            return ways
        for w in live:
            v = evaluate(e, w, ctx)
            if op not in ("=", ":="):
                cur = w.tmp.get(n, w.vars.get(n, UNK)) if n in w.tmp else w.vars.get(n, UNK)
                v = binop(op[0], cur, v)
            if n in w.tmp: w.tmp[n] = v
            else: w.vars[n] = v
        return ways
    if k == "callst":
        name = node[1][1]
        if name in ("instance_destroy", "instance_change"):
            for w in live: w.destroyed = 1
        if name == "instance_create":
            for w in live: make(node[1], w, ctx)
        return ways
    if k == "with":
        # with (GID(n)) / with oObject, its body instance_destroy(): the instances it destroys
        target, body = node[1], node[2]
        stmts = body[1] if body[0] == "block" else [body]
        if any(s[0] == "callst" and s[1][1] == "instance_destroy" for s in stmts):
            for w in live:
                if target[0] == "call" and target[1] == "GID" and len(target[2]) == 1:
                    g = evaluate(target[2][0], w, ctx)
                    if isinstance(g, (int, float)): w.destroys.add(("gid", int(g)))
                elif target[0] == "id" and target[1] in ctx.resources:
                    w.destroys.add(("obj", target[1]))
        return ways
    if k == "opaque":
        names = set(); assigned_names(node[1], names)
        ctx.exact = False
        for w in live:
            for n in names:
                if n == "#destroy":
                    if w.destroyed == 0: w.maybe = True
                elif n == "#exit": pass
                elif n in w.tmp: w.tmp[n] = UNK
                else: w.vars[n] = UNK
        return ways
    if k == "if":
        out = list(done)
        for w in live:
            c = truth(evaluate(node[1], w, ctx))
            if c is True:
                out += execute(node[2], [w], ctx)
            elif c is False:
                out += execute(node[3], [w], ctx) if node[3] else [w]
            else:
                a, b = w, w.copy()
                out += execute(node[2], [a], ctx)
                out += execute(node[3], [b], ctx) if node[3] else [b]
        if len(out) > MAX_WAYS:
            ctx.exact = False
            out = [merge(out)]
        return out
    return ways


def merge(ways):
    """one way that's what all of them agree on"""
    names = set()
    for w in ways: names |= set(w.vars)
    vars = {}
    for n in names:
        vals = [w.vars.get(n, UNK) for w in ways]
        v0 = vals[0]
        vars[n] = v0 if all(v is not UNK and v == v0 and type(v) is type(v0) for v in vals) else UNK
    d = {w.destroyed for w in ways}
    m = Way(vars)
    m.destroyed = d.pop() if len(d) == 1 else 1
    m.maybe = any(w.maybe for w in ways) or len({w.destroyed for w in ways}) > 1
    m.exited = all(w.exited for w in ways)
    return m


def room_effects(code, start, ctx):
    """a room's code: the instances it surely makes ([object, x, y, {variable: value}]) and surely destroys (a set of
    ("gid", n) and ("obj", name)): what every way through it does"""
    tree = parse(code or "")
    if tree[0] == "error": return [], set()
    ways = execute(tree, [Way(dict(start))], ctx)
    destroys = set.intersection(*[w.destroys for w in ways]) if ways else set()
    def key(c): return (c[0], c[1], c[2], tuple(sorted((k, repr(v)) for k, v in c[3].items())))
    common = set(key(c) for c in ways[0].created) if ways else set()
    for w in ways[1:]: common &= set(key(c) for c in w.created)
    created = [c for c in (ways[0].created if ways else []) if key(c) in common and all(v is not UNK for v in c[3].values())]
    return created, destroys


def run(code, start, ctx):
    """runs creation code from the instance's starting variables (start: name -> value)"""
    tree = parse(code or "")
    if tree[0] == "error":
        return Result({n: UNK for n in start}, 2, False)
    ctx.exact = True
    ways = execute(tree, [Way(dict(start))], ctx)
    names = set()
    for w in ways: names |= set(w.vars)
    vars = {}
    for n in names:
        vals = [w.vars.get(n, UNK) for w in ways]
        v0 = vals[0]
        vars[n] = v0 if all(v is not UNK and v == v0 and type(v) is type(v0) for v in vals) else UNK
    ds = {w.destroyed for w in ways}
    if any(w.maybe for w in ways): ds.add(1); ds.add(0)
    destroyed = ds.pop() if len(ds) == 1 else 2
    return Result(vars, destroyed, ctx.exact)


if __name__ == "__main__":
    ctx = Ctx({"gameProgress": 5641, "bBossGallery": 0}, {"rMain_8", "oExit", "sNormalDoor"})
    r = run("bShowArrow=true\nexitType=0\nnewMapX=2512\nnewMapY=1296\ntoRoom=rMain_8\nx-=16\n"
            "if global.gameProgress<5500 {instance_destroy()}", {"x": 600, "y": 288}, ctx)
    assert r.vars["toRoom"] == "rMain_8" and r.vars["x"] == 584 and r.destroyed == 0, r
    r = run("if global.unknownThing=1 {newMapX=5} else {newMapX=6}\ntoRoom=rMain_8", {"x": 0}, ctx)
    assert r.vars["newMapX"] is UNK and r.vars["toRoom"] == "rMain_8" and r.destroyed == 0, r
    r = run("if global.unknownThing=1 instance_destroy()", {}, ctx)
    assert r.destroyed == 2, r
    r = run("if global.bBossGallery=1 {instance_destroy()}", {}, ctx)
    assert r.destroyed == 0, r
    r = run("if global.gameProgress>=5560 { newMapX=48 } else { newMapX=1 }", {}, ctx)
    assert r.vars["newMapX"] == 48, r
    r = run("if global.gameProgress<10 exit; a=1", {}, ctx)
    assert r.vars["a"] == 1, r
    r = run("if global.zz exit; a=1", {}, ctx)
    assert r.vars["a"] is UNK, r
    print("gmleval checks ok")
