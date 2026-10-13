"""
Lets mods replace some of the game's scripts: adds to each script named the line that runs a mod's version of it
instead, when a mod has one (scrModOverride), and adds the names to the list the mod loader checks (global.modOvrList
in scrModInit). Running it again for a script that has the line does nothing.

usage: python addoverride.py <project folder> <script> [<script>...]
"""
import os, re, sys

LINE = ("if global.modOvr[{n}]>=0 {{var __n; __n=0; repeat (argument_count) {{global.modArg[__n]=argument[__n]; __n+=1}}; "
        "return scrModOverride({n},argument_count)}} //mods change (added): a mod's own version of this script runs instead "
        "(scrModOverride)")

def insert_at(lines):
    """the line after the script's opening comment (a /* */ block, or a run of // lines), so any comment after that,
    which is about the code under it, stays with it"""
    i = 0
    while i < len(lines) and lines[i].strip() == "": i += 1
    if i < len(lines) and lines[i].strip().startswith("/*"):
        s = lines[i].strip(); end = s.find("*/", 2)
        if end >= 0: return i if s[end + 2:].strip() else i + 1     # a one-line comment (with code after it: before it)
        i += 1
        while i < len(lines) and "*/" not in lines[i]: i += 1
        return i + 1
    while i < len(lines) and lines[i].strip().startswith("//"): i += 1
    return i

def main(proj, names):
    sd = os.path.join(proj, "scripts")
    done = []
    for n in names:
        p = os.path.join(sd, n + ".gml")
        if not os.path.exists(p): print("no script", n); continue
        raw = open(p, "rb").read().decode("utf-8")
        nl = "\r\n" if "\r\n" in raw else "\n"
        lines = raw.replace("\r\n", "\n").split("\n")
        if any("scrModOverride(" in l for l in lines): done.append(n); continue
        i = insert_at(lines)
        lines.insert(i, LINE.format(n=n))
        open(p, "wb").write(nl.join(lines).encode("utf-8"))
        done.append(n); print("added to", n, "at line", i + 1)
    # the list in scrModInit
    ip = os.path.join(sd, "scrModInit.gml")
    raw = open(ip, "rb").read().decode("utf-8")
    m = re.search(r'global\.modOvrList="([^"]*)"', raw)
    have = [x for x in m.group(1).split(",") if x] if m else []
    allnames = sorted(set(have) | set(done), key=str.lower)
    new = 'global.modOvrList="%s"' % ",".join(allnames)
    raw = raw.replace(m.group(0), new) if m else raw
    open(ip, "wb").write(raw.encode("utf-8"))
    print(len(allnames), "scripts mods can replace")

if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2:])
