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
     made by a simulation of the game's own movement at 30, 60 and 120fps, each way needing what it needs at all three
     (a player plays at any of them; roomlogic.py, an hour or two).
  2. The rooms joined. connections.txt says which way in each exit leads to; solve.py follows them from the start and
     adds up what each room on the way needs (a few seconds). overrides.txt holds hand-made changes, applied here.

The result is roomlogic.txt. The mod's build (rndgen.py) runs solve.py itself, so overrides.txt always counts.


FILES
-----

  rooms\<room>.txt    each room's logic (made by roomlogic.py from the game's room: don't edit)
  connections.txt     which way in each exit leads to, where a new game starts, which exits are boss fights (made by
                      roomlogic.py from the game's exits: don't edit; change them in overrides.txt)
  overrides.txt       hand-made changes: kept when the rest is made again
  events.txt          what makes each event happen (a Nightmare Gate's boss beaten, an area visited...): EVENTS below
  roomlogic.txt       the result: what each place and each room needs from the start (made by solve.py)
  solve.py            joins the rooms; explains any place (its first lines list its commands; ASKING WHY below)
  roomlogic.py        makes the room files and connections.txt again, then solve.py's result, and checks it
  roomdata.py, gmleval.py, RoomLogic.cs
                      the simulation (HOW THE ROOM FILES ARE MADE, below)
  gamestate.txt       the rooms as the game itself makes them, where roomdata.py's reading of their code differs (made
                      by ..\..\logictest\roomdump.py digest from the running game: don't edit; roomdata.py takes it in)
  bosses.txt          what each boss fight takes (BOSSES below)
  er.py, erflat.py    Entrance Rando's doors and its seeds (ENTRANCE RANDO below)
  graph.txt           the whole game as one directed graph (made by graph.py, which roomlogic.py runs after solve.py:
                      don't edit): every room's ways in (with the states the room carries), ways out, places and spots,
                      the events and the boss fights; its edges each one way, with what they take and where they come
                      from (the room logic, a line of overrides.txt with what the room logic had, connections.txt).
                      Solved alone it gets roomlogic.txt (checked each run). Made beside the rest: the build still goes
                      by roomlogic.txt and erflat.py's tables
  ids.txt             the permanent numbers of the ways in, the ways out and Entrance Rando's doors (kept by graph.py:
                      don't edit). A new one is numbered after all the others; one gone stays, its number never given
                      again. Numbered at first as b124's lists were (what a save's visit marks and door shuffle go by),
                      so a number is its place in them; roomlogic.py says when a build's list leaves their order (old
                      saves then need rndgen.py's VISIT_LEGACY, er.py's LATE_DOORS or erflat.py's ER_LEGACY)
  directions.txt      each room's doors two by two, each way on its own (made by graph.py): where overrides.txt has a
                      way otherwise than the room logic (a playtest's correction: the simulation to look at, or what it
                      can't see), and the ways that go one way only
  tests.txt           overrides.txt's lines as tests of the simulation alone (made by tests.py, which roomlogic.py runs
                      after graph.py: don't edit), door by door, each with its comments as its reason: an add line is
                      sufficient (from that way in, with any one of its alternatives, the target is got to: the
                      simulation has to get there with as little), after a drop line for the same way sufficient and
                      necessary (and nothing less gets there), a drop line with no add line after it necessary: never,
                      a require line necessary (every way there takes it: the simulation's already do). Listed: the
                      lines the simulation passes (regression tests: it already has them), the ones where it gets
                      somewhere with less than the lines say (drop: more lenient than the game as the lines have it,
                      the first to look at), the ones it misses (fail: its gaps to look at; beyond: in a room with a
                      mechanism it leaves out, roomdata.py's UNMODELLED and ROOM_UNMODELLED, named beside the line: the
                      bikes, the wind, pressure switches, a mid-air partner swap...), and the rules it can't see
                      (require lines for an exit or for what it can't see, drop lines naming what the add lines leave out, link lines, only, outoflogic;
                      bosses.txt's fights, events.txt's events)
  checks.txt          the logic's automatic checks (made by checks.py, which roomlogic.py runs after tests.py: don't edit),
                      each listing only what it finds wrong, with its counts: 1. the story run (each boss fight in the
                      story's order with the abilities the story had given by then, the Boss Gallery's loadouts kept
                      gate to gate: the logic asking more is too strict there, with the rooms' parts on the way that
                      ask it); 2. door pairs where one way takes two or more abilities more than the other; 4.
                      overrides.txt's "from *" lines where the simulation gets to the target from some ways in and
                      never from others; 5. softlocks (the pause menu's Teleport works anywhere but in a boss fight:
                      each gate's Teleport place gets out of the gate with nothing); 6. frame rates (the places 30fps
                      alone has in logic that the logic, with each way needing what it needs at 30, 60 and 120fps, loses
                      or needs more for, and the frame rate that does it: the game plays differently there); 7. carried
                      states (a way in the logic gets to in a red/blue, water or crystal state its room's table has no
                      rows for); 11. regressions (a line the
                      simulation passed at the baseline and doesn't now, or a line gone: listed till python checks.py
                      --accept takes a new baseline, checks_baseline.txt)
  fitcheck.py         every place with every item's look (python fitcheck.py, a minute: fitcheck.txt): where the mod's
                      rndItemFit moves a pickup that takes its item's look, its collision box has to take in some of the
                      open pixels of the box the room logic got to; the places where a look's doesn't are listed
  stress.py           the seed stress test (python stress.py [seeds per option set] [rows to test] [seeds per row], a few
                      hours at 1000 seeds: stress.txt): seeds made as the mod makes them for each option set the build
                      checks, each played through; the room parts (rows) on the way to the progression items counted,
                      and the most used ones each taken away from a sample of seeds to see how often a seed needs them.
                      The ranking says which room parts to check in the game first
  trackerplay.py      the tracker playthroughs (python trackerplay.py <a build's folder> <folder> [seeds per option
                      set]): Entrance Rando seeds made as the mod makes them, and a copy of the build's trackers with
                      trackerplay.html, which plays each one with only what the Check Tracker shows (every check in
                      logic taken; with none, an unexplored door gone through): it must never be left with nothing to
                      do. The page's scripts run only from a web server (python -m http.server)
  perdoor.py          overrides.txt's lines for a whole room (from *) door by door: what the simulation says getting
                      from each way in to each other way in, and to the space around each place and exit such a line
                      is for, takes (RoomLogic.exe --probes, about 40 minutes; --report again from the last run), in
                      perdoor.txt beside the lines. A line for every way in gives each door the same need, as if the
                      player were already where it was written for; where a way in can't get there, or only with more,
                      the line belongs to the other ways in only (with Entrance Rando, any way in can be the one the
                      player first comes into the room by)
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
  varia             the Varia Suit: Gate 5's lava doesn't hurt (its purple lava always does)
  cursed N          N of the Trial Master's three cursed equipment pieces (the Cursed Helm, Ring and Pendant): his
                    trials need all three on
  key N             the key of the locked door whose objectNum is N (..\doors.csv lists them)
  chip N            Program Chip N (Access Gate N). The logic adds it itself to every way into gate N's rooms from a
                    room outside them (solve.py, and erflat.py and er.py with the doors shuffled; solve.py's
                    GATE_PREFIX: the rooms whose names start rMario1_ ... rGame6_), so the files needn't say it; a new
                    game without Chip Randomizer has all six
  attack            any ability set's attack: link 1, belmont 1, megaman 1 or samus 1 (four alternatives)
  event NAME        once that event has happened (events.txt says what it takes: EVENTS below)
  option NAME       only with that option on (none exist yet: FOR LATER)
  nothing, -        walking and jumping alone (a new game has the jump)
  never             no way

The files write "megaman:2"; "megaman 2" means the same.

Places (locations) are named "loc <type> <number>": the type is rndgen.py's (1 heart piece, 2 treasure chest, 3 arrow
quiver, 4 heart energy, 5 missile tank, 6 Game Power, 7 air upgrade, 8 Internetz mod, 9 weapon upgrade, 10 skill
point, 11 bomb upgrade, 12 morph bomb upgrade, 13 key, 14 heart container, 16 the X-Special charge, 17 the Spring
Ball; the Item Finder, 15, isn't one), the number its objectNum. The room files and solve.py also take their names:
"skill point 59".


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
menu: every way in reaches every way out), "walkmap" (Zelda II's overworld, walked across as an icon in 16px steps:
rivers and mountains are in the way, and walking onto a town's, cave's or palace's tile goes into it, so a way in
reaches only the exits its walk gets to; the encounters, "out encounter:<room>", the fight rooms an enemy touching the
icon starts, from anywhere on it). A way in whose comment says "can't be come in at" would put the player inside a
solid: nothing is reached from it (an override can still give it ways).

