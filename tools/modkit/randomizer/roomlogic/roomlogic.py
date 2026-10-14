"""
roomlogic.py: works out the Randomizer's logic from the game's rooms (README.txt explains it all):
  1. roomdata.py: the rooms as the logic sees them (work\\rooms.txt)
  2. RoomLogic.exe (built from RoomLogic.cs with the .NET Framework's C# compiler when the .cs is newer): every room's
     moves, written as each room's logic file (rooms\\<room>.txt) and connections.txt
  3. solve.py: the rooms joined from the start, with overrides.txt: roomlogic.txt
and checks that solve.py, without overrides, gets what RoomLogic.exe's own joining does (work\\roomlogic_check.txt).
Run it again after changing the game's rooms or RoomLogic.cs; for overrides.txt, solve.py alone is enough.

usage: python roomlogic.py
"""
import os, sys, time, shutil, subprocess
HERE = os.path.dirname(os.path.abspath(__file__))
PROJ = os.path.normpath(os.path.join(HERE, "..", "..", "..", ".."))
WORK = os.path.join(HERE, "work")
ROOMS_DIR = os.path.join(HERE, "rooms")
CSC = [os.path.join(os.environ.get("WINDIR", r"C:\Windows"), "Microsoft.NET", f, "v4.0.30319", "csc.exe")
       for f in ("Framework64", "Framework")]


def main():
    os.makedirs(WORK, exist_ok=True)
    rooms = os.path.join(WORK, "rooms.txt")
    subprocess.check_call([sys.executable, os.path.join(HERE, "roomdata.py"), rooms])
    exe, cs = os.path.join(WORK, "RoomLogic.exe"), os.path.join(HERE, "RoomLogic.cs")
    if not os.path.exists(exe) or os.path.getmtime(exe) < os.path.getmtime(cs):
        csc = next((c for c in CSC if os.path.exists(c)), None)
        if not csc: raise SystemExit("the .NET Framework 4's C# compiler (csc.exe) isn't there: it builds RoomLogic.exe")
        subprocess.check_call([csc, "/nologo", "/O+", "/out:" + exe, "/r:System.Drawing.dll", cs])
    started = time.time() - 2
    subprocess.check_call([exe, PROJ, rooms, HERE])
    # a room whose analysis failed (a bug in RoomLogic.cs): its file is missing ways, so stop here
    failed = sorted({ln.split(":")[0] for ln in open(os.path.join(WORK, "roomlogic_log.txt"), encoding="utf-8", errors="replace")
                     if ": failed:" in ln})
    if failed: raise SystemExit("the analysis failed in %s (work\\roomlogic_log.txt says why)" % ", ".join(failed))
    # a room file this run didn't write (a room the game doesn't have any more) goes to work\stale_rooms
    for fn in os.listdir(ROOMS_DIR):
        p = os.path.join(ROOMS_DIR, fn)
        if fn.endswith(".txt") and os.path.getmtime(p) < started:
            os.makedirs(os.path.join(WORK, "stale_rooms"), exist_ok=True)
            shutil.move(p, os.path.join(WORK, "stale_rooms", fn))
            print("not a room any more: rooms\\%s moved to work\\stale_rooms" % fn)
    sys.path.insert(0, HERE)
    import solve
    # the check: joined without overrides, the same as RoomLogic.exe's own joining (which has each room come into with
    # the carried states as a new game starts them)
    rms = solve.load_rooms(); conn = solve.load_connections()
    res = solve.solve(rms, conn, carry=False)
    diffs = solve.check(res, os.path.join(WORK, "roomlogic_check.txt")) + solve.check_rooms(rms, res, os.path.join(WORK, "roomlogic_check.txt"))
    if diffs:
        print("solve.py and RoomLogic.exe differ (%d), a bug in one of them:" % len(diffs))
        print("\n".join(diffs[:20]))
    else:
        print("check: solve.py gets what RoomLogic.exe's own joining does")
    # the result, with overrides
    rms = solve.load_rooms(); conn = solve.load_connections()
    n = solve.load_overrides(rms, conn)
    reached, total = solve.write_result(rms, solve.solve_events(rms, conn))
    print("overrides %d; places reached %d of %d; written %s" % (n, reached, total, solve.OUT))
    if diffs: raise SystemExit("the check failed: find the bug before building the mod with these room files")


if __name__ == "__main__":
    main()
