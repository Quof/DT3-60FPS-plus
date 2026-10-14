"""
A syntax check for GameMaker 8 code (GML), for the mod tools: what GameMaker's compiler would refuse. A mod's code is
compiled when the game starts, and code that doesn't compile is a fatal error there (the game ends), so validate.py
runs this over every piece of a mod's code.

It follows GameMaker 8's grammar: statements (blocks, var/globalvar, if/then/else, while/do, do/until, for, repeat,
with, switch/case/default, break, continue, exit, return, assignments and calls) and expressions (= compares inside
them; no ++, --, ?: or += inside an expression). It's a checker, not a compiler: it doesn't know which names exist (see
validate.py for that) or how many arguments a function takes.

  python gmlcheck.py <file.gml> ...      prints the errors

check(code) -> [(line, message)]
"""
import re, sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import gml

KEYWORDS = {"if", "then", "else", "while", "do", "until", "for", "repeat", "with", "switch", "case", "default", "break",
            "continue", "exit", "return", "var", "globalvar", "begin", "end", "and", "or", "xor", "not", "div", "mod"}
TWO = {"==", "!=", "<=", ">=", "<>", "&&", "||", "^^", "<<", ">>", "+=", "-=", "*=", "/=", "|=", "&=", "^=", ":=", "++", "--"}
ASSIGN = {"=", ":=", "+=", "-=", "*=", "/=", "|=", "&=", "^="}
# GameMaker 8's built-in variables (an instance's and the game's): "var id" doesn't compile ("Cannot redeclare a builtin
# variable"), and nor does any of these after var or globalvar
BUILTIN_VARS = set("""
id object_index x y xprevious yprevious xstart ystart hspeed vspeed direction speed friction gravity gravity_direction
path_index path_position path_positionprevious path_speed path_scale path_orientation path_endaction solid persistent
mask_index timeline_index timeline_position timeline_speed timeline_running timeline_loop visible sprite_index
sprite_width sprite_height sprite_xoffset sprite_yoffset image_number image_index image_speed depth image_xscale
image_yscale image_angle image_alpha image_blend bbox_left bbox_right bbox_top bbox_bottom alarm
score lives health show_score show_lives show_health caption_score caption_lives caption_health room room_first
room_last room_width room_height room_caption room_speed room_persistent background_color background_showcolor
background_visible background_foreground background_index background_x background_y background_width
background_height background_htiled background_vtiled background_xscale background_yscale background_hspeed
background_vspeed background_blend background_alpha view_enabled view_current view_visible view_xview view_yview
view_wview view_hview view_xport view_yport view_wport view_hport view_angle view_hborder view_vborder view_hspeed
view_vspeed view_object transition_kind transition_steps transition_time current_time current_year current_month
current_day current_weekday current_hour current_minute current_second fps mouse_x mouse_y mouse_button
mouse_lastbutton keyboard_key keyboard_lastkey keyboard_lastchar keyboard_string cursor_sprite instance_count
instance_id working_directory program_directory temp_directory secure_mode error_occurred error_last
gamemaker_registered gamemaker_pro gamemaker_version debug_mode event_type event_number event_object event_action
argument argument_count argument_relative self other all noone global
""".split()) | set("argument%d" % i for i in range(16))

class Error(Exception):
    def __init__(self, line, msg): self.line, self.msg = line, msg

def lex(code):
    """[(kind, text, line)] with comments and spaces left out and two-character operators joined"""
    out, line = [], 1
    toks = gml.tokens(code)
    i = 0
    while i < len(toks):
        k, t = toks[i]
        if k in ("ws", "cm1", "cm2"):
            line += t.count("\n"); i += 1; continue
        if k == "op" and i + 1 < len(toks) and toks[i + 1][0] == "op" and t + toks[i + 1][1] in TWO:
            out.append(("op", t + toks[i + 1][1], line)); i += 2; continue
        if k == "num" and t.startswith(".") and out and out[-1][0] == "num" and toks[i - 1][0] == "num":
            i += 1; continue  # (GameMaker reads 1.1.25 as one number)
        if k == "cm2" and not t.endswith("*/"): raise Error(line, "comment not closed")
        if k == "str" and (len(t) < 2 or t[-1] != t[0]): raise Error(line, "string not closed")
        if k == "id" and t in KEYWORDS: k = "kw"
        out.append((k, t, line))
        line += t.count("\n")
        i += 1
    out.append(("eof", "", line))
    return out