Carried states. Some of the game's state goes with the player from room to room: the red and blue switches' state
(rb 0: the blue blocks solid, 1: the red ones), the Water Palace's water level (water 1 the highest, 2, 3 the
lowest), and the Forest Palace's crystals (crystal1-3, 0 as at the start, 1 hit: Zelda II's Forest Palace, rooms
rLink2_PalaceF_3, _5 and _7 have one each; the sword or the whip flips it). A room that has them says "carried rb" (or
water, crystal1...); its ways in and out then come with the state:

  from in 48,480 [water 3]
    out 1392,272 [water 3]   djump,adash | djump,samus:2
      Coming in with the water at level 3, the exit is reached with it still at 3 (the room's switch would set it to 2).

"resets rb 0" says the room sets it as the player comes in (the Bubble Tower's main room does). solve.py carries the
states from room to room (connections.txt's "carried" lines give them as a new game starts); a room without them
passes them on as they are. A crystal turns the Forest Palace's middle rooms over: an exit that led to room 2a leads
to 2b (4a/4b, 6a/6b the same). Such an exit has a connections.txt line for each value ("rLink2_PalaceF_1 out 944,256
[crystal1 1] -> rLink2_PalaceF_2b in 48,128"), and the player goes where the state they leave in says. The crystals
only matter in the palace ("carried crystal1 0 within rLink2_PalaceF_"): outside it solve.py doesn't tell their values
apart, and remembers the ones the player left the palace with (and what leaving with them took); going back in, the
player has one of those. That keeps the solving fast, and it's exact because the palace's ways out and in are next to
each other on the overworld.


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

overrides.txt's lines (the file explains them too). A line adds a way or a requirement to the simulation's; only a drop
line takes one of its ways away, and it says why:

  add <room> from <x,y> to <way out or place> : <requirements>
      another way there (sufficient), as well as the simulation's. "from *": from every way in; "to *": to every way
      out, place and spot; "area <number>" in place of the room (from * to *): every room of the area
  require <room> from <x,y> to <way out or place> : <requirements>
      every way there needs this as well (necessary), the simulation's and the add lines' (the underwater rooms: "air
      3", 3 of the Air Upgrades, which the reach counts at the places it gets to while the mod places the items,
      rndGenerate)
  require <room> out <id> : <requirements>
      going through that exit needs this as well, wherever Entrance Rando has it lead (the portals' Program Chips)
  drop <room> from <x,y> to <way out or place> because <why>
      the ways there so far (the simulation's, and the lines' before it) aren't there: the add lines after it give
      the ones that are, or none (no way there)
  drop <room> from <x,y> to <way out or place> : <requirements> because <why>
      the add lines there leave these out on purpose, where every one of the simulation's ways takes them: a weapon
      ("attack"), a key ("key N"), a Program Chip ("chip N") or an event ("event NAME")
  link <room> out <id> -> <room> in <x,y>
      that exit leads somewhere else
  outoflogic <room> loc <place> : <why>
      that place out of logic from every way in, whatever the other lines say (it never holds an ability or key); the
      Check Tracker shows why beside it
  only <room> : <items>
      the room's code takes the player's other abilities and sets away (the CHAOS Warship's last rooms and Warship Z:
      "djump mario"), so a way through it that needs any other item isn't one; keys and events stay as they are

In a room with carried states, an add, require or drop line's way in can have one after it: "from 48,480 [water 3]"
is coming in with the water at level 3 only (Water Palace 7's right door: nothing under the ledge's level, the double
jump over it). Without one, a line is for every state the way in comes in in.

The add and drop lines apply in the file's order (a drop drops what the lines before it added too); then the only
lines, the require lines and the outoflogic lines.

The build stops (solve.load_overrides, so every tool that reads the file) at an add line that has a way leaving out a
requirement every one of the simulation's ways there takes, with no drop line saying why: a key, a Program Chip, an
event, or a weapon, so that fixing a jump doesn't take away a locked door's, a portal's, a switch's or a hatch's
requirement unseen. A weapon counts where one of the simulation's ways there takes just an ability set's first item
(its plain attack: a hatch, a barrier, enemies), so a set's later items for moving (the Morph Ball, the Strike Chain)
don't count as one; a weapon that only comes with a later item in every way (Norfair 12's hatch under the Bombs, its
only simulated way) isn't seen yet. A drop line for the whole way (its simulation dropped) lets its add lines be
anything.

There are no set, room, area, need or also lines any more (solve.py stops at one, saying which line takes its place):
a set line was a drop line and an add line (an add alone where it dropped nothing, a require line where it only put
something on top of every way), a room or area line the same from * to *, a need line "require <room> out <id>", an
also line "require <room> from * to *".

overrides.txt has these for what the simulation can't work out: the Nightmare Gates (an area's lines each), the Hidden
Program Facility, the bike rides, Gate 6's wind temple (a room's lines each) and latch crystals, rails and the travel
cannon (the simulation has the crystals' climbs and the cannons' flights now: tests.txt says which lines it agrees
with), and in the CHAOS Warship what its rooms' code changes by the way in (below), the bike, rWarshipM's key
controller and the rooms that take abilities away; its ways the simulation finds none for need what the whole Warship
took before (every movement ability and every attack) till they're checked in the game. (The Warship's Screw War
Turrets make a solid to stand on as they're made: roomdata.py has them, rWarshipG's gap is crossed on them.) Timed switch barriers
(roomdata.py's TIMED_SWITCH) need what the timed switches take between them: the Gravity Well, Link's bombs, Belmont's
whip and dagger, the Spazer Beam; one whose creation code turns its switches on once the story's past a point (the
CHAOS Warship's, Super Falls' rSF_H) is gone in the Randomizer's world.

What the simulation doesn't see: objects whose creation code reads where the player came in (global.newMapX and
newMapY), counted as there whichever way in it is. Most are the way back opened for whoever comes from the far side: a
barrier or block gone (rDCS_F's timed switches' barrier, rVault_9's, rMario1_2's blocks, rCCity_CCC's wrench blocks,
rGame6_FireA's, rWarshipE's, rWarshipG's, rWarshipK's colored switches and barriers, rWarshipH's bike barrier),
switches on already (rDCS_T, rWepFacI), and in the CHAOS Warship's two-floor rooms (rWarshipA, rWarshipB) the idle
partner put on the other floor; a way through those needs an overrides.txt line (rDCS_F and the Warship's have them,
worked out by running RoomLogic.exe on the room with the objects as that way in has them). Nor a key controller a
room's code makes (oEvKeyControl), which takes out the room's colored switches, barriers, keys and locks once the
story's past its progCheck: rWarshipM's has its overrides.txt lines.

Say why in a comment next to each change. Examples:

  # the jump from the ledge to the exit is too hard to count (double jump at the last moment)
  drop rMain_62 from 48,1920 to out 880,96 because the double jump at the last moment is too hard to count
  # the High Jump Boots get there too
  add rMain_62 from * to loc skill point 59 : hijump 2

..\logic.txt can replace what a single place needs (or every place in a room) after all this; it doesn't flow on to
other places, so use it only where overrides.txt can't say it.


BOSSES
------

bosses.txt says what each boss fight takes: going into a boss's room from another room is its fight (a "via" line: an
exit whose going through starts it). It was worked out from the bosses' damage resistances: a weapon counts if its
damage type hurts the boss at 1x or more and no phase of the fight takes that type to 0x; the file's top lists which
weapon deals which type, and each line says why. Some are by hand (the Mario bosses need the Mario Ability Set; Army Eye
needs all six types). Change a line there; solve.py reads it with overrides.txt. A boss room it doesn't name needs any
attack.

