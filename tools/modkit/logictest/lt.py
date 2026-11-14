r"""
Logic Test: runs test routes in the game through the LogicTest mod (mod\ here; README.txt lists its commands).

  python lt.py install <game folder>            copies mod\ into <game>\Mods\LogicTest (changed files only)
  python lt.py enable <game folder> [mods...]   turns LogicTest (and the mods named, e.g. Randomizer) on in that
                                                 game's Saves\DT3Options.dts; the game must not be running
  python lt.py run <game folder> <commands file> [--timeout SECONDS]
                                                 sends the commands to the running game and prints its results
                                                 (exit code 1 if the run ended with an error)

The game reads Mods\LogicTest\cmd.txt (it looks twice a second), deletes it, writes out.txt and then done.txt.
"""
import os, sys, time, shutil, hashlib, argparse

HERE = os.path.dirname(os.path.abspath(__file__))
MOD_SRC = os.path.join(HERE, "mod")


def ltdir(game):
    return os.path.join(game, "Mods", "LogicTest")


def same(a, b):
    if not os.path.exists(b) or os.path.getsize(a) != os.path.getsize(b):
        return False
    with open(a, "rb") as fa, open(b, "rb") as fb:
        return hashlib.sha1(fa.read()).digest() == hashlib.sha1(fb.read()).digest()


def install(game):
    dst = ltdir(game)
    n = 0
    for root, dirs, files in os.walk(MOD_SRC):
        for f in files:
            src = os.path.join(root, f)
            to = os.path.join(dst, os.path.relpath(src, MOD_SRC))
            if not same(src, to):
                os.makedirs(os.path.dirname(to), exist_ok=True)
                shutil.copyfile(src, to)
                print("copied", os.path.relpath(src, MOD_SRC))
                n += 1
    print(n, "file(s) changed in", dst)


def enable(game, mods):
    # a small edit of the [MODS] section, so the rest of the file stays as the game wrote it
    p = os.path.join(game, "Saves", "DT3Options.dts")
    text = open(p, "rb").read().decode("cp1252") if os.path.exists(p) else ""
    lines = text.split("\r\n") if "\r\n" in text else text.split("\n")
    want = ["LogicTest"] + mods
    start = None
    for i, l in enumerate(lines):
        if l.strip().upper() == "[MODS]":
            start = i
            break
    if start is None:
        if lines and lines[-1] == "":
            lines.pop()
        lines += ["[MODS]"] + [m + "=1" for m in want] + [""]
    else:
        end = start + 1
        while end < len(lines) and not lines[end].startswith("["):
            end += 1
        sec = lines[start + 1:end]
        for m in want:
            for j, l in enumerate(sec):
                if l.split("=", 1)[0].strip().lower() == m.lower():
                    sec[j] = m + "=1"
                    break
            else:
                k = len(sec)
                while k > 0 and sec[k - 1].strip() == "":
                    k -= 1
                sec.insert(k, m + "=1")
        lines[start + 1:end] = sec
    open(p, "wb").write("\r\n".join(lines).encode("cp1252"))
    print("on in", p + ":", ", ".join(want))


def run(game, cmdfile, timeout, quiet=False):
    d = ltdir(game)
    if not os.path.isdir(d):
        sys.exit("no " + d + " (python lt.py install first)")
    for f in ("done.txt", "out.txt"):
        p = os.path.join(d, f)
        if os.path.exists(p):
            os.remove(p)
    cmds = open(cmdfile, encoding="utf-8").read().replace("\r\n", "\n")
    tmp = os.path.join(d, "cmd.tmp")
    with open(tmp, "w", encoding="cp1252", newline="\r\n") as f:
        f.write(cmds if cmds.endswith("\n") else cmds + "\n")
    os.replace(tmp, os.path.join(d, "cmd.txt"))
    t0 = time.time()
    done = os.path.join(d, "done.txt")
    while not os.path.exists(done):
        if time.time() - t0 > timeout:
            print("no results after", timeout, "s (is the game running, with LogicTest on?)")
            if os.path.exists(os.path.join(d, "cmd.txt")):
                os.remove(os.path.join(d, "cmd.txt"))
                print("(the commands were never picked up: cmd.txt taken away again)")
            return 2
        time.sleep(0.2)
    out = open(os.path.join(d, "out.txt"), "rb").read().decode("cp1252", "replace")
    if not quiet:
        print(out, end="")
        print("(%.1f s)" % (time.time() - t0))
    return 1 if any(l.startswith("error") for l in out.splitlines()) else 0


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("what", choices=["install", "enable", "run"])
    ap.add_argument("game")
    ap.add_argument("rest", nargs="*")
    ap.add_argument("--timeout", type=float, default=600)
    a = ap.parse_args()
    if a.what == "install":
        install(a.game)
    elif a.what == "enable":
        enable(a.game, a.rest)
    else:
        if not a.rest:
            sys.exit("run: which commands file?")
        sys.exit(run(a.game, a.rest[0], a.timeout))


if __name__ == "__main__":
    main()
