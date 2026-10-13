"""
Three-way merge of GameMaker code for the mod tools. A mod made as an edited copy of the original game changed some of
the game's code (original -> mod), and DT3+ changed the same code its own way (original -> DT3+). merge() applies the
mod's changes to DT3+'s version: where only one side changed a stretch of the original, that side's version is used;
where both changed it, it's a conflict, written with both versions between marker comments for a hand merge:

  //<<<<<<< DT3+
  ...DT3+'s lines...
  //======= mod
  ...the mod's lines...
  //>>>>>>> end

Changes conflict when they overlap in the original, or are both insertions at the same place; changes that only touch
are both made, in order. Lines are matched on their code alone (comments, spacing and indentation left out), since DT3+
keeps the original of a line it changed as a comment and adds a comment of its own to the new one.
"""
import difflib, re
import gml

MARK_D, MARK_SEP, MARK_END = "//<<<<<<< DT3+", "//======= mod", "//>>>>>>> end"

def norm_line(l):
    return " ".join(t for k, t in gml.tokens(l) if k not in ("cm1", "cm2", "ws"))

def norm_lines(lines):
    """norm_line of each of lines, read together: the lines of a /* */ comment over several lines are its text (marked
    "/*"), not code or nothing, so a part of one isn't matched to code or to a blank line (and a change that removes
    one removes all of it)"""
    out = [[] for _ in lines]
    ln = 0
    for k, t in gml.tokens("\n".join(lines)):
        if k == "cm2" and "\n" in t:
            for n, piece in enumerate(t.split("\n")):
                out[ln + n].append("/*" + " ".join(piece.split()))
        elif k not in ("cm1", "cm2", "ws"):
            out[ln].append(t)
        ln += t.count("\n")
    return [" ".join(x) for x in out]

def comment_open(lines):
    """whether lines end inside a /* */ comment"""
    toks = gml.tokens("\n".join(lines))
    return bool(toks) and toks[-1][0] == "cm2" and not toks[-1][1].endswith("*/")

def split_lines(text):
    t = (text or "").replace("\r\n", "\n")
    if t.endswith("\n"): t = t[:-1]
    return t.split("\n") if t else []

def braces(lines):
    """the net number of blocks lines open ({ minus }, in code only)"""
    return sum((t == "{") - (t == "}") for k, t in gml.tokens("\n".join(lines)) if k == "op")

_HEADER = re.compile(r"^(?:\}\s*)?(?:else\b\s*)?(?:(?:if|with|for|while|repeat|switch)\b.*)?\{?$")

def _headers_only(lines):
    """lines with no code but braces and block headers ("if ...", "else", "} else {")"""
    return all(_HEADER.match(n) for n in (norm_line(l) for l in lines) if n)

def _pair_left_out(cm, flags, O, M):
    """a change left out that opens blocks (a new "if ... {" around the original's code) takes the kept changes that
    close them along, if those are only braces and block headers; one that closes blocks takes the ones opening them.
    Left-out changes met on the way count too, and blocks the kept changes open and close in between are skipped."""
    net = [braces(M[c[2]:c[3]]) - braces(O[c[0]:c[1]]) for c in cm]
    done = [False] * len(cm)
    for i in range(len(cm)):
        if flags[i] or done[i] or net[i] == 0: continue
        b = net[i]; step = 1 if b > 0 else -1; j = i + step; nest = 0
        while b != 0 and 0 <= j < len(cm):
            nj = net[j]; cj = cm[j]
            if not flags[j]:
                b += nj; done[j] = True
            elif nj * b > 0: nest += abs(nj)
            elif nj * b < 0:
                if nest: nest = max(0, nest - abs(nj))
                elif abs(nj) <= abs(b) and _headers_only(O[cj[0]:cj[1]] + M[cj[2]:cj[3]]):
                    flags[j] = False; b += nj
            j += step

def _diff(a, b):
    """(changes, map): the non-equal opcodes of a -> b as (i1, i2, j1, j2), and a's unchanged lines' places in b"""
    sm = difflib.SequenceMatcher(a=norm_lines(a), b=norm_lines(b), autojunk=False)
    ch, mp = [], {}
    for tag, i1, i2, j1, j2 in sm.get_opcodes():
        if tag == "equal":
            for k in range(i2 - i1): mp[i1 + k] = j1 + k
        else: ch.append((i1, i2, j1, j2))
    return ch, mp

def _overlap(a, b):
    (a1, a2), (b1, b2) = a, b
    if a1 == a2 and b1 == b2: return a1 == b1                 # two insertions: at the same place
    if a1 == a2: return b1 < a1 < b2                           # an insertion inside the other's lines
    if b1 == b2: return a1 < b1 < a2
    return a1 < b2 and b1 < a2

