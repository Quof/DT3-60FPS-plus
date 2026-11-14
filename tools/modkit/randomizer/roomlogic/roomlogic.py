"""
roomlogic.py: works out the Randomizer's logic from the game's rooms (README.txt explains it all):
  1. roomdata.py: the rooms as the logic sees them (work\\rooms.txt)
  2. RoomLogic.exe (built from RoomLogic.cs with the .NET Framework's C# compiler when the .cs is newer): every room's
     moves at 30, 60 and 120fps (work\\fps30, work\\fps60, work\\fps120, the three at once: an hour or two), made into
     one logic file per room (combine_fps.py: rooms\\<room>.txt, each way needing what it needs at every frame rate, as
     a seed has to be finishable at whichever the player picks) and connections.txt
  3. solve.py: the rooms joined from the start, with overrides.txt: roomlogic.txt
  4. graph.py: the same as one directed graph, its ways in, ways out and doors numbered for good: graph.txt, ids.txt,
     directions.txt
  5. tests.py: overrides.txt's lines as tests of the simulation alone: tests.txt
  6. checks.py: the logic's automatic checks (the story run, asymmetric doors, "from *" lines, softlocks): checks.txt
and checks that solve.py, without overrides, gets what RoomLogic.exe's own joining does (work\\fps30\\roomlogic_check.txt),
and that graph.txt solved alone gets roomlogic.txt (work\\graph_check.txt).
Run it again after changing the game's rooms or RoomLogic.cs; for overrides.txt, solve.py alone is enough.

usage: python roomlogic.py
"""
import os, sys, shutil, hashlib, subprocess
HERE = os.path.dirname(os.path.abspath(__file__))
PROJ = os.path.normpath(os.path.join(HERE, "..", "..", "..", ".."))
WORK = os.path.join(HERE, "work")
ROOMS_DIR = os.path.join(HERE, "rooms")
FPS = (30, 60, 120)
CSC = [os.path.join(os.environ.get("WINDIR", r"C:\Windows"), "Microsoft.NET", f, "v4.0.30319", "csc.exe")
       for f in ("Framework64", "Framework")]


def file_hash(path):
    return hashlib.sha1(open(path, "rb").read()).hexdigest()


