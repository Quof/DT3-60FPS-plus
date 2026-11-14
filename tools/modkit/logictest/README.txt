LOGIC TEST
==========

A mod (mod\, installed as Mods\LogicTest) that plays routes in the real game from a file of commands, for checking the
Randomizer's room logic: where the player goes from a way in, with a given set of items, at 30, 60 or 120fps. It does
nothing until a command file is there.

  python lt.py install <game folder>           mod\ into <game>\Mods\LogicTest (changed files only)
  python lt.py enable <game folder> Randomizer  LogicTest and the Randomizer on (Saves\DT3Options.dts; game closed)
  python lt.py run <game folder> <file>         sends <file>'s commands to the running game, prints the results

Built on it: calib.py (the room logic's movement against the game's, below) and roomdump.py (the rooms as the game
makes them against the room logic's view of them, and the moving platforms' ways: THE ROOMS AS THE GAME MAKES THEM).

How it works: the runner (oLTRunner, persistent) looks for Mods\LogicTest\cmd.txt twice a second. A run reads it,
deletes it, runs the commands frame by frame and writes the results to out.txt, then makes done.txt. The buttons are
put in as the gamepad's (global.gpHeld, right after oKeyCodesHighFPS's Begin Step has read the pad, with Gamepad Input
on for the run), so the player reads them as it would a real pad's: frame-exact, and the game window doesn't need to
be in front. The game speed can be raised (speed) without changing what happens in a frame.

A route needs a game going: newgame starts a Randomizer game (from the title screen, into Saves\LogicTest.dts, never a
save slot), and items sets what the player has.


COMMANDS
--------