class Parser:
    def __init__(self, code):
        self.t = lex(code); self.p = 0
    def peek(self, n=0): return self.t[min(self.p + n, len(self.t) - 1)]
    def at(self, *vals): return self.peek()[1] in vals and self.peek()[0] in ("op", "kw")
    def next(self):
        tok = self.t[self.p]; self.p = min(self.p + 1, len(self.t) - 1); return tok
    def fail(self, msg, tok=None):
        tok = tok or self.peek()
        raise Error(tok[2], "%s (at %r)" % (msg, tok[1] or "the end"))
    def expect(self, val):
        if not self.at(val): self.fail("%r expected" % val)
        return self.next()

    # ---------------------------------------------------------------- statements
    def program(self):
        while self.peek()[0] != "eof": self.statement()

    def block(self, closer):
        self.next()
        while not self.at(closer):
            if self.peek()[0] == "eof": self.fail("%r expected (block not closed)" % closer)
            self.statement()
        self.next()

    def statement(self, in_switch=False):
        k, t, line = self.peek()
        if k == "op" and t == ";": self.next(); return
        if k == "op" and t == "{": self.block("}"); return self.opt_semi()
        if k == "kw":
            if t == "begin": self.block("end"); return self.opt_semi()
            if t in ("var", "globalvar"):
                self.next()
                if self.peek()[0] != "id": self.fail("a name expected after " + t)
                self.declared(t)
                while self.at(","):
                    self.next()
                    if self.peek()[0] != "id": break  # (GameMaker allows var a,;)
                    self.declared(t)
                return self.opt_semi()
            if t == "if":
                self.next(); self.expr()
                if self.at("then"): self.next()
                self.body("if")
                if self.at(";") and self.peek(1)[1] == "else" and self.peek(1)[0] == "kw": self.next()
                if self.at("else"): self.next(); self.body("else")
                return
            if t == "while":
                self.next(); self.expr()
                if self.at("do"): self.next()
                return self.body("while")
            if t == "do":
                self.next(); self.body("do")
                self.expect("until"); self.expr(); return self.opt_semi()
            if t == "for":
                self.next(); self.expect("(")
                if not self.at(";"): self.simple_statement()
                if self.at(";"): self.next()
                if not self.at(";"): self.expr()
                if self.at(";"): self.next()
                if not self.at(")"): self.simple_statement()
                self.expect(")")
                return self.body("for")
            if t in ("repeat", "with"):
                self.next(); self.expr()
                if t == "with" and self.at("do"): self.next()
                return self.body(t)
            if t == "switch":
                self.next(); self.expr()
                if not self.at("{"): self.fail("'{' expected after switch")
                self.next()
                while not self.at("}"):
                    if self.peek()[0] == "eof": self.fail("switch not closed")
                    if self.at("case"): self.next(); self.expr(); self.expect(":"); continue
                    if self.at("default"): self.next(); self.expect(":"); continue
                    self.statement()
                self.next(); return self.opt_semi()
            if t in ("break", "continue", "exit"): self.next(); return self.opt_semi()
            if t == "return": self.next(); self.expr(); return self.opt_semi()
            if t == "else": self.fail("'else' without an 'if' before it")
            if t in ("case", "default"): self.fail("'%s' outside a switch" % t)
            if t == "until": self.fail("'until' without a 'do' before it")
            if t in ("then", "end"): self.fail("unexpected %r" % t)
        self.simple_statement()
        self.opt_semi()

    def declared(self, what):
        """a name after var or globalvar: not one of GameMaker's built-in variables"""
        if self.peek()[1] in BUILTIN_VARS: self.fail("%s can't declare %s, one of GameMaker's built-in variables" % (what, self.peek()[1]))
        self.next()

    def body(self, what):
        if self.peek()[0] == "eof" or self.at("}"): self.fail("a statement expected after " + what)
        self.statement()

    def opt_semi(self):
        if self.at(";"): self.next()

    def simple_statement(self):
        """an assignment or a call"""
        start = self.peek()
        if start[0] == "op" and start[1] in ("++", "--"): self.fail("GameMaker 8 has no ++ or --")
        is_call = self.postfix(statement=True)
        if self.at(*ASSIGN):
            self.next(); self.expr()
            if self.at("++", "--"): self.fail("GameMaker 8 has no ++ or --")
            return
        if self.at("++", "--"): self.fail("GameMaker 8 has no ++ or --")
        if not is_call: self.fail("an assignment or a call expected", start)

    # ---------------------------------------------------------------- expressions
    BIN = [("||", "or"), ("&&", "and"), ("^^", "xor"), ("<", "<=", "==", "!=", "<>", ">", ">=", "="), ("|", "&", "^"),
           ("<<", ">>"), ("+", "-"), ("*", "/", "div", "mod")]

    def expr(self, level=0):
        if level == len(self.BIN): return self.unary()
        self.expr(level + 1)
        while self.at(*self.BIN[level]):
            self.next(); self.expr(level + 1)

    def unary(self):
        if self.at("!", "not", "-", "+", "~"): self.next(); return self.unary()
        if self.at("++", "--"): self.fail("GameMaker 8 has no ++ or --")
        self.postfix()

    def postfix(self, statement=False):
        """a value with .name and [index] after it; True if it ended in a call"""
        k, t, line = self.peek()
        is_call = False
        if k == "num" or k == "str":
            if statement: self.fail("an assignment or a call expected")
            self.next()
        elif k == "id":
            self.next()
            if self.at("("): self.args(); is_call = True
        elif k == "op" and t == "(":
            self.next(); self.expr(); self.expect(")")
        else:
            self.fail("a value expected")
        while True:
            if self.at("."):
                self.next()
                if self.peek()[0] != "id": self.fail("a name expected after '.'")
                self.next(); is_call = False
            elif self.at("["):
                self.next(); self.expr()
                if self.at(","): self.next(); self.expr()
                self.expect("]"); is_call = False
            else:
                break
        if self.at("?"): self.fail("GameMaker 8 has no ?: (use if/else)")
        return is_call

    def args(self):
        self.next()
        if self.at(")"): self.next(); return
        self.expr()
        while self.at(","): self.next(); self.expr()
        self.expect(")")

