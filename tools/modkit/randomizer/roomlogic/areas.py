"""areas.py: the room logic's result by area: locations reached / not, and rooms reached / not (to see where it stops)"""
import os, sys, collections
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.dirname(HERE))
import rndgen
logic = sys.argv[1] if len(sys.argv) > 1 else os.path.join(HERE, "roomlogic.txt")
anames = rndgen.area_names()
rarea = {}
for line in open(os.path.join(HERE, "work", "rooms.txt"), encoding="utf-8"):
    f = line.rstrip("\n").split("\t")
    if f[0] == "R": rarea[f[1]] = int(f[4])
locs = collections.defaultdict(lambda: [0, 0]); rooms = collections.defaultdict(lambda: [0, 0])
never_rooms = collections.defaultdict(list)
for line in open(logic, encoding="utf-8"):
    f = line.split()
    if not f or f[0].startswith("#"): continue
    if f[0] == "loc":
        a = rarea.get(f[4], -1); locs[a][0 if f[3] != "never" else 1] += 1
    elif f[0] == "room":
        a = rarea.get(f[1], -1); rooms[a][0 if f[2] != "never" else 1] += 1
        if f[2] == "never": never_rooms[a].append(f[1])
print("%-4s %-40s %12s %12s" % ("area", "name", "locs ok/no", "rooms ok/no"))
for a in sorted(set(locs) | set(rooms)):
    print("%-4s %-40s %5d/%-6d %5d/%-6d %s" % (a, anames.get(a, "?")[:40], locs[a][0], locs[a][1], rooms[a][0], rooms[a][1],
                                               " ".join(never_rooms[a][:6]) if rooms[a][0] == 0 else ""))