One a line; # starts a comment. TIME is in ticks (30ths of a second) or, for the ...f versions, frames (2 a tick at
60fps, 4 at 120fps). An unknown command or a wrong argument ends the run with an error line.

  newgame [SEED]          a Randomizer game (needs the Randomizer on) with the options as they are and the seed (or a
                          random one); waits till the player is in its first room (Central City - North). From the
                          title screen; from anywhere else the title screen is gone to first
  set NAME VALUE          a global variable: a number, or "text" (e.g. set rndOptER 0, set rndOptLog 0 before newgame)
  get NAME                its value in the results
  items NAME...           what the player has, in place of what they had: jump dash airdash double hjb[=2] mario
                          link[=1-3] belmont[=1-3] mega[=1-4] samus[=1-7] jgame[=1-2] cgame[=1-2] varia nmsword
                          nmcharge nmdagger nmbomb air=N key=DOOR chip=N all none. A set's number is how many of its
                          items were found (link=2: Master Sword and Bow). Program Chips only count with Chip
                          Randomizer (without it the player has all six)
  char jerry|claire       who the player is from the next room on
  fps 30|60|120           the frame rate (then goto, so the room's objects start at that rate)
  goto ROOM X Y           into the room as an exit leading to X,Y puts the player there (the room logic's "in X,Y");
                          waits till the room has started
  hold KEYS TIME [room]   holds the buttons (names joined by +) for that long; with room, stops early when a room
                          starts (else the results say noroom). Buttons: left right up down jump a b c swap abil skip
                          pause dashl dashr confirm cancel, or none
  holdf KEYS FRAMES [room]
  wait TIME [room]        holds nothing
  waitf FRAMES [room]
  trace TIME / tracef N   the player's place in the results every so often (0: off)
  pos                     the player's place now
  log TEXT                a line in the results
  shot NAME               the screen (as last drawn) to Mods\LogicTest\shots\NAME.png
  speed N                 the game runs N times as fast (same frames)
  god [off]               the player's life kept full
  nohit [off]             nothing hurts the player, so what hits them doesn't push them either
  life N                  the player's life
  exec CODE               GameMaker code, run as it is (the game's scripts, not a mod's)
  dump NAME               every instance in the room now, to Mods\LogicTest\dumps\NAME.txt (roomdump.py reads them)
  snap                    the globals Mods\LogicTest\snap.txt names (a name a line; name[i] an array's element), as
                          they are now
  restore                 the globals snap took, put back
  track NAME FRAMES       for that many frames, where each instance of the objects Mods\LogicTest\track.txt names (an
                          object a line) is, written when it moves: Mods\LogicTest\tracks\NAME.txt (F frame id object x y)
  end                     the run ends here (it also ends after the last line)
  quit                    the run ends and the game closes


RESULTS (out.txt)
-----------------

  start DATE fps N PLACE         the run started
  room ROOM X,Y fF               a room started (X,Y: where the player was sent), at frame F of the run
  exit ROOM X,Y -> ROOM X,Y fF   the player went through the exit at X,Y; where it leads (after the Randomizer's
                                 changes)
  hit DAMAGE WHAT fF PLACE       the player was hit
  got loc TYPE NUMBER fF PLACE   a Randomizer place was taken (as roomlogic names it)
  dead fF PLACE                  the game over screen came up
  t fF PLACE / pos fF PLACE      trace and pos
  items OWN air N keys K chips C what items set (OWN: global.rndOwn 0-16)
  newgame seed N fF              the new game is going
  dump NAME fF                   the room's instances written
  snap N fF                      N globals taken
  noroom fF                      a hold/wait ... room ran out without a room starting
  error line N: TEXT             the run ended on line N
  end fF PLACE                   the run is over

PLACE is ROOM X,Y v XVEL,YVEL life N char C (X,Y the player's feet; the speed in pixels a tick).


THE ROOM LOGIC'S MOVEMENT AGAINST THE GAME'S (calib.py)
--------------------------------------------------------

The room logic's simulation (RoomLogic.cs Sim) is a copy of the game's movement code: characterStepEvent at 30fps
(Step), and above 30fps (StepHi: the 60fps code, pMoveToWrapNew and pMoveTo). calib.py plays the logic's own moves
(RoomLogic.cs Programs) in the game with the input the simulation gives them (RoomLogic.exe --move), and compares the
paths. The game's rounding is set as each move starts so it can be compared pixel for pixel: the 30fps timer
(oGame.time30 -1: the simulation's tick count starts at 0) and, above 30fps, the player's ditherCounter (0).

  python calib.py run <game> [--moves ID,...] [--chars 0,1] [--fps 30,60,120] [--t30 -1] [--dither 0] [--out NAME]
                                  the moves' paths, game and simulation, tick by tick: calib\NAME.txt (default
                                  measured; a run of some moves replaces only theirs) and NAME_report.txt
  python calib.py verify <game> [same options]
                                  the moves frame by frame up to where the simulation stops (its landing frame
                                  included): the ones where any frame differs
  python calib.py diag <game> --moves ID --chars C --fps F [--dither 0 --t30 -1]
                                  one move side by side, frame by frame, around the frame where they part
  python calib.py check <game>    runs the kept moves again and compares the game's paths with calib\measured.txt
                                  (has the game's movement changed?)
  python calib.py report          the comparison again, with the logic's own moves (95%: Sim.Slack) beside them

--sim-extra "oldexe=1" compares with the game as it was before 2026-10-21 (no tRelNow, Gate 5's upgrades without
their own 60/120fps corrections), what the project's "v2" exe (DT3_LogicTest.exe in the test copy) was built from.

The moves (MOVES in calib.py) start on Central City - North's flat floor, Gate 5's Lv0_A shaft (the High Jump Boots),
Megapolis SigmaA3's shaft (wall jumps), Central City - North's slope and the Central City Bridge's channel (water).
A move whose start can't be gone to (inside a Morph Ball tunnel: g5gap) has goto= (where to go first) and setup=
(LogicTest lines after it: taking objects away, putting the player at the start).


THE LOGIC'S ROUTES IN THE GAME (verify.py)
------------------------------------------

The room files' routes (..\randomizer\roomlogic\rooms\<room>.txt, "how in X -> T"), played in the game step by step:
for a row of the logic (stress.txt ranks them), each alternative's items given, the player put where each step starts
and the step's input played as the simulation gives it (its {move ...} fields, RoomLogic.exe --move --slack 1), and
where they end up checked against the step's "->". At 30, 60 and 120fps. It shows an alternative is enough, not that
each of its items is needed (that's the simulation's search alone).

  python verify.py run <game> [--top N] [--rows TEXT;...] [--fps 30,60,120] [--fresh]
                                  the rows (the top N of stress.txt, or those whose text has one of TEXTs, ;-separated);
                                  results in calib\verify.txt (--fresh: all of them made again)
  python verify.py report         ..\randomizer\roomlogic\verify_report.txt: verified, failed, hazard, simulator-only,
                                  needs a person, and each problem

What the test does that the logic takes as given: enemies and their shots switched off before each step (latch
crystals kept); a Metroid door on the way opened (the alternative's weapon is the logic's part); a run started at full
speed with the direction held (k*PushedSteps 5, as the simulation starts it); a landing's slide pushed back on for 3
ticks; a walk within a standing place done by putting the player at its end. A step that fails with a hit in it is
played again with nohit: one that gets there then is "hazard" (Gate C's spike shadows, a trap the logic leaves out). A
failure noted "the simulation at the game's strength lands at ... too" is the logic's 0.95 jumps (Sim.Slack) getting
somewhere the game's full-strength jump doesn't. Not played yet: switches, moving platforms and elevators, travel
cannons, latch crystal bounces, the overworld maps.

THE ROOMS AS THE GAME MAKES THEM (roomdump.py)
----------------------------------------------

The room logic reads the rooms from the project (..\randomizer\roomlogic\roomdata.py: each instance's creation code and
Create event, in the Randomizer's world). roomdump.py has the game itself make them: it goes into each room the logic
has by each of its ways in, waits a second and dumps every instance (what the rooms' code, every object's Create, Step
and Alarm events and the Randomizer's own changes have left), then compares that with roomdata.py's work\rooms.txt.
Each room is come into with the globals as a new game has them (snap after the new game, restore before each goto),
not as the room before left them (the boss gallery's flag, a party split, abilities a room takes away...).

  python roomdump.py run <game> [--rooms R,...] [--resume] [--retry-errors]
                                  the dumps (the game with a LogicTest game going: tests\roomdump_start.txt, which has
                                  the options the room logic assumes), into <game>\Mods\LogicTest\dumps
  python roomdump.py compare <game> [--rooms R,...] [--out FILE]
                                  what differs (default ..\randomizer\roomlogic\work\roomdump_compare.txt), room by
                                  room: things only the game has, only the logic has, moved since they were made, moving
                                  (somewhere else a moment later), gates open in the game, exits leading elsewhere; each
                                  with the ways in that have it
  python roomdump.py digest <game>
                                  ..\randomizer\roomlogic\gamestate.txt, what roomdata.py takes in from it (the logic's
                                  lines the game hasn't, still things the game has, things that moved and stopped, exits
                                  leading elsewhere, walls enemies make as gates), and at its end what it leaves for
                                  review (moving things, places, the game's barriers, exits only some ways in have, what
                                  changes as the player comes near)

  python roomdump.py track <game>  the moving things' ways: each room where something moved between its two dumps, come
                                  into again, every instance of those objects where it is each frame for 20 seconds
                                  (LogicTest's track) into <game>\Mods\LogicTest\tracks; digest then takes the moving
                                  platforms' ways in (their N lines), and lists the rest
  python roomdump.py paths <game>  each mover's way as the game has it beside the logic's (..\randomizer\roomlogic\
                                  work\roomdump_paths.txt)

Two dumps are made a second apart: what moved between them is moving (the movers' part of the logic), not taken in.
Neither is what changes as the player comes near (a Step that looks at how far the player is: Gate 4's columns that
drop from the ceiling, the Hidden Program Facility's blocks that fall away, Neo Grime City's Chaos elevators, and what
only they make),
nor the logic's line of one: the room as it starts doesn't say how they are when the player gets there. A wall an
enemy makes and takes away when it's beaten (Contra's wall and its turrets, a junkyard car, a Drill Waying's pillar,
risen) is taken in as a gate that opens with what beats the enemy (..\randomizer\traps.py's rule).
Boss rooms are dumped again as they are after their fight (the logic has the fight as going into the room): a whole
run ends with them, every boss beaten (--after 'exec global.rndBossDone=string_repeat("1",global.rndBossN)'; --after
takes any LogicTest line, run after each restore).

The comparison goes by each thing's kind and collision box (the game's bbox; the logic's worked out from its sprite as
the game does), places by their type and number (the Randomizer's own story pickups by their mask, the story item's
sprite, and number), exits by where they lead (overrides.txt's links counted). A way in
where the game stops (an error message: no new dump for 15 seconds) is written to calib\roomdump_errors.txt, the game
started again (minimised) and the run goes on; those ways in are left out after that (--retry-errors tries them).
Rooms it can't go into: the maps (no player) and rBT_ZeroC (its timed barrier at 1120,272 waits for ten switches by
GID, only one of which sets its GID: its Draw event stops the game with an error).
