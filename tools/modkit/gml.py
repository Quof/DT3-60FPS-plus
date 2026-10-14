"""GML helpers for the mod tools: a tokenizer that keeps strings and comments intact, and rewrites done on tokens."""
import re

_TOK = re.compile(r"""
    (?P<cm1>//[^\n]*)
  | (?P<cm2>/\*.*?(?:\*/|\Z))
  | (?P<str>"[^"]*(?:"|\Z)|'[^']*(?:'|\Z))
  | (?P<num>\$[0-9A-Fa-f]+|\d+\.?\d*|\.\d+)
  | (?P<id>[A-Za-z_][A-Za-z0-9_]*)
  | (?P<ws>\s+)
  | (?P<op>.)
""", re.S | re.X)

def tokens(code):
    """[(kind, text)] where kind is cm1, cm2, str, num, id, ws or op. Joining the texts gives the code back."""
    return [(m.lastgroup, m.group(m.lastgroup)) for m in _TOK.finditer(code)]

def join(toks):
    return "".join(t for _, t in toks)

def identifiers(code):
    return set(t for k, t in tokens(code) if k == "id")

def _next_sig(toks, i):
    """index of the next token after i that isn't whitespace or a comment, or None"""
    j = i + 1
    while j < len(toks) and toks[j][0] in ("ws", "cm1", "cm2"): j += 1
    return j if j < len(toks) else None

def _prev_sig(toks, i):
    j = i - 1
    while j >= 0 and toks[j][0] in ("ws", "cm1", "cm2"): j -= 1
    return j if j >= 0 else None

def rename_ids(code, mapping, only_calls=None, skip_after_dot=True):
    """Renames identifiers per mapping. only_calls: if given, a set of names that are only renamed where they're called
    (followed by '('). Identifiers right after a '.' are member names (x.name) and are left alone."""
    toks = tokens(code); changed = 0
    for i, (k, t) in enumerate(toks):
        if k != "id" or t not in mapping: continue
        if skip_after_dot:
            p = _prev_sig(toks, i)
            if p is not None and toks[p] == ("op", "."): continue
        if only_calls is not None and t in only_calls:
            n = _next_sig(toks, i)
            if n is None or toks[n] != ("op", "("): continue
        toks[i] = (k, mapping[t]); changed += 1
    return join(toks), changed

def rename_member(code, obj, member, new):
    """obj.member -> obj.new (e.g. oGame.time -> oGame.time30)"""
    toks = tokens(code); changed = 0
    for i, (k, t) in enumerate(toks):
        if k != "id" or t != member: continue
        p = _prev_sig(toks, i)
        if p is None or toks[p] != ("op", "."): continue
        q = _prev_sig(toks, p)
        if q is None or toks[q] != ("id", obj): continue
        toks[i] = (k, new); changed += 1
    return join(toks), changed

def rewrite_numbers(code, fn):
    """fn(int) -> replacement text or None. Applied to plain decimal integer literals."""
    toks = tokens(code); changed = 0
    for i, (k, t) in enumerate(toks):
        if k == "num" and t.isdigit():
            r = fn(int(t))
            if r is not None:
                toks[i] = ("id", r); changed += 1
    return join(toks), changed

def rewrite_paren_numbers(code, fn, skip_calls=("GID",)):
    """As rewrite_numbers, but only for a literal that's alone in brackets, '(123456)': the way GameMaker 8 code (and
    gm8decompiler's output) writes an instance id used as an instance, e.g. (123456).x or with (123456). Not the argument
    of a call to one of skip_calls (GID(123456) is already a lookup)."""
    toks = tokens(code); changed = 0
    for i, (k, t) in enumerate(toks):
        if k == "num" and t.isdigit():
            p, n = _prev_sig(toks, i), _next_sig(toks, i)
            if p is None or n is None or toks[p] != ("op", "(") or toks[n] != ("op", ")"): continue
            q = _prev_sig(toks, p)
            if q is not None and toks[q][0] == "id" and toks[q][1] in skip_calls: continue
            r = fn(int(t))
            if r is not None:
                toks[i] = ("id", r); changed += 1
    return join(toks), changed

# after one of these a name is inside an expression, where '=' compares instead of assigning
_EXPR_CONT = {"if", "while", "until", "and", "or", "xor", "not", "(", ",", "[", "=", "==", "!=", "<", ">", "<=", ">=",
              "+", "-", "*", "/", "&&", "||", "!", "return", "case", "with", "repeat", "switch", "div", "mod", "&", "|",
              "^", ":", "."}
_ASSIGN = {"=", "+=", "-=", "*=", "/=", "|=", "&=", "^="}

def assigned_vars(code):
    """The instance's own variables the code assigns (plain names: not var locals, arrays, global.x or other.x)"""
    s = [t for t in tokens(code) if t[0] not in ("ws", "cm1", "cm2")]
    m = []; i = 0
    while i < len(s):  # two-character operators as one token
        k, t = s[i]
        if k == "op" and i + 1 < len(s) and s[i + 1][0] == "op" and t + s[i + 1][1] in _ASSIGN | {"==", "!=", "<=", ">=", "&&", "||"}:
            m.append(("op", t + s[i + 1][1])); i += 2; continue
        m.append((k, t)); i += 1
    s = m
    local, out = set(), set()
    for i, (k, t) in enumerate(s):
        if k == "id" and t == "var":
            j = i + 1
            while j < len(s) and (s[j][0] == "id" or s[j][1] == ","):
                if s[j][0] == "id": local.add(s[j][1])
                j += 1
    for i, (k, t) in enumerate(s[:-1]):
        if k != "id" or t in ("var", "global", "self", "other", "all", "noone") or t in local: continue
        if i > 0 and s[i - 1][1] in _EXPR_CONT: continue
        if s[i + 1][1] in _ASSIGN: out.add(t)
    return sorted(out)

