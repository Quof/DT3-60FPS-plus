The Randomizer's logic
======================

What it answers: for every place in the game that holds a Randomizer item (a "location": a heart piece, a chest, a key,
a boss's heart container...), what the player needs to get there from the start of a new game. The answer is a list of
alternatives, any one of which is enough; each alternative is a list of abilities, ability set levels and keys. The
Randomizer only puts an ability or a key where the items placed before it make the place reachable, so these answers
decide what can go where.

It's worked out in two parts, and both are text files that can be read and checked:

  1. Each room on its own. For each way into the room, what each way out of it and each place in it needs, from the
     moves inside that room alone, with the moves that do it. These are the room files, rooms\<room>.txt (one a room),
     made by a simulation of the game's own movement (roomlogic.py, about seven minutes).
  2. The rooms joined. connections.txt says which way in each exit leads to; solve.py follows them from the start and
     adds up what each room on the way needs (a few seconds). overrides.txt holds hand-made changes, applied here.

The result is roomlogic.txt. The mod's build (rndgen.py) runs solve.py itself, so overrides.txt always counts.


FILES
-----

  rooms\<room>.txt    each room's logic (made by roomlogic.py from the game's room: don't edit)
  connections.txt     which way in each exit leads to, where a new game starts, which exits are boss fights (made by
                      roomlogic.py from the game's exits: don't edit; change them in overrides.txt)
  overrides.txt       hand-made changes: kept when the rest is made again
  roomlogic.txt       the result: what each place and each room needs from the start (made by solve.py)
  solve.py            joins the rooms; explains any place (its first lines list its commands; ASKING WHY below)
  roomlogic.py        makes the room files and connections.txt again, then solve.py's result, and checks it
  roomdata.py, gmleval.py, RoomLogic.cs
                      the simulation (HOW THE ROOM FILES ARE MADE, below)
  work\               the simulation's working files (made again each run; not kept)

The mod's own build reads these (rndgen.py, one folder up), and ..\logic.txt can replace what a single location needs
as a last resort (CHANGING THE LOGIC).


WORDS
-----

Requirements are written the same way everywhere: alternatives separated by |, any one of which is enough; each a list
(commas or spaces) of these:

  djump             the double jump              adash        the air dash          gdash        the dash
  hijump N          N of the High Jump Boots (1 or 2: they only work in Gate 5, Research Facility)
  mario             the Mario Ability Set (jumping on Mario enemies and bouncing off them, hitting blocks from below)
  link N, belmont N, megaman N, samus N, gamej N, gamec N
                    N items of that ability set: they're progressive, so N is a level. Link 1 the Master Sword, 2 the
                    Bow & Arrow, 3 the Fuse Bomb; Belmont 1 the Hair Whip, 2 the Dagger, 3 Holy Water; Mega Man 1 the
                    X-Buster, 2 Shotgun Ice, 3 the Gravity Well, 4 the Strike Chain (Grapple); Samus 1 the Arm Cannon,
                    2 the Morph Ball, 3 the Charge Beam, 4 Missiles, 5 the Spazer Beam, 6 Bombs, 7 the Diffusion Missile;
                    gamej/gamec Jerry's and Claire's Game Powers (Gate 6 only)
  key N             the key of the locked door whose objectNum is N (..\doors.csv lists them)
  attack            any ability set's attack: link 1, belmont 1, megaman 1 or samus 1 (four alternatives)
  option NAME       only with that option on (none exist yet: FOR LATER)
  nothing, -        walking and jumping alone (a new game has the jump)
  never             no way

The files write "megaman:2"; "megaman 2" means the same.

Places (locations) are named "loc <type> <number>": the type is rndgen.py's (1 heart piece, 2 treasure chest, 3 arrow
quiver, 4 heart energy, 5 missile tank, 6 Game Power, 7 air upgrade, 8 Internetz mod, 9 weapon upgrade, 10 skill
point, 11 bomb upgrade, 12 morph bomb upgrade, 13 key, 14 heart container, 15 the Item Finder, 16 the X-Special charge,
17 the Spring Ball), the number its objectNum. The room files and solve.py also take their names: "skill point 59".


READING A ROOM FILE
-------------------