def check(code):
    """[(line, message)]: the first syntax error in the code, or none"""
    try:
        Parser(code or "").program()
    except Error as e:
        return [(e.line, e.msg)]
    return []

if __name__ == "__main__":
    # a few checks
    assert check("if a=1 {b=2} else if c {d(1)}") == []
    assert check("x=1\n}") != []
    assert check("y=1\nelse if a {b=1}") and check("y=1\nelse if a {b=1}")[0][0] == 2
    assert check("if a b=1; else b=2") == []
    assert check("for(i=0;i<3;i+=1) {a[i,0]=1}") == []
    assert check("with (GID(5)) instance_destroy()") == []
    assert check("(123).x=5; global.y[2]-=1") == []
    assert check("switch x {case 1: a=1; break; default: a=2}") == []
    assert check("do {a+=1} until a>3") == []
    assert check("var a,b; a=b") == []
    assert check("var id; id=1") != [] and check("var f,l,id,t; f=1") != [] and check("globalvar x;") != []
    assert check("var tId,idx; tId=1") == []
    assert check("i++") != [] and check("a=b?1:2") != [] and check("a+b") != []
    assert check("return 1") == [] and check("exit") == []
    for f in sys.argv[1:]:
        for line, msg in check(open(f, "rb").read().decode("cp1252", "replace")):
            print("%s:%d: %s" % (f, line, msg))
    if len(sys.argv) == 1: print("gmlcheck checks ok")
