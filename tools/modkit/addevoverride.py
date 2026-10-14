"""
Lets mods replace some of the game's object events without clearing them first (object_event_clear takes long for an
object many others inherit from: seconds for oDamagableBase): adds to each event named the line that performs a mod's
version of it instead, when a mod has one, and then ends the event (scrModEvRegister sets that up), and keeps the list
the mod loader checks (global.modEvList in scrModEvInit). An event's number in its line is its place in the list. With
no mod's version, global.modEvOvr[n] is -1 and the line does nothing. Running it again for an event that has the line
does nothing.

The events must be ones the game's object has, as a single code action (the line's exit ends that action, so it would
leave any action after it running).

usage: python addevoverride.py <project folder> <object> <event> [<object> <event> ...]
       python addevoverride.py <project folder> --check       checks that the list and the events' lines agree
"""
import os, re, sys

INIT = os.path.join("scripts", "scrModEvInit.gml")
LINE = ("if global.modEvOvr[{k}]>=0 {{event_perform_object(global.modEvOvr[{k}],{t},{n}); exit}} //mods change (added): "
        "a mod's own version of this event runs instead (scrModEvRegister)")
HEADER_END = "*/"
MARK = re.compile(r"global\.modEvOvr\[(\d+)\]")

def event_args(ev):
    """GameMaker's event type and number for an event's file name (Create_0, Collision_oAttackBase...)"""
    m = re.match(r"^([A-Za-z]+)_(\w+)$", ev)
    if not m: raise SystemExit("not an event: " + ev)
    kind, num = m.groups()
    if kind == "Collision": return "ev_collision", num
    if kind == "Step": return "ev_step", {"0": "ev_step_normal", "1": "ev_step_begin", "2": "ev_step_end"}[num]
    types = {"Create": "ev_create", "Destroy": "ev_destroy", "Alarm": "ev_alarm", "Keyboard": "ev_keyboard",
             "KeyPress": "ev_keypress", "KeyRelease": "ev_keyrelease", "Mouse": "ev_mouse", "Other": "ev_other",
             "Draw": "ev_draw", "Trigger": "ev_trigger"}
    if kind not in types or not num.isdigit(): raise SystemExit("not an event: " + ev)
    return types[kind], num

def read(p):
    raw = open(p, "rb").read().decode("utf-8")
    return raw, ("\r\n" if "\r\n" in raw else "\n")

def get_list(proj):
    raw, nl = read(os.path.join(proj, INIT))
    m = re.search(r'global\.modEvList="([^"]*)"', raw)
    n = re.search(r"global\.modEvCount=(\d+)", raw)
    if not m or not n: raise SystemExit("%s has no global.modEvList / global.modEvCount line" % INIT)
    items = [tuple(x.split(" ")) for x in m.group(1).split(",") if x]
    return items, int(n.group(1))

def set_list(proj, items):
    p = os.path.join(proj, INIT)
    raw, nl = read(p)
    raw = re.sub(r'global\.modEvList="[^"]*"', 'global.modEvList="%s"' % ",".join("%s %s" % i for i in items), raw)
    raw = re.sub(r"global\.modEvCount=\d+", "global.modEvCount=%d" % len(items), raw)
    open(p, "wb").write(raw.encode("utf-8"))

def section(lines, ev):
    """(start, end) line indexes of an event's section in an object's .gml (#define <event> to the next #define)"""
    starts = [i for i, l in enumerate(lines) if l.startswith("#define ")]
    for j, i in enumerate(starts):
        if lines[i] == "#define " + ev:
            return i, (starts[j + 1] if j + 1 < len(starts) else len(lines))
    return None

def code_start(lines, a, b):
    """the first line of an event's code: after its action header (/*"/*'/**//* YYD ACTION ... */); None if the event
    isn't a single code action"""
    heads = [i for i in range(a, b) if "YYD ACTION" in lines[i]]
    if len(heads) != 1: return None
    i = heads[0]
    if not any("action_id=603" == lines[x].strip() for x in range(i, b)) or not any("applies_to=self" == lines[x].strip() for x in range(i, b)):
        return None
    while i < b and lines[i].strip() != HEADER_END: i += 1
    return i + 1 if i < b else None

