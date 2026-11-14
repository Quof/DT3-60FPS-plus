"""Phase F.9, the tracker playthroughs: seeds made as the mod makes them (stress.py's make_seed: erflat.py's shuffle,
fill and draws) for the options with Entrance Rando, written for trackerplay.html, which plays each one through with
only what the Check Tracker shows (tracker.js's DT3.reach with the Entrance Tracker's known doors): take every check in
logic; with none, go through an unexplored door (both its ends found); till every progression item is got. It must
never be left with nothing in logic and nothing unexplored.

    python trackerplay.py <a build's folder (rndgen.py's out)> <folder to write to> [seeds per option set, default 20]

Copies the build's tracker folder there with trackerplay.html, trackerplay.js and seeds.js. The pages' scripts run
only from a web server (python -m http.server, the folder's parent served): open trackerplay.html there."""
import json, os, random, shutil, sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE); sys.path.insert(0, os.path.dirname(HERE))
import erflat, rndgen, stress

OPTIONS = [o for o in stress.OPTIONS if o[1]]      # (the Entrance Rando ones: the Entrance Tracker's doors)


def main():
    build, out = sys.argv[1], sys.argv[2]
    n = int(sys.argv[3]) if len(sys.argv) > 3 else 20
    dst = os.path.join(out, "tracker")
    if os.path.exists(dst): shutil.rmtree(dst)
    shutil.copytree(os.path.join(build, "tracker"), dst)
    for name in ("trackerplay.html", "trackerplay.js"): shutil.copy(os.path.join(HERE, name), dst)
    rows, items = rndgen.locations_items()[8:10]
    f, w, pairs, digest, bp, hv = erflat.build_data(rows, os.path.join(HERE, "work", "trackerplay_rndER.txt"),
                                                    rndgen.boss_slots(rndgen.boss_list()))
    built = open(os.path.join(build, "data", "rndER.txt"), encoding="utf-8").read().split("\n")[2].strip()
    if built != digest: raise SystemExit("the build's room logic data (%s) isn't this one's (%s): build again" % (built, digest))
    seeds = []
    for oi, opt in enumerate(OPTIONS):
        label, bit, br, ir, chips, td, wpn, spread = opt
        its = rndgen.items_with_chips(items, chips)
        rws = rndgen.skip_td_rows(rows) if td else rows
        made = tries = 0
        while made < n and tries < n * 60:
            rng = random.Random(7000003 * (oi + 1) + tries)
            tries += 1
            s = stress.make_seed(f, hv, bp, rws, its, opt, rng)
            if s is None: continue
            part, fight, placed = s
            if not erflat.playthrough(f, part, placed, rws, its, fight, ir, chips): continue
            seeds.append({"label": label, "seed": tries - 1, "part": part, "fight": fight, "ir": ir, "td": td,
                          "start": {str(k): v for k, v in erflat.start_have(f, chips).items()},
                          "placed": [[loc, rndgen.prog_of(its[k], ir)] for lay, loc, k in placed]})
            made += 1
        print("%s: %d seeds" % (label, made))
    with open(os.path.join(dst, "seeds.js"), "w", encoding="utf-8", newline="\n") as fh:
        fh.write("window.TP_SEEDS=" + json.dumps(seeds, separators=(",", ":")) + ";\n")
    print("%d seeds written to %s" % (len(seeds), dst))


if __name__ == "__main__":
    main()
