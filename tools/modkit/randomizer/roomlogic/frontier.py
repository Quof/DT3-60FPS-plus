"""frontier.py: where the room logic stops: exits it reaches whose way in on the other side it doesn't (the entry fails),
and, in rooms it reaches, the exits it doesn't (something in the room stops it), with the room each leads to"""
import os, sys, collections
HERE = os.path.dirname(os.path.abspath(__file__))
regions = os.path.join(HERE, "work", "roomlogic_regions.txt")
room_need = {}
for line in open(os.path.join(HERE, "roomlogic.txt"), encoding="utf-8"):
    f = line.split()
    if len(f) >= 3 and f[0] == "room": room_need[f[1]] = f[2]
entry = {}
exits = []
for line in open(regions, encoding="utf-8"):
    f = line.split()
    if f[0] == "entry": entry[(f[1], f[2])] = f[3]
    elif f[0] == "exit": exits.append((f[1], f[2], f[4], f[5], f[6]))
print("== exits reached, their entry not (the way in fails):")
for room, at, to, nxy, need in exits:
    if need != "never" and entry.get((to, nxy), "never") == "never" and room_need.get(to, "never") == "never":
        print("  %s %s -> %s %s   (exit needs %s)" % (room, at, to, nxy, need))
print("== exits not reached in rooms that are, leading to rooms not reached:")
for room, at, to, nxy, need in exits:
    if need == "never" and room_need.get(room, "never") != "never" and room_need.get(to, "never") == "never":
        print("  %s %s -> %s %s   (room needs %s)" % (room, at, to, nxy, room_need[room]))
