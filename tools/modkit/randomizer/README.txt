DT3+ Randomizer (a mod)
=======================

A new game with the mod on starts in the game's endgame world: every area open, the story done, no CHAOS invasion. The
player is in Central City - North, at the door from Greatest Stretch, able to walk and jump. Every collectible the
progress page counts (heart pieces and containers, chests, quivers, heart energy, missile tanks, Game Power, air
upgrades, Internetz mods, weapon upgrades, skill points, bomb upgrades, keys, the X-Special charge, the Spring Ball),
the other movement abilities (dash, air dash, double jump, the High Jump Boots), the Varia Suit (Gate 5's lava doesn't
hurt once it's found; before, it does) and every ability set (the Mario Ability Set, shown as a ? block, and the attacks
of Link, Belmont, Mega Man, Samus and the two Gate 6 sets) are shuffled into each other's places when the game starts,
in layers (see Logic). The Item Finder isn't shuffled: it's where the game has it, and with it Chao shows a ! instead of
the treasure icon in a map with an ability, an ability set's item or a key. The equipment shops' stock is shuffled
between the shops. A spoiler log is written to the Saves folder's Seeds folder (Saves\Seeds\Randomizer spoiler log
<seed>.txt), with the options and the abilities and keys by layer. As in a new game: tower defense and the Trial Master's cursed trials aren't
done (their rewards come from doing them, with the three cursed equipment pieces on; the 7th trial, five of the six
others done, also gives Central City South's heart container), the shortcuts are shut, and there are no program chips,
Yoshi dolls or game-completed flag (Bubble Tower B and the Gate 6 DLC stay shut). Nightmare Gate H is left out: its
access gate (there once the other seven gates' bosses are beaten) goes to a blank room (the mod's rRndGateH) that
counts the gate as beaten, has its reward and goes on to the Sacred Temple.

Win: the 8 instruments and the Abomination, then the CHAOS Warmaster at the end of the CHAOS Warship (walking up to
him there starts his fight once the Abomination is beaten; before, he isn't there yet and a message says so). The
credits roll. Each Nightmare Gate's boss, beaten, leaves the gate's reward where it was fought: its instrument (the
Sacred Temple doesn't give them), or with Instrument Randomization any item, the instruments being in the pool. Having
all eight opens the Abomination's fight (gateHProg 100, which the temple's last instrument scene gives in the game).

Playing
  Put the built mod in Mods\Randomizer and turn it on. Every new game is then a randomizer game (a save made with it
  stays one). A new game opens with its options (oRndOptions, in place of the intro); they're kept for the next one
  (DT3Options.dts, section Randomizer):
    Seed                     random, or typed in (Confirm). Typing seed and a number on the title screen (seed1234)
                             sets it too. The same seed with the same options places the items the same way.
    Guarantee Early Weapons  every layer has a weapon (an item of the Link, Belmont, Mega Man or Samus set: 17 items,
                             each set's next level) while there are any left: a new layer's first item is one. Off (the
                             default): the weapons go anywhere, as the other abilities do.
    Ability Spread           Near, Normal, Far: the chance that an ability or key goes in the newest layer (3 in 10,
                             7 in 10, always; see Logic).
    Shop Equipment           Shuffled (between the equipment shops) or As Normal.
    Entrance Rando           Off, Gate Swap, Overworld or Chaos: where the doors lead is shuffled (below).
    Boss Rando               Off or On: which boss is fought in each boss's room is shuffled (below).
    Instrument Randomization Off or On: the 8 instruments are in the pool, and the Nightmare Gates' rewards hold any
                             item (no ability or key: a fight's reward, as the bosses' heart containers).
    Spoiler Log              written or not.
  An Archipelago game has no options window (its options are the multiworld's), and no Entrance Rando, Boss Rando or
  Instrument Randomization (each gate's reward is its own instrument, not one of the multiworld's locations).
  - Entrance Rando: the mode's doors are paired anew, coupled (going back through a door returns the player where they
    came from). Gate Swap: the Access Gates' and Nightmare Gates' doors. Overworld: those, every door between two areas
    and every way between a map (Hyrule's, Gate 6's) and a room. Chaos: every door. The seed is made so that with
    everything, every place the game's own doors reach is reached, and the game can be finished: the items are placed
    with what the shuffled doors reach, and the seed is played through before the game starts (a shuffle that fails is
    dropped for another; roomlogic\README.txt, ENTRANCE RANDO). Making it takes a few seconds. The spoiler log lists
    the doors. A save keeps its shuffle (and needs the same build's door data, data\rndER.txt, to put it back).
  - Boss Rando: each boss's place (its room; Ridley's and the Parasitic Seed's: the exit the story went into their
    fights by) gets another boss's fight. Walking up to the boss there (as below) starts that boss's fight in its own
    room, the boss gallery's way; won, the player comes back to where the fight started and the place counts as beaten
    (its heart container is there, a Nightmare Gate's reward too, and it isn't fought again). The 54 bosses fought the
    Randomizer's way are shuffled, the Nightmare Gates' seven among them (Kamek, Final Nightmare, Blackmore, Elpizo,
    Shadow Form, Nightmare, Sephiroth); the CHAOS Warmaster stays the last fight, at the end of the CHAOS Warship, and
    The Executive stays in his own room (his fight needs nothing: below). Not in it, as the Randomizer leaves them to
    the game: the second fights of a room (Death (Legion), Sigma Epsilon, Ridley (Lava), Decimator 20000), the Ridley
    tunnel chase, the Leviathan road, the Abomination's fight (the gallery's Wahfuu, the instrument quest's end), the
    CHAOS Warmaster EX and Hexor (the Distortion's last fight: past the story he's in his room, not fighting). The
    items are placed with what each place's fight now takes (roomlogic\bosses.txt has what each fight takes), and the
    seed is played through before the game starts. The spoiler log lists the fights. A save keeps its shuffle.
  - The ability sets' items are progressive: each one is that set's next weapon (Link: Master Sword, Bow & Arrow, Fuse
    Bomb). Swapping characters and sets is always on. The Gate 6 sets only work in Gate 6, as in the game, and in The
    Executive's fight, which gives both characters both of them whole, as the game's own fight does (his phases are
    made for them), so it needs nothing of the player's: the logic doesn't count him.
  - Each key opens its own locked door (the message says which area it's in); a door without its key says so.
  - The pause menu's Teleport works anywhere but in a boss fight, and goes to where the game started: Central City -
    North, at the door from Greatest Stretch (the game's own places for it aren't used). It's the way out of anywhere
    the player can't get out of on foot.
  - John stands in Central City - North, left of the archway (oRndJohn), for a seed that has the player stuck. Talking
    to him offers the game's debug mode, with a prompt (Turn Debug Mode On / Cancel, in the look of his Turret Defense
    Game menu; the game waits while it's open). Turned on, he says how to use it: its right-click menu (Activate Mouse
    Movement: holding the left mouse button, the player goes where Chao is, so anywhere) and its keys (R invincibility).
    Talking to him again turns it off without asking ("Off it goes."), and what it had turned on (mouse movement,
    invincibility, always max HP) with it. The game doesn't save it.
  - Enemy traps (traps.py): the story's kill rooms, which shut the player in with barriers till they've beaten waves
    of enemies, happen again, each once: walking into one's arena closes its barriers and starts the game's own fight
    (its enemies, waves and counter); beaten, it's gone for good (the save keeps it). The logic counts each one: its
    barriers are walls that open with what beats its enemies (an attack of a damage type they all take, or the Mario
    Ability Set for Mario's enemies, which it stomps), so a seed never needs the player to go through one they can't
    win. 57 of them, in the Vault, Gate 5, Neo Grime City, Gate 6, the Hidden Program Facility, Starry Skies, the CHAOS
    Weapons Facility and Warship, the Mushroom Kingdom, Greatest Stretch, Hyrule's palaces, Transylvania, the Mountain
    Temple and Sigma's Fortress. Left out: the story's scenes more than fights, and the Nightmare Gates' (the game runs
    them every time, as it does in the Randomizer's world; traps.py lists the rest and why). A save from a build
    before the traps doesn't get them (its seed's items were placed without them).
  - Bosses are fought in their own rooms: walking up to where a boss's fight starts (or leaving its room another way
    than the player came in) starts it, as the room's own fight (the room's code makes the boss), with the player's own
    abilities and the life and ammo they came in with. A boss has to be beaten to go on: given up from the game over
    screen, the player is back where they came into the room, and walking up to it again starts it again. (These fights
    have the boss gallery's flag on underneath, so a beaten boss ends its fight the gallery's way, without the story's
    scenes; the mod's oHUD doesn't show the gallery's timer in them.) Ridley and the
    Parasitic Seed, whose rooms the endgame world's exits go past, are fought going through the exit the story used
    to go into them (rndgen.py, BOSS_VIA). A boss's heart container is there once it's beaten. The Nightmare Gates'
    bosses are fought the same way (their rooms' own scenes don't start), and each leaves its gate's reward.

Trackers
  The mod's tracker folder (Mods\Randomizer\tracker) has two pages to open in a web browser next to the game, or in a
  stream's browser source. The game writes what the player has and has taken to tracker\state.js whenever it changes
  (rndTrackWrite), and the pages read it again every second: they follow the randomizer game being played. Open
  Trackers.bat (in the mod folder) opens each in a window of its own, sized to it (Microsoft Edge's app windows;
  without Edge, the default browser); Open Trackers (Always on Top).bat opens them on top of every other window, the
  game's too. Both run tracker\open.ps1, which has the windows' sizes.
  - checks.html, the Check Tracker: every place by area (the tabs) and screen; red while the player's items don't reach
    it, green once they do, blue with a tick once it's taken. Its logic is the seed's own: the room logic the items
    were placed with, with the doors and bosses as the seed shuffled them and Instrument Randomization as it was set. A
    Nightmare Gate's reward is green once its boss can be got to (or is beaten), a boss's heart container once its
    place and its fight can; a place the logic doesn't reach (or tower defense's reward) once the player has every
    progression item, as the placement has it. Each tab shows how many of its places are green (the green mark) and
    taken; the screen the player is in is outlined, and Follow the player goes to its tab as they move. Hide taken
    leaves out what's taken.
  - items.html, the Item Tracker: the progression the player has, lit (the movement abilities, each ability set's
    attacks with their own pictures, the Game Powers, the instruments, the cursed equipment), and how many of each
    upgrade of how many there are (keys, heart pieces and containers, heart energy, quivers, missile tanks, Game
    Power, air upgrades, weapon upgrades, bomb upgrades, skill points, Internetz mods: the progress page's counts, the
    general store's included), and under them the bosses, ten a row in the boss gallery's order, the CHAOS Warmaster
    (the win) last: each one's head (cut out of its sprites: tracker.py's BOSS_ICONS), lit once it's beaten (with Boss
    Rando, the boss fought, wherever it was), and the Abomination's once it is. The Executive isn't there (the logic
    doesn't count him). For a stream: items.html?bg=transparent (or a colour: bg=00ff00), and
    scale=2 for bigger pictures (items.html?bg=transparent&scale=2).
  The screens' names (tracker_names.txt) are the game's own where it has them: the area banners, the teleport menu's
  places, Gate 4's stage map, the jukebox's titles; a screen's number is its room's own place in its group (a letter
  as its place in the alphabet). Any can be changed there, and a check given a name of its own; then build again.

Archipelago
  The Randomizer can be one game of an Archipelago multiworld (game name "DT3+"): its items can be in other players'
  games, and theirs in its places. Three parts:
  - the DT3+ world, archipelago\dt3plus.apworld in the build (made from archipelago\dt3plus: its locations, items and
    logic are the same as the mod's, data.py written by the build). Install it with the Archipelago Launcher's
    "Install APWorld" (or put it in Archipelago's custom_worlds folder); Archipelago 0.6.4 or later.
  - the DT3+ Client (client.py, in the world: the Launcher's "DT3+ Client"). The game can't connect to the server
    itself, so the client does, and the two trade small text files in %LOCALAPPDATA%\DT3PlusArchipelago (client.py
    describes each; every file starts with the multiworld's seed and the slot, so neither side reads another game's).
  - the mod's Archipelago mode: type ap on the title screen, then start a New Game while the client is connected. No
    items are placed in the game: a place taken sends its check to the client (another world's item says whose it is
    and shows as a multicoloured orb), and the items the server sends are given as they come, with who sent them.
    DeathLink both ways when the multiworld has it on. The equipment shops are shuffled from the multiworld's seed. A
    save carries on with the client connected again: checks made meanwhile are sent then.
  The docs for the Archipelago website are in archipelago\dt3plus\docs.

Building
  python tools\modkit\randomizer\roomlogic\roomlogic.py
  works out each room's logic from the game's rooms (roomlogic\rooms\ and connections.txt; about seven minutes), then
  joins the rooms (roomlogic\roomlogic.txt). Run it again after changing the game's rooms. After changing only
  roomlogic\overrides.txt, python tools\modkit\randomizer\roomlogic\solve.py is enough (seconds); the build runs it too.
  roomlogic\README.txt explains the logic and its files.
  python tools\modkit\randomizer\rndgen.py <output folder>
  (then copy the output folder to Mods\Randomizer). The build reads the game's rooms and code: the places (locations),
  their items, the locked doors, the shops and the bosses; joins the room logic with overrides.txt (solve.py); and writes
  the mod's data scripts, the pickups' events (the randomizer's part ahead of the game's own) and, next to rndgen.py,
  locations.csv and doors.csv. It ends with a check that the placement works for 50 seeds with each option, and how
  many layers they have; then writes the room logic Entrance Rando and Boss Rando make seeds from (data\rndER.txt,
  roomlogic\erflat.py) and makes ten seeds of each of their modes (and Chaos with Boss Rando), each played through;
  then the trackers' data (tracker\data.js, with the same room logic, and the items' pictures and the bosses' heads in
  tracker\icons: tracker.py).
  python tools\modkit\randomizer\rndgen.py --world-from <save.dts>
  re-reads world.txt (the endgame world's values) from a finished save.

  mod\         the mod's own code, copied into the build (a <event>.prefix.gml gets the game's own event after it)
  The build also copies some of the game's own events into the mod, changed (the pickups', oHUD's Draw: rndgen.py's
  SIMPLE_PICKUPS and GAME_PATCHES), so build it again after changing those in the game.
  world.txt    the endgame world state, save file keys and values from a 100% save
  roomlogic\   the logic: each room's file, how the rooms join, changes to them (overrides.txt), and the program that
               makes them (roomlogic\README.txt)
  logic.txt    last-resort changes to single places (below)
  tracker_names.txt  the Check Tracker's tabs and screens, and names for single checks (Trackers, above)
  traps.py     the enemy traps the Randomizer brings back (Playing, above): which of the game's, and how each is changed;
               the build makes their mod objects from the game's code, and roomlogic's roomdata.py their barriers

Logic
  What a place needs comes from the rooms themselves (roomlogic\): a program runs the game's own 30fps movement through
  every room (walking, jumps, double jumps, air dashes, dashes, the High Jump Boots in Gate 5, wall jumps where the game
  has them, springs, moving platforms, elevators, the Strike Chain, water, the Morph Ball: rolling, turning into it in
  the air where the body meets a wall or a ceiling (into a tunnel), and back once out in the open; bouncing off flying
  enemies with the Mario Ability Set) against the room's solids, platforms and hazards. It writes each room's logic as a
  file (roomlogic\rooms\<room>.txt): from each way into the room, what each way out and each place needs, with the
  moves that do it, step by step. solve.py then joins the rooms by their exits (connections.txt) from the start in
  Central City. Gates on the way count as what opens them: a locked door its key, a breakable
  wall the attack that breaks it (a sword or whip, bombs, missiles), a Metroid door its beam or missiles, a boss's room
  an attack to beat it with. So do switches (an attack, standing or at the top of a jump; a shot from further), Starry
  Skies' ice blocks (Shotgun Ice or Holy Water: their platforms) and the Magical Castle's platform makers (an attack).
  Each place gets the ways there that need the least (any one of them is enough). Nothing it counts needs pixel-perfect
  play: its jumps are a little weaker than the game's (95%), a landing on the very edge of a ledge doesn't count, and
  touching an item or exit has to be more than a brush.

  The placement is in layers. Layer 1 is what jumping alone reaches from Central City. The abilities and keys go one at
  a time, each to a free place the ones placed before it reach, and each is (when there is one) an item that opens
  somewhere new: what it opens is the next layer. Of those, an item that opens fewer places is likelier (each kind by 1
  over how many it opens), so the movement abilities, which open the most, tend to come later. Each goes to the newest
  layer with a chance of 7 in 10 (Ability Spread: 3 Near, always Far), else the one before with that chance, and so
  on, so they spread out: a double jump near the start can open the way to a dash, which opens the way to the whip, and
  so on. With Guarantee Early Weapons, a new layer's first item is a weapon (above). The game can always be finished.

  Places the room logic can't work out (behind puzzles, timed rings or things it doesn't model, and the rewards of
  bosses and tower defense) need everything: they never hold an ability or key. The Trial Master's trials' rewards
  need the three cursed equipment pieces (which are placed with the logic, as the abilities are).
  locations.csv lists every place with what it needs.

  Why a place needs what it does: python roomlogic\solve.py --explain "skill point 59" lists the rooms on each way
  there and what each room's part needs; the room's file has the moves.

  Where the logic is wrong, roomlogic\overrides.txt changes it: what a way through a room needs (from a way in to a way
  out or a place), what going through an exit needs, or where an exit leads. Everything past it is worked out again
  with it (roomlogic\README.txt). As a last resort, logic.txt replaces what a single place (or every place in a room)
  needs, with alternatives separated by |, each the items it takes (djump, adash, gdash, hijump 2, mario, link 2,
  belmont 1, megaman 4, samus 6, gamej 1, gamec 1, varia, cursed 3, key 3: the key of the locked door whose objectNum is
  3 in doors.csv), nothing or everything. It only changes that place (or room): the rooms past it aren't changed with it.

Limits
  - Moving platforms are counted as somewhere the player can stand anywhere along their path (waiting for them), and
    the part of a block that's there wherever it is as a wall; some kinds aren't modelled at all (crushers, the Gravity
    Well's platforms, rails). Puzzles of several switches at once, push blocks, timed rings and wind aren't either.
    What's behind them needs everything.
  - A room's switches of one kind are one switch to the logic (hitting any of them changes all their blocks), and so
    are its ice blocks and platform makers (one hit: all their platforms).
  - A bounce off a flying enemy (a Paratroopa, Lakitu, Bullet Bill, bat...) counts near where one starts (within a
    screen), once per jump, wherever in its flight it would be needed; the CHAOS soldiers can't be bounced off.
  - A boss needs any attack; one that only some attacks can hurt could hold the game back.
  - The instruments, the Abomination and the Warmaster EX (Fedex) fight are the game's own.
  - The general store (oOtherShopA) sells what it does in the game; only the equipment shops are shuffled.
  - Story-only rooms that the endgame world doesn't reach (Tranquil Serenity and the like) have no places.
  - Not in the boss list: the Abomination (58), the Warmaster EX room (65), the Ridley tunnel chase (37) and the
    Leviathan road (41), which aren't fights a room makes, Hexor (63, the Distortion's last fight), and each room's
    second boss (Death, Sigma, Ridley and the Decimator have two).
  - A save from an earlier build of the mod doesn't carry over (its items are numbered differently): start a new game.