def main():
    os.makedirs(WORK, exist_ok=True)
    rooms = os.path.join(WORK, "rooms.txt")
    subprocess.check_call([sys.executable, os.path.join(HERE, "roomdata.py"), rooms])
    exe, cs = os.path.join(WORK, "RoomLogic.exe"), os.path.join(HERE, "RoomLogic.cs")
    if not os.path.exists(exe) or os.path.getmtime(exe) < os.path.getmtime(cs):
        csc = next((c for c in CSC if os.path.exists(c)), None)
        if not csc: raise SystemExit("the .NET Framework 4's C# compiler (csc.exe) isn't there: it builds RoomLogic.exe")
        subprocess.check_call([csc, "/nologo", "/O+", "/out:" + exe, "/r:System.Drawing.dll", cs])
    # every room analysed at each frame rate, the three at once, each into its own folder (work\fps30, work\fps60,
    # work\fps120: its rooms\, connections.txt and log); a frame rate whose folder was made from the same rooms.txt by
    # the same RoomLogic.exe (its stamp.txt) isn't analysed again
    stamp = file_hash(rooms) + " " + file_hash(exe)
    runs = {}
    for fps in FPS:
        d = os.path.join(WORK, "fps%d" % fps)
        sp = os.path.join(d, "stamp.txt")
        if os.path.exists(sp) and open(sp).read().strip() == stamp:
            print("%dfps: the analysis in work\\fps%d is up to date" % (fps, fps)); continue
        if os.path.exists(sp): os.remove(sp)
        if os.path.isdir(os.path.join(d, "rooms")): shutil.rmtree(os.path.join(d, "rooms"))
        os.makedirs(d, exist_ok=True)
        shutil.copyfile(rooms, os.path.join(d, "rooms.txt"))
        out = open(os.path.join(d, "run.txt"), "w")
        runs[fps] = (subprocess.Popen([exe, PROJ, os.path.join(d, "rooms.txt"), d, "--fps", str(fps)], stdout=out,
                                      stderr=subprocess.STDOUT), out, sp)
        print("%dfps: analysing every room (work\\fps%d\\run.txt shows how far)" % (fps, fps))
    for fps, (p, out, sp) in runs.items():
        if p.wait(): raise SystemExit("RoomLogic.exe --fps %d stopped with %d (work\\fps%d\\run.txt)" % (fps, p.returncode, fps))
        out.close()
        # a room whose analysis failed (a bug in RoomLogic.cs): its file is missing ways, so stop here
        failed = sorted({ln.split(":")[0] for ln in open(os.path.join(WORK, "fps%d" % fps, "roomlogic_log.txt"),
                         encoding="utf-8", errors="replace") if ": failed:" in ln})
        if failed: raise SystemExit("the %dfps analysis failed in %s (work\\fps%d\\roomlogic_log.txt says why)" % (fps, ", ".join(failed), fps))
        open(sp, "w").write(stamp + "\n")
    # the room files: each way needs what it needs at 30, 60 and 120fps (combine_fps.py; a player plays at any of them)
    sys.path.insert(0, HERE)
    import combine_fps
    dirs = [os.path.join(WORK, "fps%d" % fps, "rooms") for fps in FPS]
    names = sorted(fn for fn in os.listdir(dirs[0]) if fn.endswith(".txt"))
    os.makedirs(ROOMS_DIR, exist_ok=True)
    n_more = 0
    for fn in names:
        n_more += combine_fps.combine([os.path.join(d, fn) for d in dirs], os.path.join(ROOMS_DIR, fn))
    shutil.copyfile(os.path.join(WORK, "fps30", "connections.txt"), os.path.join(HERE, "connections.txt"))
    print("rooms\\: %d rooms, %d ways need more at 60 or 120fps than at 30fps" % (len(names), n_more))
    # a room file this run didn't write (a room the game doesn't have any more) goes to work\stale_rooms
    for fn in os.listdir(ROOMS_DIR):
        p = os.path.join(ROOMS_DIR, fn)
        if fn.endswith(".txt") and fn not in names:
            os.makedirs(os.path.join(WORK, "stale_rooms"), exist_ok=True)
            shutil.move(p, os.path.join(WORK, "stale_rooms", fn))
            print("not a room any more: rooms\\%s moved to work\\stale_rooms" % fn)
    import solve
    # the check: the 30fps room files joined without overrides, the same as RoomLogic.exe's own joining (which has each
    # room come into with the carried states as a new game starts them)
    check_file = os.path.join(WORK, "fps30", "roomlogic_check.txt")
    rms = solve.load_rooms(dirs[0]); conn = solve.load_connections()
    res = solve.solve(rms, conn, carry=False)
    diffs = solve.check(res, check_file) + solve.check_rooms(rms, res, check_file)
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
    # the whole game as one directed graph with permanent numbers (graph.py: graph.txt, ids.txt, directions.txt), made
    # beside the rest (the build still goes by roomlogic.txt and erflat.py's tables), and checked: solved alone, it has to
    # get what roomlogic.txt has
    import graph
    info = graph.build()
    e = info["edges"]
    print("graph.txt: %d edges in rooms from the room logic, %d from overrides.txt lines, %d ways out to ways in" % (e["room"], e["override"], e["exit"]))
    for what, kind, key in info["changes"]: print("ids.txt: %s %s %s" % (what, kind, key))
    for p in info["problems"]: print("ids.txt: " + p + ": old saves need it")
    gd = graph.check()
    if gd:
        print("\n".join(gd[:20]))
        raise SystemExit("the graph's check failed: graph.txt solved alone doesn't get what roomlogic.txt has (%d lines)" % len(gd))
    print("graph.txt solved alone: the same as roomlogic.txt")
    # overrides.txt's lines as tests of the simulation (tests.py: tests.txt): which it passes, and where it differs
    import tests
    results = tests.run()
    cnt, ways = tests.write(results)
    print("tests.txt: overrides.txt's %d lines as tests of the simulation: %d pass, %d drop, %d blanket, %d unseen, %d fail, %d beyond, %d rules" % (
        len(results), cnt["pass"], cnt["drop"], cnt["blanket"], cnt["unseen"], cnt["fail"], cnt["beyond"], cnt["rule"]))
    # the logic's automatic checks (checks.py: checks.txt): the story run, asymmetric doors, "from *" lines, softlocks
    import checks
    checks.main()


if __name__ == "__main__":
    main()
