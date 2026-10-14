"""blockers.py: for the rooms where the room logic stops (a room it reaches, with an exit or location it doesn't), the
kinds of object in them the logic doesn't model, counted over those rooms (which mechanics matter most)"""
import os, sys, collections
HERE = os.path.dirname(os.path.abspath(__file__))
PROJ = os.path.normpath(os.path.join(HERE, "..", "..", "..", ".."))
room_need, stuck = {}, set()
for line in open(os.path.join(HERE, "roomlogic.txt"), encoding="utf-8"):
    f = line.split()
    if len(f) >= 3 and f[0] == "room": room_need[f[1]] = f[2]
for line in open(os.path.join(HERE, "roomlogic.txt"), encoding="utf-8"):
    f = line.split()
    if len(f) >= 5 and f[0] == "loc" and f[3] == "never" and room_need.get(f[4], "never") != "never": stuck.add(f[4])
for line in open(os.path.join(HERE, "work", "roomlogic_regions.txt"), encoding="utf-8"):
    f = line.split()
    if f[0] == "exit" and f[-1] == "never" and room_need.get(f[1], "never") != "never" and room_need.get(f[4], "never") == "never":
        stuck.add(f[1])
COMMON = {"oPlayer1", "oInvCollPH", "oInvisibleSolid", "oInvCollSM", "oInvCollSH", "oExit", "oSignPost", "oLevelDecal",
          "oMisc", "oHealingPost", "oWarpStatue", "oCheckpointSpot", "oMetroidCheckpoint", "oSmallGlow", "oEmSmokeA"}
per = collections.Counter(); rooms_with = collections.defaultdict(list)
for r in sorted(stuck):
    ip = os.path.join(PROJ, "rooms", r, "instances.txt")
    if not os.path.exists(ip): continue
    objs = set(l.split(",")[0] for l in open(ip, encoding="utf-8", errors="replace") if l.strip())
    for o in objs - COMMON:
        per[o] += 1; rooms_with[o].append(r)
print("stuck rooms:", len(stuck))
for o, n in per.most_common(70):
    print("%4d %-28s %s" % (n, o, " ".join(rooms_with[o][:5])))