def _version(changes, side, base, s, e, trace=None, at=0):
    """the lines of the original's s..e with changes (from side) made; unchanged lines from base(k). trace: gets
    (change, where its lines start in the output), the output starting at line at"""
    out, k = [], s
    for c in sorted(changes):
        i1, i2, j1, j2 = c
        out += [base(t) for t in range(k, i1)]
        if trace is not None: trace.append((c, at + len(out)))
        out += side[j1:j2]
        k = max(k, i2)
    out += [base(t) for t in range(k, e)]
    return out

def merge(orig, dt3, mod, keep=None, trace=None):
    """-> (merged text, conflicts, applied, skipped). keep(original lines, mod lines) decides whether one of the mod's
    changes is wanted (default: all); one that isn't is left out (DT3+'s code stays as it is there). trace: a list
    that gets (change, line where it starts in the merged text) for each of the mod's changes applied cleanly."""
    O, D, M = split_lines(orig), split_lines(dt3), split_lines(mod)
    cd, md = _diff(O, D)
    cm, _ = _diff(O, M)
    skipped = 0
    if keep is not None:
        flags = [bool(keep(O[c[0]:c[1]], M[c[2]:c[3]])) for c in cm]
        _pair_left_out(cm, flags, O, M)
        kept = [c for c, f in zip(cm, flags) if f]
        skipped = len(cm) - len(kept); cm = kept
    items = sorted([("d", c) for c in cd] + [("m", c) for c in cm], key=lambda x: (x[1][0], x[1][1]))
    # clusters of changes linked by overlaps
    clusters = []
    for side, c in items:
        hit = [cl for cl in clusters if any(_overlap((c[0], c[1]), (x[0], x[1])) for _, x in cl)]
        if hit:
            base = hit[0]
            for other in hit[1:]:
                base += other; clusters.remove(other)
            base.append((side, c))
        else: clusters.append([(side, c)])
    clusters.sort(key=lambda cl: (min(x[0] for _, x in cl), min(x[1] for _, x in cl)))
    dline = lambda t: D[md[t]] if t in md else O[t]
    out, pos, conflicts, applied = [], 0, 0, 0
    for cl in clusters:
        s = min(x[0] for _, x in cl); e = max(x[1] for _, x in cl)
        out += [dline(t) for t in range(pos, s)]
        dc = [x for side, x in cl if side == "d"]; mc = [x for side, x in cl if side == "m"]
        if not mc:
            out += _version(dc, D, dline, s, e)
        elif not dc:
            out += _version(mc, M, dline, s, e, trace, len(out)); applied += len(mc)
        else:
            dv = _version(dc, D, dline, s, e)
            mv = _version(mc, M, lambda t: O[t], s, e)
            if norm_lines(dv) == norm_lines(mv): out += dv     # the same change on both sides
            else:
                out += [MARK_D] + dv + [MARK_SEP] + mv + [MARK_END]; conflicts += 1
        pos = max(pos, e)
    out += [dline(t) for t in range(pos, len(O))]
    return "\n".join(out) + ("\n" if out else ""), conflicts, applied, skipped

if __name__ == "__main__":
    # a few checks
    o = "a\nb\nc\nd\ne\n"
    d = "a\n//b\nB //60fps\nc\nd\ne\n"
    m = "a\nb\nc\nX\nd\ne\nY\n"
    r = merge(o, d, m)
    assert r[0] == "a\n//b\nB //60fps\nc\nX\nd\ne\nY\n" and r[1] == 0, r
    m2 = "a\nbb\nc\nd\ne\n"
    r = merge(o, d, m2)
    assert r[1] == 1 and "//<<<<<<< DT3+" in r[0], r
    r = merge(o, o, m)            # DT3+ unchanged: the mod's version
    assert r[0] == m, r
    r = merge(o, d, o)            # mod unchanged: DT3+'s version
    assert r[0] == d, r
    # a wrapper left out takes its closing brace along
    o3 = "if a\n{\n  b\n}\nc\n"
    m3 = "if a\n{\n  if skip\n  {\n    b\n  }\n}\nc\nX\n"
    r = merge(o3, o3, m3, keep=lambda ol, ml: "skip" not in "\n".join(ml))
    assert r[0] == "if a\n{\n  b\n}\nc\nX\n" and r[3] == 2, r
    # a closing part left out takes the header that opened it along, past a block the kept changes add in between
    o4 = "a\nb\nc\nd\ne\n"
    m4 = "a\nif r\n{\n  b\n  if k\n  {\n    c\n  }\n  d\n}\nelse\n{\n  skip\n}\ne\n"
    r = merge(o4, o4, m4, keep=lambda ol, ml: "skip" not in "\n".join(ml))
    assert r[0] == "a\nb\n  if k\n  {\nc\n  }\nd\ne\n", r       # (unchanged lines keep DT3+'s spacing)
    # a /* */ comment over several lines that the mod removed goes whole (its first line isn't kept as a blank match)
    o5 = "a\n\n/*if b\n{\n  c\n}*/\nd\n"
    m5 = "a\n\nd\nX\n"
    r = merge(o5, o5, m5)
    assert r[0] == "a\n\nd\nX\n" and not comment_open(split_lines(r[0])), r
    print("merge3 checks ok")
