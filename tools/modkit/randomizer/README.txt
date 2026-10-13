DT3+ Randomizer (a mod)
=======================

A new game with the mod on starts in the game's endgame world: every area open, the story done, no CHAOS invasion. The
player is in the first room (Grand Rising) with nothing but walking. Every collectible the progress page counts (heart
pieces and containers, chests, quivers, heart energy, missile tanks, Game Power, air upgrades, Internetz mods, weapon
upgrades, skill points, bomb upgrades, keys, the Item Finder, the X-Special charge, the Spring Ball), every movement
ability (jump, dash, air dash, double jump, the High Jump Boots) and every ability set (the Mario Ability Set, shown
as a ? block, and the attacks of Link, Belmont, Mega Man, Samus and the two Gate 6 sets) are shuffled into each other's
places when the game starts, and three more places are on the ground next to where the player starts. The equipment
shops' stock is shuffled between the shops. A spoiler log is written to the Saves folder ("Randomizer spoiler log
<seed>.txt"). As in a new game: tower defense and the Trial Master's cursed trials aren't done (their rewards come
from doing them; the 7th trial also gives Central City South's heart container, and the three cursed equipment pieces
the trials need are never among the trials' rewards), the shortcuts are shut, and there are no program chips, Yoshi
dolls or game-completed flag (Bubble Tower B and the Gate 6 DLC stay shut).

Win: the 8 instruments (the Nightmare Gates' bosses, then the Sacred Temple) and the Abomination, as the game has them;
then the CHAOS Warmaster, whose door appears in the first room once the Abomination is beaten. The credits roll.

Playing
  Put the built mod in Mods\Randomizer and turn it on. Every new game is then a randomizer game (a save made with it
  stays one). On the title screen, typing seed and a number (seed1234) makes the next new game use that seed.
  - The ability sets' items are progressive: each one is that set's next weapon (Link: Master Sword, Bow & Arrow, Fuse
    Bomb). Swapping characters and sets is always on. The Gate 6 sets only work in Gate 6, as in the game.
  - Each key opens its own locked door (the message says which area it's in); a door without its key says so.
  - Bosses are fought in their own rooms: walking up to where a boss's fight starts (or leaving its room another way
    than the player came in) starts it, as the room's own fight (the room's code makes the boss), with the player's own
    abilities and the life and ammo they came in with. A boss has to be beaten to go on: given up from the game over
    screen, the player is back where they came into the room, and walking up to it again starts it again. (These fights
    have the boss gallery's flag on underneath, so a beaten boss ends its fight the gallery's way, without the story's
    scenes; the mod's oHUD doesn't show the gallery's timer in them.) Ridley and the
    Parasitic Seed, whose rooms the endgame world's exits go past, are fought going through the exit the story used
    to go into them (rndgen.py, BOSS_VIA). A boss's heart container is there once it's beaten.

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
  python tools\modkit\randomizer\rndgen.py <output folder>
  (then copy the output folder to Mods\Randomizer). The build reads the game's rooms and code: the places (locations),
  their items, the locked doors, the shops and the bosses, and writes the mod's data scripts, the pickups' events (the
  randomizer's part ahead of the game's own) and, next to rndgen.py, locations.csv and doors.csv. It ends with a check
  that the placement works for 50 seeds.
  python tools\modkit\randomizer\rndgen.py --world-from <save.dts>
  re-reads world.txt (the endgame world's values) from a finished save.

  mod\         the mod's own code, copied into the build (a <event>.prefix.gml gets the game's own event after it)
  The build also copies some of the game's own events into the mod, changed (the pickups', oHUD's Draw: rndgen.py's
  SIMPLE_PICKUPS and GAME_PATCHES), so build it again after changing those in the game.
  world.txt    the endgame world state, save file keys and values from a 100% save
  logic.txt    changes to the logic (see below)

Logic
  The game can always be finished: abilities and keys are placed so that each can be reached with the ones placed
  before it. What a place needs is an estimate from the story's order, not a map of the rooms: a place needs everything
  the story had given by the time it first reached that area (the areas' numbers in locationCheck are in story order;
  the stages are in rndgen.py, STAGE_ADD), and the keys of every locked door up to that area. locations.csv lists every
  place with what the estimate says it needs, doors.csv the doors in that order. Places in rooms with no area of their
  own (rMario1's take Gate 1's), and the heart containers bosses give, can't hold an ability or key.

  Where the estimate is wrong, logic.txt changes it: a place that needs less (a heart piece in an early area that only
  needs jumping) gives more variety; a place that needs more than the estimate (one that needs an ability the story
  only gives later) can hold an ability the player can't reach yet, and the seed may not be finishable. The spoiler log
  has where everything is.

Limits
  - The logic is the estimate above: places needing an ability from later in the story than their area are the risk.
  - The instruments, the Nightmare Gates' bosses, the Abomination and the Warmaster EX (Fedex) fight are the game's own.
  - The general store (oOtherShopA) sells what it does in the game; only the equipment shops are shuffled.
  - Story-only rooms that the endgame world doesn't reach (Tranquil Serenity and the like) have no places.
  - Not in the boss list: the Nightmare Gates' bosses, the Abomination (58), the Warmaster EX room (65), the Ridley
    tunnel chase (37) and the Leviathan road (41), which aren't fights a room makes, and each room's second boss (Death,
    Sigma, Ridley and the Decimator have two).