def var_locals(code):
    """the names the code declares with var"""
    s = [t for t in tokens(code) if t[0] not in ("ws", "cm1", "cm2")]
    out = set()
    for i, (k, t) in enumerate(s):
        if k == "id" and t == "var":
            j = i + 1
            while j < len(s) and (s[j][0] == "id" or s[j][1] == ","):
                if s[j][0] == "id": out.add(s[j][1])
                j += 1
    return out

def ends_early(code):
    """whether the code can stop before its end (exit, or return)"""
    return any(k == "id" and t in ("exit", "return") for k, t in tokens(code))

def normalize_event_inherited(code):
    """'event_inherited ( )' -> 'event_inherited()' so the game's loader can find it with a plain text search"""
    return re.sub(r"\bevent_inherited\s*\(\s*\)", "event_inherited()", code)

def calls(code, names):
    """names (from the given set) that are called in the code"""
    toks = tokens(code); out = set()
    for i, (k, t) in enumerate(toks):
        if k == "id" and t in names:
            n = _next_sig(toks, i)
            if n is not None and toks[n] == ("op", "("): out.add(t)
    return out

def script_arg_count(code):
    """(arguments, any) for a script: GameMaker 8.2 counts the arguments a script reads (its highest argumentN, in code,
    not comments) and stops with "Illegal argument count" on a call that gives another number; any is True for a script
    that reads argument[...] or argument_count, which takes any number."""
    s = [t for t in tokens(code) if t[0] not in ("ws", "cm1", "cm2")]
    hi = -1; anyn = False
    for i, (k, t) in enumerate(s):
        if k != "id": continue
        m = re.fullmatch(r"argument(\d+)", t)
        if m: hi = max(hi, int(m.group(1)))
        elif t == "argument_count": anyn = True
        elif t == "argument" and i + 1 < len(s) and s[i + 1] == ("op", "["): anyn = True
    return hi + 1, anyn

def _call_span(toks, i):
    """for the name at toks[i] followed by '(': (index of the '(', index of its ')', indexes of the commas between
    the arguments), or None"""
    o = _next_sig(toks, i)
    if o is None or toks[o] != ("op", "("): return None
    depth = 0; commas = []
    for j in range(o, len(toks)):
        k, t = toks[j]
        if k != "op": continue
        if t in "([": depth += 1
        elif t in ")]":
            depth -= 1
            if depth == 0: return o, j, commas
        elif t == "," and depth == 1: commas.append(j)
    return None

def call_arg_counts(code, names):
    """[(name, arguments given, line)] for every call name(...) to one of the names (not a member's: x.name())"""
    toks = tokens(code); out = []; line = 1
    for i, (k, t) in enumerate(toks):
        if k == "id" and t in names:
            p = _prev_sig(toks, i)
            sp = None if (p is not None and toks[p] == ("op", ".")) else _call_span(toks, i)
            if sp:
                o, c, commas = sp
                empty = all(toks[j][0] in ("ws", "cm1", "cm2") for j in range(o + 1, c))
                out.append((t, 0 if empty else len(commas) + 1, line))
        line += t.count("\n")
    return out

def fit_call_args(code, takes):
    """takes: {script: the number of arguments it takes}. A call with more arguments than that loses the extra ones.
    Returns (code, [(name, given, takes)] for the calls cut down, [(name, given, takes, line)] for calls with fewer)."""
    cut = []
    while True:
        toks = tokens(code); done = False
        for i, (k, t) in enumerate(toks):
            if k != "id" or t not in takes: continue
            p = _prev_sig(toks, i)
            if p is not None and toks[p] == ("op", "."): continue
            sp = _call_span(toks, i)
            if not sp: continue
            o, c, commas = sp
            empty = all(toks[j][0] in ("ws", "cm1", "cm2") for j in range(o + 1, c))
            given = 0 if empty else len(commas) + 1
            if given > takes[t]:
                start = o + 1 if takes[t] == 0 else commas[takes[t] - 1]
                del toks[start:c]
                code = join(toks); cut.append((t, given, takes[t])); done = True
                break
        if not done: break
    short = [(n, g, takes[n], ln) for n, g, ln in call_arg_counts(code, takes) if g < takes[n]]
    return code, cut, short

def replace_assign(code, name, fn):
    """Finds 'name = <number>' / 'name=<number>' (an assignment of a number literal to name) and replaces the whole
    statement text with fn(number) if that returns a string."""
    toks = tokens(code); out = []; i = 0; changed = 0
    while i < len(toks):
        k, t = toks[i]
        if k == "id" and t == name:
            j = _next_sig(toks, i)
            if j is not None and toks[j] == ("op", "="):
                j2 = _next_sig(toks, j)
                if j2 is not None and toks[j2][0] == "num":
                    r = fn(toks[j2][1])
                    if r is not None:
                        out.append(("id", r)); i = j2 + 1; changed += 1; continue
        out.append(toks[i]); i += 1
    return join(out), changed
