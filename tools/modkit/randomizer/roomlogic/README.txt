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
  events.txt          what makes each event happen (a Nightmare Gate's boss beaten, an area visited...): EVENTS below
  roomlogic.txt       the result: what each place and each room needs from the start (made by solve.py)
  solve.py            joins the rooms; explains any place (its first lines list its commands; ASKING WHY below)
  roomlogic.py        makes the room files and connections.txt again, then solve.py's result, and checks it
  roomdata.py, gmleval.py, RoomLogic.cs
                      the simulation (HOW THE ROOM FILES ARE MADE, below)
  bosses.txt          what each boss fight takes (BOSSES below)
  er.py, erflat.py    Entrance Rando's doors and its seeds (ENTRANCE RANDO below)
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

overrides.txt's lines (the file explains them too):

  set <room> in <x,y> -> <way out or place> : <requirements>
      what that way through the room needs, in place of what the room's file says ("in *": from every way in)
  add <room> in <x,y> -> <way out or place> : <requirements>
      another way through, as well as the room file's
  need <room> out <id> : <requirements>
      going through that exit needs this too
  link <room> out <id> -> <room> in <x,y>
      that exit leads somewhere else
  room <room> : <requirements>
      every way through the room (from each way in to each way out, place and spot) needs this, in place of the
      room file's
  area <number> : <requirements>
      the same for every room of the area (a later room line can still change one of them)

overrides.txt has these for what the simulation can't work out: the Nightmare Gates (an area line each), the CHAOS
Warship, the Hidden Program Facility, the bike rides, Gate 6's wind temple (a room line each) and latch crystals, rails
and the travel cannon. Timed switch barriers (roomdata.py's TIMED_SWITCH) need what the timed
switches take between them: the Gravity Well, Link's bombs, Belmont's whip and dagger, the Spazer Beam.

Say why in a comment next to each change. Examples:

  # the jump from the ledge to the exit is too hard to count (double jump at the last moment)
  set rMain_62 in 48,1920 -> out 880,96 : never
  # the High Jump Boots get there too
  add rMain_62 in * -> loc skill point 59 : hijump 2

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
     what that world removes isn't there, and its size, place and exit are what its code makes them. Each object is a
     solid, a jump-through platform, a hazard (spikes, lava: never touched; Gate 5's lava only till the Varia Suit, a
     gate that's never solid), water, a spring, a gate (solid till
     something opens it: a key, a sword or whip, bombs, missiles, an event...), a moving platform and its path, an
     elevator, a Strike Chain point (a Ripper's flies along its row), a switch and what it changes (blocks, barriers;
     an ice block's or a platform maker's platform; bricks; the Water Palace's water), a flying enemy the Mario
     Ability Set bounces off (a Bill Blaster's Bullet Bills), a push rock, a floating platform, a fading platform (a
     jump-through one: there half the time), an exit (or a menu's: Gate 4's stage select), a door within the room, or
     a place (an exit whose way goes by a Forest Palace crystal is read in both of the crystal's states).
     The enemy traps the Randomizer brings back (..\traps.py: the story's kill rooms, each happening once) add their
     barriers as gates: walls that open with what beats the trap's enemies (an attack of a damage type they all take,
     or the Mario Ability Set for Mario's), so a way through one, or to a place behind one, needs that.
     work\rooms_notes.txt lists what its code left unknown.
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
     switch can be hit: an attack in reach (at the top of a jump too; a Forest Palace crystal takes only the sword or
     the whip), a shot along a clear line (and, while it flies,
     the player can jump somewhere else: onto a block the switch is about to move, say), a block that moves carrying
     the player standing on it; red and blue switches near an enemy's shots or a moving trap change by themselves (the
     player waits). Push rocks: the player gets beside one, pushes it where it's needed (left or right, off edges) and
     moves off it from there. Elevators (Zelda II's): ridden up and down their shafts, got off where a floor is level.
     Begonia's fans blow the player along their stream (224px long), as oBegoniaFan does, unless something solid is in
     the way; a fan switch turns its fans on and off (a state of the room's), and a fan with no switch that starts off
     stays off. Water slows a fall, so a move still falling in water when its time runs out gets more time.
     Zelda II's overworld isn't platformed: the icon's walk from each way in (16px steps, each blocked by a solid at its
     point, stopping on an exit's tile) finds the exits it reaches.
     Last, for each way in, the room's ways out and places: the room file, with the moves.
  3. solve.py: the rooms joined (roomlogic.txt), with overrides.txt; and a check that, without overrides, it gets the
     same as RoomLogic.exe's own joining (work\roomlogic_check.txt): a difference means a bug in one of them, and
     roomlogic.py ends with an error.

Nothing it counts needs pixel-perfect play: the moves' jumps, air dashes and springs are 95% of the game's (Sim.Slack),
a landing needs floor (or a wall) 4px to either side, a touch is with the player's sprite's box a few pixels in, and a
move the timing search finds counts only if it also works with its timings a tick earlier or later.

What it doesn't model (what's behind these needs everything, so it never holds an ability or key, unless an override
says otherwise): steering left and right during a long fall (a move holds one way after its start), wind, moving
crushers
(Sigma's crushing walls count as walls where they start), rails, the Gravity Well's platforms, the bike (overrides
say what Overdrive Ostrich's rides need); bouncing off enemies other than the Mario Ability Set's flying ones (the
CHAOS soldiers can't be); the bosses themselves (a boss needs any attack). A room's switches of one kind count as one
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
  work\RoomLogic.exe --draw <project> work\rooms.txt <room> <out.png> work\roomlogic_regions.txt [x y w h] [--state N]
                              the same, for a room with switches in state N (a bit a group)
  work\RoomLogic.exe --trace <project> work\rooms.txt <room> <x> <y> <move> [dir] [--state N] [--slack S]
                              one move (RoomLogic.cs Programs) from a standing place, tick by tick; a hang... move from
                              a Strike Chain point at x,y, a kick... move from beside a wall (dir: its side); the move
                              search: every jump timing from there and where each lands. --slack 1: the game's own jump
                              strength (the logic's is 0.95)
  work\RoomLogic.exe --test   jumps on a flat floor (to check the movement against the game's)


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
exits back to a map that come out where an end's exit does follow that end (er.follows: a town's far side, a palace's
way out after its boss, a place of several rooms' last one): with it shuffled they lead where it now leads, in the
logic (exit_end) and the game (rndERMapBuild). A crossing's far exit (a bridge's or a pass's, out across a river or a
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
