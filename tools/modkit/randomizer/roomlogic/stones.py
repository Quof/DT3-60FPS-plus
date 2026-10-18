"""
stones.py: the Teleporting Stones for the Check Tracker's ways there (its Entrance Tracker: the way from Central City
into a room the player has been to, warping between the stones they've activated where that's shorter). Each room with
a stone (oWarpStatue: its network, area 0 the main world or 1-6 a gate, and its number in the teleport menu, gateNum)
is worked out again as roomlogic.py has it with its stones in it too, each a place (type 98, number network*100 + its
number) and a way in (where warping to it puts the player: the stone itself, as oTeleportMenu has them), by
RoomLogic.exe --stones, into stones\\<room>.txt. The logic and the seeds don't read them: the tracker build does
(tracker.py's stone_tables), with overrides.txt as for the rest. Run it after roomlogic.py (it uses its work\\rooms.txt
and RoomLogic.exe), when a stone's room has changed.

usage: python stones.py
"""
import os, sys, subprocess
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.dirname(HERE))
import roomlogic
OUT = os.path.join(HERE, "stones")
# (the old Forest Palace's copy of Gate 2's stone 3: nothing leads into its rooms)
SKIP_ROOMS = {"rLink2_PalaceB_1"}


def stones():
    """[(room, x, y, number)]: each stone in a room the room logic has, its number network*100 + its own"""
    import rndgen
    out = []
    for room in rndgen.room_names():
        if room in SKIP_ROOMS or not os.path.exists(os.path.join(roomlogic.ROOMS_DIR, room + ".txt")): continue
        for obj, x, y, hexid, code in rndgen.instances(room) or []:
            if obj == "oWarpStatue":
                out.append((room, x, y, (rndgen.num(code or "", "area") or 0) * 100 + (rndgen.num(code or "", "gateNum") or 0)))
    return out


def main():
    rooms = os.path.join(roomlogic.WORK, "rooms.txt")
    if not os.path.exists(rooms): raise SystemExit("no work\\rooms.txt: run roomlogic.py first")
    exe, cs = os.path.join(roomlogic.WORK, "RoomLogic.exe"), os.path.join(HERE, "RoomLogic.cs")
    if not os.path.exists(exe) or os.path.getmtime(exe) < os.path.getmtime(cs):
        csc = next((c for c in roomlogic.CSC if os.path.exists(c)), None)
        if not csc: raise SystemExit("the .NET Framework 4's C# compiler (csc.exe) isn't there: it builds RoomLogic.exe")
        subprocess.check_call([csc, "/nologo", "/O+", "/out:" + exe, "/r:System.Drawing.dll", cs])
    st = stones()
    os.makedirs(OUT, exist_ok=True)
    subprocess.check_call([exe, "--stones", roomlogic.PROJ, rooms, OUT] + ["%s:%d,%d:%d" % s for s in st])
    print("%d stones in %d rooms: %s" % (len(st), len({s[0] for s in st}), OUT))


if __name__ == "__main__":
    main()