rooms\rMain_62.txt (Starry Skies - Windy Hills), shortened:

  in 48,1920   # from rMain_61 out 3056,816
      A way in: where the player appears coming into the room. The comment says which exit leads here in the game.
  out 0,224   # to rMain_64 at 3024,656; the player goes into it
      A way out, named by where the exit is placed in the room editor. The comment says where it leads in the game
      (connections.txt is what counts) and how it's used (goes into it, presses up at it, stands on it...).
  loc 10 59   # skill point 59, at 847,1599
      A place.
  from in 48,1920
    out 0,224      djump,megaman:2 | djump,belmont:3
      From that way in, to that way out: the double jump and Shotgun Ice, or the double jump and Holy Water. These
      count only the moves inside this room: what it takes to get to this room is solve.py's part.
  how in 48,1920 -> out 0,224: djump,megaman:2
       1. coming in: holding nothing, from 48,1920; lands at 48,1921
          -> [no ice platforms] standing at x 0-896, y 1905-1969
       4. shoot the ice block at 384,1648 from 490,1729 (at the top of a jump) with Shotgun Ice: [ice platforms out]   [megaman:2]
          -> [ice platforms out] standing at x 490-646, y 1713-1744
      20. running left, jump (held 14 ticks), holding left, double jump at tick 21, from 588,593; lands at 287,545   [djump]
          ...
      The moves that make it, in order: what the player does (a tick is a 30th of a second: the game moves in those
      steps, two frames at 60fps), from where, where they land (->: the place they're then in), and in [ ] what that
      step needs. Coordinates are the room's pixels, as in the room editor; the player's place is where their feet are
      (x the middle of the body, y its bottom). In a room with switches, [the state] comes first: the room is worked
      out in each of its states (ice platforms out or not, blocks moved, bricks broken...).

Other lines: "boss" (going into the room from another one is its boss fight: that needs an attack), "map" (a map or a
menu: every way in reaches every way out). A way in whose comment says "can't be come in at" would put the player
inside a solid: nothing is reached from it (an override can still give it ways).


ASKING WHY
----------

  python solve.py --explain "skill point 59"
      each alternative for that place, as the rooms on the way: for each, the way in, the way out and what that part
      of the room needs. The room file's "how in ... -> ..." lines then say the moves.
  python solve.py --room rMain_62
      what each way in, way out and place of a room needs from the start.

roomlogic.txt has every place's answer ("loc <type> <number> <alternatives> <room>") and every room's ("room <room>
<alternatives>": what getting into it at all needs). ..\locations.csv has the same per place, with area names.


CHANGING THE LOGIC
------------------

If the logic is wrong about a way through a room (a jump it thinks can't be done, or one it thinks can), change that
way in overrides.txt. The change flows on: everything past it is worked out again. Then:

  python solve.py              (a few seconds: roomlogic.txt again; it says if a line is wrong)
  python ..\rndgen.py <out>    (the mod again, with it)

overrides.txt's lines (the file explains them too):

  set <room> in <x,y> -> <way out or place> : <requirements>
      what that way through the room needs, in place of what the room's file says ("in *": from every way in)
  add <room> in <x,y> -> <way out or place> : <requirements>
      another way through, as well as the room file's
  need <room> out <id> : <requirements>
      going through that exit needs this too
  link <room> out <id> -> <room> in <x,y>
      that exit leads somewhere else

Say why in a comment next to each change. Examples:

  # the jump from the ledge to the exit is too hard to count (double jump at the last moment)
  set rMain_62 in 48,1920 -> out 880,96 : never
  # the High Jump Boots get there too
  add rMain_62 in * -> loc skill point 59 : hijump 2

..\logic.txt can replace what a single place needs (or every place in a room) after all this; it doesn't flow on to
other places, so use it only where overrides.txt can't say it.

If the simulation itself is wrong (a move the game allows that it doesn't try, a mechanic it doesn't know), change
roomdata.py or RoomLogic.cs and run roomlogic.py: every room file is made again, and git shows what changed.


HOW THE ROOM FILES ARE MADE
---------------------------

roomlogic.py runs three steps:

  1. roomdata.py: the rooms as the logic sees them (work\rooms.txt). Each instance's creation code and Create event are
     run in the Randomizer's world (gmleval.py: a new game's globals, then the endgame world, gameProgress 5641), so
     what that world removes isn't there, and its size, place and exit are what its code makes them. Each object is a
     solid, a jump-through platform, a hazard (spikes, lava: never touched), water, a spring, a gate (solid till
     something opens it: a key, a sword or whip, bombs, missiles...), a moving platform and its path, an elevator, a
     Strike Chain point, a switch and what it changes (blocks, barriers; an ice block's or a platform maker's
     platform; bricks), a flying enemy the Mario Ability Set bounces off, an exit (or a menu's: Gate 4's stage
     select), a door within the room, or a place. work\rooms_notes.txt lists what its code left unknown.
  2. RoomLogic.cs (built to work\RoomLogic.exe with the .NET Framework's C# compiler): draws each room from its
     instances' sprite masks; finds where the player can stand, and joins those places into regions (walking); then
     runs the game's own 30fps movement (characterStepEvent, pMoveToWrapOrig, moveTo30: checked against the game) from
     the regions with a set of moves: jumps of different lengths, running and standing, double jumps, air dashes, dash
     jumps, wall jumps (where the game has them), drops with a double jump or air dash after, the Morph Ball (rolling,
     turning into it in the air where the body meets a wall or a ceiling, turning back out in the open, bomb jumps),
     bounces off flying enemies, springs, moving platforms, elevators and Strike Chain points. A move that lands
     somewhere joins two regions, with what it took; one that touches a place or an exit reaches it. Then, between
     places near each other that nothing joins yet, a search of jump timings (how long jump is held, when the double
     jump and air dash come, when to steer). A room with switches is worked out in each of its states, joined where a
     switch can be hit. Last, for each way in, the room's ways out and places: the room file, with the moves.
  3. solve.py: the rooms joined (roomlogic.txt), with overrides.txt; and a check that, without overrides, it gets the
     same as RoomLogic.exe's own joining (work\roomlogic_check.txt): a difference means a bug in one of them, and
     roomlogic.py ends with an error.

Nothing it counts needs pixel-perfect play: the moves' jumps, air dashes and springs are 95% of the game's (Sim.Slack),
a landing needs floor (or a wall) 4px to either side, a touch is with the player's sprite's box a few pixels in, and a
move the timing search finds counts only if it also works with its timings a tick earlier or later.

What it doesn't model (what's behind these needs everything, so it never holds an ability or key, unless an override
says otherwise): puzzles of several switches at once, push blocks, timed rings, wind, crushers, rails, the Gravity
Well's platforms; bouncing off enemies other than the Mario Ability Set's flying ones (the CHAOS soldiers can't be);
the bosses themselves (a boss needs any attack). A room's switches of one kind count as one switch (hitting any changes
all their blocks), and so do its ice blocks and platform makers (one hit: all their platforms).


CHECKING IT
-----------

Made with roomlogic.py's runs (work\ has what these read):

  python areas.py             each area's places and rooms, reached or not
  python frontier.py          where it stops: exits reached in rooms whose way in fails, and exits not reached
  python blockers.py          the objects in the rooms where it stops (the mechanics it doesn't model)
  drawat.ps1 <room> <x> <y> [w] [h] [out.png]
                              a picture of a room as the logic sees it, with each region's needs
  work\RoomLogic.exe --draw <project> work\rooms.txt <room> <out.png> work\roomlogic_regions.txt [x y w h] [--state N]
                              the same, for a room with switches in state N (a bit a group)
  work\RoomLogic.exe --trace <project> work\rooms.txt <room> <x> <y> <move> [dir] [--state N] [--slack S]
                              one move (RoomLogic.cs Programs) from a standing place, tick by tick; a hang... move from
                              a Strike Chain point at x,y, a kick... move from beside a wall (dir: its side); the move
                              search: every jump timing from there and where each lands. --slack 1: the game's own jump
                              strength (the logic's is 0.95)
  work\RoomLogic.exe --test   jumps on a flat floor (to check the movement against the game's)


FOR LATER: OPTIONS AND AN ENTRANCE RANDOMIZER
---------------------------------------------

Options (harder jumps allowed, a trick counted or not...): a way that only counts with an option on is written with
"option NAME" (an override, or a room file made with it); solve.py --option NAME counts it. The mod's generator would
then need the option too (rndgen.py leaves such ways out for now).

An entrance randomizer (each exit leading to a shuffled way in): the room files don't depend on where exits lead, so a
shuffled connections.txt (or link lines) is all solve.py needs to work the logic out for it. The game can send an
exit elsewhere already (the mod framework's exitPlayer hook changes toRoom, newMapX and newMapY). To watch for:
one-way drops (a way out with no way back), boss rooms (their file says boss), maps and menus (every way in reaches
every way out), doors within a room, elevators, and ways in that only work coming from one side.