def check(proj):
    """problems, as a list of text: the list's events must each start with their line, with their own place in the list,
    and no other event may have one"""
    out = []
    items, count = get_list(proj)
    if count != len(items): out.append("global.modEvCount is %d, but global.modEvList has %d events" % (count, len(items)))
    if len(set(items)) != len(items): out.append("global.modEvList names an event twice")
    want = {}
    for k, (o, ev) in enumerate(items):
        want[(o, ev)] = k
    od = os.path.join(proj, "objects")
    for f in sorted(os.listdir(od)):
        if not f.endswith(".gml"): continue
        o = f[:-4]
        raw, nl = read(os.path.join(od, f))
        if "global.modEvOvr[" not in raw and not any(i[0] == o for i in items): continue
        lines = raw.replace("\r\n", "\n").split("\n")
        for i, l in enumerate(lines):
            for m in MARK.finditer(l):
                # which event this line is in
                d = max([x for x in range(i + 1) if lines[x].startswith("#define ")] or [-1])
                ev = lines[d][len("#define "):] if d >= 0 else "?"
                if (o, ev) not in want: out.append("%s %s has a mod line (global.modEvOvr[%s]) but isn't in the list" % (o, ev, m.group(1)))
        for (oo, ev), k in want.items():
            if oo != o: continue
            s = section(lines, ev)
            if not s: out.append("%s has no event %s" % (o, ev)); continue
            c = code_start(lines, *s)
            if c is None: out.append("%s %s isn't a single code action" % (o, ev)); continue
            t, n = event_args(ev)
            if c >= len(lines) or lines[c] != LINE.format(k=k, t=t, n=n):
                out.append("%s %s doesn't start with its line (global.modEvOvr[%d])" % (o, ev, k))
    for (o, ev) in items:
        if not os.path.exists(os.path.join(od, o + ".gml")): out.append("no object %s" % o)
    return out

def add(proj, pairs):
    items, count = get_list(proj)
    if count != len(items): raise SystemExit("the list in %s doesn't agree with its count: fix it first" % INIT)
    for o, ev in pairs:
        p = os.path.join(proj, "objects", o + ".gml")
        if not os.path.exists(p): raise SystemExit("no object " + o)
        raw, nl = read(p)
        lines = raw.replace("\r\n", "\n").split("\n")
        s = section(lines, ev)
        if not s: raise SystemExit("%s has no event %s" % (o, ev))
        c = code_start(lines, *s)
        if c is None: raise SystemExit("%s %s isn't a single code action (the line's exit would leave the rest running)" % (o, ev))
        if (o, ev) in items:
            print("%s %s: already in the list" % (o, ev)); continue
        if any(MARK.search(lines[x]) for x in range(*s)): raise SystemExit("%s %s has a mod line already, but isn't in the list" % (o, ev))
        k = len(items)
        t, n = event_args(ev)
        lines.insert(c, LINE.format(k=k, t=t, n=n))
        open(p, "wb").write(nl.join(lines).encode("utf-8"))
        items.append((o, ev))
        set_list(proj, items)
        print("%s %s: line added (global.modEvOvr[%d]), at line %d" % (o, ev, k, c + 1))
    problems = check(proj)
    for x in problems: print("PROBLEM:", x)
    print("%d events mods can replace without clearing them%s" % (len(items), "" if not problems else ", with problems"))

if __name__ == "__main__":
    proj = sys.argv[1]
    if sys.argv[2:] == ["--check"]:
        problems = check(proj)
        for x in problems: print("PROBLEM:", x)
        items, count = get_list(proj)
        print("%d events, %s" % (len(items), "the list and the lines agree" if not problems else "%d problems" % len(problems)))
        sys.exit(1 if problems else 0)
    args = sys.argv[2:]
    if len(args) % 2: raise SystemExit("give <object> <event> pairs")
    add(proj, list(zip(args[0::2], args[1::2])))