A line's "@ N%" is a share of the game the fight also waits for: N% of all the checks in logic (rndgen.py's locations,
rounded up; "pct N" is the same as a requirement anywhere). It's an event of its own, pctN (er.World makes them: a way
of the third kind, that many places got to), which the room logic's reach has once it's got to that many places: so a
seed never has the fight on its way to an item before then, with Boss Rando wherever the boss is fought. solve.py's
joining (roomlogic.txt), alternatives of items, can't count places: there it needs nothing, so the mod places every
game's items with the reach (rndNewGame), and so does the Archipelago world.

Boss Rando (the new game's option) moves the fights: each boss fought the Randomizer's way (rndgen.py's boss_list, the
Nightmare Gates' bosses among them; not the final boss) is fought at another one's place. A place is the boss's room, and for one whose fight the story went
into by an exit (rndgen.py's BOSS_VIA: Ridley, the Parasitic Seed) that via exit too; what going into it takes is then
what the fight of the boss fought there takes (that boss's own line here). erflat.py writes which room and exit is
whose place and what each boss's fight takes (data\rndER.txt), and the mod works the seed out with them as the
Entrance Rando's seeds are (ENTRANCE RANDO): roomlogic.txt's answers are for each boss at its own place.


EVENTS
------

Some ways open once the game remembers something: the Sacred Temple's doors once a Nightmare Gate's boss is beaten,
the Lost Entrance's barrier once any instrument is, Colossal Encroachment's trapdoor once the Great Colossal Falloff
has been visited. The gate or barrier then needs "event <name>", and events.txt says what makes it happen:

  gateA room rExtGateA_6               getting into Nightmare Gate A's boss room (its fight: bosses.txt)
  area76 area 76                       getting into any room of area 76

solve.py works out what each event needs from the rest of the logic, puts that in the event's place, and does it
again till nothing changes (so an event can open the way to another). A new event: a line here, and the gate's
requirement (roomdata.py, or an override).

A line starting "ir+" counts only with the new game's option Instrument Randomization, "ir-" only without it. The
Lost Entrance's barrier (event instrument) is one: without it, any gate's boss beaten (its reward is its instrument);
with it, any instrument found ("instr 1": the instruments are items then). solve.py, and roomlogic.txt, are as
without it; erflat.py writes both, and the mod's seed takes the ones for its option.

Spots are a room's own events: somewhere whose reaching opens a way in the same room. A room file lists them
("spot switch1"), says what reaching each needs from each way in, and the barriers they open need
event:<room>/<spot> (solve.py makes that what reaching the spot needs). They're the colored puzzles:
  - a colored switch holds its barriers open while someone's on it. In a party split room (two characters, the
    player swapping between them) the idle one can be left on it, in the air too (swapping freezes the one left,
    gravity and all), so its barriers count as open once the party reaches it (passing through counts);
  - a colored key opens its color's door (the lock panel beside it) once it's reached.
A party split room's idle partner starts where the room puts it (oPlayerIdle: elsewhere when the player comes in
past its xThres); the player can swap to it at once ("swap to the partner").

If the simulation itself is wrong (a move the game allows that it doesn't try, a mechanic it doesn't know), change
roomdata.py or RoomLogic.cs and run roomlogic.py: every room file is made again, and git shows what changed.


HOW THE ROOM FILES ARE MADE
---------------------------

roomlogic.py runs three steps:

  1. roomdata.py: the rooms as the logic sees them (work\rooms.txt). Each instance's creation code and Create event are
     run in the Randomizer's world (gmleval.py: a new game's globals, then the endgame world, gameProgress 5641), so
     what that world removes isn't there, and its size, place and exit are what its code makes them. Tower defense is
     won there (gameOptTowerDef 6, as the new game's option Skip Tower Defense has it), so its rewards in Central City -
     North are places; without the option the build has them need everything (rndgen.py's COND_GLOBALS). Each object is a
     solid, a jump-through platform, a hazard (spikes, lava: never touched; Gate 5's lava only till the Varia Suit, a
     gate that's never solid; Nightmare Gate C's spikes' shadows too, away from the nearest flame, but not those a
     moving flame steers, timed as moving traps are: roomdata.py's gate_c_shadows), water, a spring, a gate (solid till
     something opens it: a key, a sword or whip, bombs, missiles, an event...), a moving platform and its path, an
     elevator, a Strike Chain point (a Ripper's flies along its row), a switch and what it changes (blocks, barriers;
     an ice block's or a platform maker's platform; bricks; the Water Palace's water), a flying enemy the Mario
     Ability Set bounces off (where it starts; a Bill Blaster's Bullet Bills where they're fired), a push rock, a floating platform, a fading platform (a
     jump-through one: there half the time), an exit (or a menu's: Gate 4's stage select), a door within the room, or
     a place (an exit whose way goes by a Forest Palace crystal is read in both of the crystal's states).
     The enemy traps the Randomizer brings back (..\traps.py: the story's kill rooms, each happening once) add their
     barriers as gates: walls that open with what beats the trap's enemies (an attack of a damage type they all take,
     or the Mario Ability Set for Mario's), so a way through one, or to a place behind one, needs that. So do an enemy
     barrier the room's event opens once no enemy is left (Leaf Cave B: what beats every enemy placed there) and one
     whose code waits for a key (Gate 6's City of Dreams E: key 15). Things whose code changes them as the player comes
     near are read as the player meets them: the Hidden Program Facility's blocks that turn to nothing not there, Central
     City - North B's NPC pipe up, Neo Grime City's Chaos elevators as elevators (64px wide, stopping at their floors,
     put by their code at the floor the player comes in at), the CHAOS Weapons Facility's alert doors solid from the
     ways in their code names (from the left: a way-in group, alert_doors) till the item each guards is taken. Not Gate
     4's intro columns: they drop as the player runs under them, and down, with their spikes, they'd leave no way across
     the gate's first rooms.
     work\rooms_notes.txt lists what its code left unknown.
     Then gamestate.txt: what the game itself has in each room as the player comes in (every object's Create, Step and
     Alarm code and the Randomizer's own changes having run: ..\..\logictest\roomdump.py, which goes into every room by
     every way in and compares), where the reading above differs: a line the game hasn't is taken out, a still thing
     it has is put in (a falling pillar's real size, a spike zone something makes, a spring that has dropped to the
     floor), an exit leads where the game's does. One only some ways in have is there only for them: a group those
     ways in set (WS x y group 1, in rooms.txt), the line there only in its state ("@group=state" in front of it).
     A wall an enemy makes and takes away when it's beaten (Contra's wall and its turrets, a junkyard car, a Drill
     Waying's pillar at its full height) is put in as a gate that opens with what beats the enemy (traps.py's rule).
     Moving things, places, the barriers something opens and what changes as the player comes near aren't taken in
     from it (its end lists them). The moving
     platforms are, from where the game has them go (roomdump.py track: frame by frame for 20 seconds): the way of
     one roomdata.py reads from its code where the game's differs (a line's ends, a circle), one it leaves out (a
     crusher, a rail: along its legs corner to corner) put in, and a Strike Chain point that goes round (or along a
     line) a point every 24px along its way (as a moving platform, the player waits for it where it goes).
  2. RoomLogic.cs (built to work\RoomLogic.exe with the .NET Framework's C# compiler): draws each room from its
     instances' sprite masks (an automatic bounding box worked out from the pixels, as the game does, not the stored
     numbers); finds where the player can stand, and joins those places into regions (walking); then runs the game's
     own movement from the regions: characterStepEvent with pMoveToWrapOrig and moveTo30 at 30fps (Sim.Step), and its
     60fps code with pMoveToWrapNew and pMoveTo's rounding above it (Sim.StepHi). Each matches the game pixel for pixel,
     frame by frame (..\..\logictest\calib.py plays the logic's moves in the game and compares). The room files are made
     at 30fps; --fps 60/120 make a frame rate's own (CHECKING IT). The moves: jumps of different lengths, running and
     standing, double jumps, air dashes, dash
     jumps, wall jumps (where the game has them), drops with a double jump or air dash after, the Morph Ball (rolling,
     turning into it in the air where the body meets a wall or a ceiling, turning back out in the open, bomb jumps;
     turning back where the body would be in a gate, a bomb block over a tunnel, takes the gate open),
     bounces off flying enemies (each where it starts, come down on from above and stomped with the Mario Ability Set,
     not in a dash's invulnerability: from there, as from a latch crystal, a node of its own, the moves on, with the
     jump or up held or not, and the double jump and air dash it gave back, to the next one, a ledge, a place; and off
     the Mario enemies on the ground, Goombas and the Bros: landed on over the floor they stand on, near where they're
     placed, jumped onto, waited for or dropped onto), springs (steered at once, or 6
     or 12 ticks after the bounce: up past a ledge's
     overhang first), moving platforms, elevators and Strike Chain points. A move that lands
     somewhere joins two regions, with what it took; one that touches a place or an exit reaches it. Then, between
     regions near each other that nothing joins with nothing yet, and from each region to the places and the flying
     enemies near it, a search of jump timings (how long jump is held, when the double jump and air dash come, when to
     steer; off a dash too), and from each flying enemy stomped to the next ones and the ledges near it (when to steer
     and for how long, the double jump and air dash), only for moves that need less than what gets there already (a
     way there with the Strike Chain doesn't stop the search for one with the double jump), each counted only where
     its timings a tick earlier or later work too. A room with switches is worked out in each of its states, joined where a
     switch can be hit: an attack in reach (at the top of a jump too; a Forest Palace crystal takes only the sword or
     the whip), a shot along a clear line (and, while it flies,
     the player can jump somewhere else: onto a block the switch is about to move, say), a block that moves carrying
     the player standing on it; red and blue switches near an enemy's shots or a moving trap change by themselves (the
     player waits). Push rocks: the player gets beside one, pushes it where it's needed (left or right, off edges) and
     moves off it from there. Elevators (Zelda II's): ridden up and down their shafts, got off where a floor is level;
     Neo Grime City's wider ones, got on and off at their floors only (jumped up onto, or dropped off, where one rests
     above the floor beside it). A fading platform is waited on till it fades, and fallen through (as the Morph Ball
     too: some have only room for it under a low ceiling). Falling pillars (Castlevania's): one stood on shakes and
     falls 25 ticks later, its column with it, and on its top the player goes down with it till a floor under the feet
     stops them. Which have fallen is the room's state as the player goes: each move says which pillars it starts, stands
     and lands on, touches and goes through, so from which states it goes and what has fallen after it; a region a
     fallen top splits is a node for each part; a pillar just landed on shakes (from there, only the moves off its top,
     or riding it down); a region's moves near fallen ones are made again with them gone; and a pillar is ridden down
     (from its top's ends and middle, the feet wholly on it), the moves off it tried every 32px on the way. Latch crystals: jumps with a melee attack pressed again each
     time it can be, the sword (Jerry), the whip (Claire) or, in Gate 6, the Blade Strike (Claire, 6 swings a move for
     its weapon energy); a swing's frame on a crystal while the player's in the air bounces them up and gives the air
     dash and the double jump back, as takeDamage does (..\..\logictest\calib.py's pogo moves match the game's paths
     pixel for pixel at 30fps). Bounces off enemies aren't counted. A crystal bounced off is a node of its own (hit from
     its left or right, by Jerry or Claire), as a Strike Chain point is: the moves go on from beside it, in the air with
     the bounce's push up and slow fall and the double jump and air dash back (a double jump or air dash after, falling,
     or the attack mashed for the next crystal), so a climb of crystals is a chain of them. Where a hit leaves the player
     isn't one place, so a move off a crystal counts only for what it does from both of two: 24px off it, the crystal at
     the body's middle, and 8px lower (the crystal higher up the body).
     A travel cannon (oTravelCannon): pressing up at it gets in, firing it puts the player ahead of it and up and flies
     them 16px right and 16px up a tick, with no keys, friction or gravity, for its creation code's launchDuration
     ticks; then they're let go, with that speed, the double jump and the air dash (held nothing, on, or back, with a
     double jump or air dash soon or later).
     Spots the room's own doors wait for: a diamond door (oDiamondDoor) is gone once the room's red diamonds are all
     taken, so each diamond is a spot and the door a gate needing every one's event; a step door (oStepDoorA) is up
     while one of its step switches is stood on, and down again about two seconds after the player steps off, so each
     switch is a spot (stood on) and the door a gate needing either's (its switches are beside it). Off a spring, the
     double jump and then the Morph Ball a few ticks after it: up past a wall's top into a gap over it too low to stand
     in (morphing where the body meets the wall would come first, and the ball has no double jump).
     Begonia's fans blow the player along their stream (224px long), as oBegoniaFan does, unless something solid is in
     the way; a fan switch turns its fans on and off (a state of the room's), and a fan with no switch that starts off
     stays off. Water slows a fall, so a move still falling in water when its time runs out gets more time.
     The Maridia tube (Gate 5's Maridia 4): its walls are its top and bottom for going through it and its sides for
     passing behind it, the one or the other as its code makes them where the player gets to: a state of the room's,
     set by standing at the tube's ends or over it (roomdata.py's TUBES). Nightmare Gate D's platforms, there only
     while a sweeping zone shows them, are stood on while they're there and gone through while they aren't.
     Zelda II's overworld isn't platformed: the icon's walk from each way in (16px steps, each blocked by a solid at its
     point, stopping on an exit's tile) finds the exits it reaches.
     Last, for each way in, the room's ways out and places: the room file, with the moves.
     It runs three times at once, at 30, 60 and 120fps (--fps 30/60/120, into work\fps30, work\fps60, work\fps120:
     each its rooms\, connections.txt and log; a folder whose stamp.txt says it was made from the same rooms.txt by the
     same RoomLogic.exe isn't made again), and combine_fps.py makes the three into rooms\: each way needs what it needs
     at every frame rate, as a player plays at whichever they pick (the "how" lines are the 30fps moves).
  3. solve.py: the rooms joined (roomlogic.txt), with overrides.txt; and a check that, without overrides, the 30fps
     room files get the same as RoomLogic.exe's own joining (work\fps30\roomlogic_check.txt): a difference means a bug
     in one of them, and
     roomlogic.py ends with an error.
  4. graph.py: the same, as one directed graph (graph.txt), its ways in, ways out and doors numbered for good
     (ids.txt), and each room's doors both ways (directions.txt); solved alone, graph.txt has to get roomlogic.txt
     (work\graph_check.txt), or roomlogic.py ends with an error. "python graph.py" makes them again from the files as
     they are (after a change to overrides.txt, say); "python graph.py --check" only checks.

Nothing it counts needs pixel-perfect play: the moves' jumps, air dashes and springs are 95% of the game's (Sim.Slack),
a landing needs floor (or a wall) 4px to either side, a touch is with the player's sprite's box a few pixels in, and a
move the timing search finds counts only if it also works with its timings a tick earlier or later.

What it doesn't model (what's behind these needs everything, so it never holds an ability or key, unless an override
says otherwise): steering left and right during a long fall (a move holds one way after its start), wind, moving
crushers
(Sigma's crushing walls count as walls where they start), rails, the Gravity Well's platforms, the bike (overrides
say what Overdrive Ostrich's rides need); bouncing off enemies other than the Mario Ability Set's flying ones (the
CHAOS soldiers can't be), the sword's bounce off an enemy, being knocked back by a hit; ladders, conveyors, and
Nightmare Gate F's own ice running and jump (the moves there are the normal ones); the bosses themselves (a boss needs
any attack). A spring is touched with the logic's small touch box, so it throws the player a tick later than the game's
(whose collision is the sprite's), and a little lower. A room's switches of one kind count as one
switch (hitting any changes all their blocks), and so do its ice blocks and platform makers (one hit: all their
platforms). Timed rings count as needing the dash (the Farreaches' ring barriers). A party split puzzle counts its
colored switches as all held once reached, though only one character is ever left on one (two at once can't be);
and a colored key opens its door once both are reached, whichever comes first.


CHECKING IT
-----------

Made with roomlogic.py's runs (work\ has what these read):

  python areas.py             each area's places and rooms, reached or not
  python frontier.py          where it stops: exits reached in rooms whose way in fails, and exits not reached
  python blockers.py          the objects in the rooms where it stops (the mechanics it doesn't model)
  drawat.ps1 <room> <x> <y> [w] [h] [out.png]
                              a picture of a room as the logic sees it, with each region's needs
  work\RoomLogic.exe --draw <project> work\rooms.txt <room> <out.png> work\fps30\roomlogic_regions.txt [x y w h] [--state N]
                              the same, for a room with switches in state N (a bit a group)
  work\RoomLogic.exe --edges <project> work\rooms.txt <room> [--fps 60|120]
                              a room's regions, their joins (from > to: needs, and the move) and what each touches, at
                              that frame rate (for finding the join one frame rate's logic doesn't have)
  work\RoomLogic.exe --trace <project> work\rooms.txt <room> <x> <y> <move> [dir] [--state N] [--slack S]
                              one move (RoomLogic.cs Programs) from a standing place, tick by tick; a hang... move from
                              a Strike Chain point at x,y, a kick... move from beside a wall (dir: its side); the move
                              search: every jump timing from there and where each lands. --slack 1: the game's own jump
                              strength (the logic's is 0.95)
  work\RoomLogic.exe --test   jumps on a flat floor (to check the movement against the game's)
  work\RoomLogic.exe --move <project> work\rooms.txt <room> <x> <y> [name=value ...] [--slack S]
                              one move given field by field (ch dir run jumpAt jumpHold h1 h2 hDelay djAt adAt gdAt
                              hiJump wallMode morphAt afterBounce ... fps=30|60|120 dither=N; morph=1 as the Morph
                              Ball, open=1 with the gates open), tick by tick and frame by frame in lines a program
                              reads (..\..\logictest\calib.py)
  work\RoomLogic.exe <project> <rooms.txt> <out folder> --fps 60|120
                              the moves at that frame rate alone (each frame rate's own logic; 30fps is the default)
  work\RoomLogic.exe <project> <rooms.txt> <out folder> --allfps
                              every move at 30, 60 and 120fps with the same timings, counting what it does at all
                              three (stricter than a player needs)
  python combine_fps.py <rooms 30fps> <rooms 60fps> <rooms 120fps> <out rooms>
                              the three frame rates' room files made into one: each way needs what it needs at each
                              (a seed finishable at any frame rate; a move may take other timings at each)
  work\RoomLogic.exe ... --fpsrejects / --slack S
                              what the 60/120fps check takes away (work\..\fps_rejects.txt); the moves' strength
  python compare.py <rooms A> <rooms B> [<connections A> <connections B>]
                              two runs side by side: the rooms whose ways through differ, and what the joined logic
                              (with overrides.txt) gets from each


ENTRANCE RANDO
--------------

The new game's option Entrance Rando shuffles where the game's doors lead. The room files don't depend on where exits
lead, so the same logic works it out with the doors shuffled.

Doors (er.py). Two exits that lead to each other (room A's exit to room B, and B's exit back to next to A's) are a door
with two ends. An end is an exit and the way into its own room the other end's exit leads to (where the player comes
back in). A shuffle pairs a mode's ends anew: an exit leads to its new partner's way back in, and going back through
the partner returns the player where they came from. Left out of every mode: one-way exits, doors within a room, menus
and encounters, the exits that are boss fights (connections.txt's via), exits whose way goes by a carried state and the
Forest Palace's rooms (its crystals), the encounter rooms, rooms the logic doesn't reach even with everything, ends
whose way in reaches nothing or doesn't get back out through the end's own exit (a drop with no way back up), exits
at the same place as another (the game finds an exit by its room and place), and the areas in er.py's LEFT_OUT,
hallways with no places (the Subconscious Filter, the Discombobulated: its way in leads straight to its boss's room in a
Randomizer game, overrides.txt's link lines; their doors stay ends, unshuffled). An end with a Metroid door in front of
its exit (the Research Facility's hatches: any weapon opens most, missiles the rest) pairs with any other end: going
back out through it takes what opens the hatch, as the room logic has it (the shuffle used to pair such ends only with
ends like them, which kept Gate 5's doors to each other: no end outside it has one). A player who comes in behind one
without what opens it, and has no other way out, has the pause menu's Teleport.
The maps (Hyrule's, Gate 6's): a tile and its place are a door, its end the place's exit next to where the tile has the
player come in. A tile that has the player come in away from the exits (Forest 1's) is a door too if every exit of the
room back to the map comes out at one place; those doors come after the others, which keep their order (a save's
shuffle is by the ends' order: erflat.py's ER_LEGACY, the earlier builds' doors whose saves still load). A room's other
exits back to a map that come out where an end's exit does (er.follows: a town's far side, a palace's way out after
its boss, a place of several rooms' last one) lead where the game has them: one way, signed ONE WAY with Entrance Rando
(er.one_way: every exit that, gone through, has no exit by where the player comes out leading back to it; rndgen.py
writes the ones that show an arrow and the pipes, where their creation code moves them to, and the roomStart hook puts
the signs over them, a pipe's in the middle above it). The builds before had them follow
that end, leading where it now leads, in the logic (exit_end) and the game (rndERMapBuild); a shuffle made with them
keeps that (erflat.py's ER_FEATURES 1, ER_LEGACY), and the data has them apart for it (exit_follow). A crossing's far exit (a bridge's or a pass's, out across a river or a
mountain) comes out elsewhere on the map, so it stays the game's: nothing leads into the room there to pair it with.
Gate 4's stages: a Randomizer game adds a way back to each of their rooms but the boss rooms (rndgen.py's
MM_BACK_EXITS, which roomdata.py adds to the rooms as exits), so each room's exit and the next one's way back are a
door; those doors come after the others too.
  Gate Swap   the Access Gates' and Nightmare Gates' doors (oAccessGate, oDistortionGate)
  Area        the doors inside each region (regions.txt: each a name and the game's areas in it; an area on no line is
              a region of its own), each region's paired only among its own (erflat.py's akey); the doors between
              regions are the game's. The regions aren't in the doors' hash (below), so a change to them keeps the
              saves' and Archipelago worlds' shuffles loading
  Chaos       every door

A seed (the mod's rndNewGame, with the same steps in Python in erflat.py):
  1. The shuffle (rndERShuffle). From the start, with everything: a free end whose exit is reached is joined to an end
     whose way back in isn't reached yet and leads somewhere new, so everything joined is reached from the start
     (with only one end left to join to, one that leads on to other free ends first, so the joining doesn't stop at a
     dead end); the ends left over are paired at random.
  2. With everything (every ability and key), the shuffle has to reach every place the game's own doors reach, the
     seven Nightmare Gates' bosses, the Abomination and the Warmaster (rndEREverything).
  3. The items are placed in layers as without it (rndGenerate), what each layer reaches worked out from the rooms
     with the shuffled doors (rndERReach*: roomlogic.txt's answers are for the game's own doors).
  4. The seed is played through from nothing, taking every ability and key reached, over and over: all of them have
     to be got (rndERPlay).
  A shuffle that fails a step is dropped and another tried (60 at most; then the doors stay as they are).

erflat.py writes the tables the mod works it out from: the rooms' ways through (from the room files, overrides.txt,
bosses.txt and events.txt, as solve.py joins them), the exits, the events, the doors' ends and the bosses' places, as
numbers, in the build's data\rndER.txt (rndERLoad reads it; its hash goes in a save, so a build with other doors can
tell, and so do an Archipelago world's: a shuffle made with an earlier build's doors in ER_LEGACY is put back as it was
made, rndERAccept). Its own check (python erflat.py) makes seeds of each mode its way, and with Boss Rando, and plays each through;
rndgen.py makes ten of each at build time (and of Chaos with Boss Rando). python er.py lists each mode's doors and makes seeds with er.py's own engine (the two must agree). Change the
doors in er.py (the modes, what's left out), then build the mod again.


FOR LATER: OPTIONS
------------------

Options (harder jumps allowed, a trick counted or not...): a way that only counts with an option on is written with
"option NAME" (an override, or a room file made with it); solve.py --option NAME counts it. The mod's generator would
then need the option too (rndgen.py leaves such ways out for now).
