DT3+ Randomizer (a mod)
=======================

A new game with the mod on starts in the game's endgame world: every area open, the story done, no CHAOS invasion. The
Highlands are as they were before the CHAOS Warship's attack: their own enemies and music, no purple sky, fog or CHAOS
enemies, the Teleporting Stone on and Chao's scan working (their rooms are made with the story before it, gameProgress
4925: mod\scripts\rndHLEnter.gml; a way in that doesn't do that, a Teleporting Stone's or a boss fight's way back,
makes the room again with it: the roomStart hook). Upper Crossroad has no rubble then; its way to rTS_A is taken out
and its way to the Hidden Bot Village leads to the destroyed village, as the endgame and the room logic have them. The
player is in Central City - North, at the door from Greatest Stretch, able to walk and jump. Every collectible the
progress page counts (heart pieces and containers, chests, quivers, heart energy, missile tanks, Game Power, air
upgrades, Internetz mods, weapon upgrades, skill points, bomb upgrades, keys, the X-Special charge, the Spring Ball),
the other movement abilities (dash, air dash, double jump, the High Jump Boots), the Varia Suit (Gate 5's lava doesn't
hurt once it's found; before, it does) and every ability set (the Mario Ability Set, shown as a ? block, and the attacks
of Link, Belmont, Mega Man, Samus and the two Gate 6 sets) are shuffled into each other's places when the game starts,
in layers (see Logic). The places of the story's ability pickups (17: the Dash Boots, the double jump's, Link's bow and
bombs, Belmont's dagger and Holy Water, Gate 5's upgrades and suits; rndgen.py's STORY_SPOTS, location type 19 "Story
Item"), which the endgame world has none of, are locations too, a pickup where the story's was (oRndStory). Four of
them, at random among those the logic reaches, hold the Nightmare Mode's own abilities, which work as in Nightmare Mode
once found: Link's Sword Wave (at full life), Mega Man's charge shots stored (up to three), Belmont's Dagger Spam
(Down, Down, Forward, Forward, then the dagger) and Samus's Power Bomb (the bomb button held in the Morph Ball). The
game's code for them asks Nightmare Mode: the mod's versions of playerTechStart and playerTechUse, and its oHUD's
meters, ask the item too (rndgen.py's SCRIPT_PATCHES and GAME_PATCHES, made from the game's own code). The Item Finder isn't shuffled: it's where the game has it, and with it Chao shows a ! instead of
the treasure icon in a map with an ability, an ability set's item or a key. The equipment shops' stock is shuffled
between the shops. A spoiler log is written to the Saves folder's Seeds folder (Saves\Seeds\Randomizer spoiler log
<seed>.txt), with the options and the abilities and keys by layer. As in a new game: tower defense and the Trial Master's cursed trials aren't
done (their rewards come from doing them, with the three cursed equipment pieces on; the 7th trial, five of the six
others done, also gives Central City South's heart container), the shortcuts are shut, and there are no Yoshi dolls
or game-completed flag (Bubble Tower B and the Gate 6 DLC stay shut). The six program chips: all had from the start,
or with Chip Randomizer none (each an item that opens its Access Gate: below). Nightmare Gate H is left out: its
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
    Entrance Rando           Off, Gate Swap, Area or Chaos: where the doors lead is shuffled (below).
    Boss Rando               Off or On: which boss is fought in each boss's room is shuffled (below).
    Instrument Randomization Off or On: the 8 instruments are in the pool, and the Nightmare Gates' rewards hold any
                             item (no ability or key: a fight's reward, as the bosses' heart containers).
    Chip Randomizer          Off or On: the 6 Program Chips are in the pool, and each Access Gate's portal (and the
                             Nightmare Gate portal beside it) opens with its own (below), as does its section of the
                             skill tree. Off (the default): the player has all
                             six from the start, and the whole skill tree is open. Always off with Entrance Rando
                             Chaos (greyed out in the window; the choice is kept for the other modes).
    Traps                    Off, 2 Minutes, 5 Minutes or 10 Minutes: 30 of the items (6 of each of 5 traps) are
                             trap items, in Internetz chests' places, each lasting that long (below).
    Spoiler Log              written or not.
  An Archipelago game has no options window: its options are the DT3+ world's, in the player's YAML (below,
  Archipelago).
  - Traps: trap items (not the enemy traps below) in the place of 30 Internetz chests (rndgen.py's snare_slots: the
    smallest after the six the Program Chips take, so both options can be on), the five traps in turn, 6 of each. A
    trap item looks like a Weapon Upgrade (its weapon by where it is), or is in a chest that sparkles as for any item
    but Internetz; Chao's Item Finder counts it as an item. Taken, it springs (the mod's rndSnareSpring), the timed ones
    for the option's time (2, 5 or 10 minutes): Darkness, Dark Mode's darkness (oSurfLightAll) in every room;
    Rocketeer, a CHAOS Rocketeer now, and another in every room come into (none in boss fights); Teleport, at once, back
    to a way into a room the player has come in by this run, at random (the newest 400 kept; in a boss fight, once it's
    over); Achilles, any hit kills, as in Achilles Mode (the mod's takeDamage, rndgen.py's SCRIPT_PATCHES); Wind Orb,
    the Green Warmaster's seeker orb (his charged supermove, oWMD_SeekerOrb: the mod's oRndSnareOrb, which doesn't run
    out and which nothing destroys) after the player now and in every room come into (none in boss fights). The time is
    of play (not counted while paused), and one sprung again while it's on starts it again. The HUD shows each one's
    time left (the drawHUD hook); the save keeps them, and the ways in. A save from before the Wind Orb has its own trap
    items (28 of the four before it: rndgen.py's snare_slots_old) and their 5 minutes. The traps aren't progression
    items, so where the others go is as without them. In an Archipelago game they're items of the multiworld
    (classification trap): its own can be in other worlds, and spring when they come (rndApGive), for its world's time.
  - Entrance Rando: the mode's doors are paired anew, coupled (going back through a door returns the player where they
    came from). Gate Swap: the Access Gates' and Nightmare Gates' doors. Area: the doors inside each region of the game
    (roomlogic\regions.txt: Initiate's Pass, Central City, Begonia, each Access Gate, the CHAOS Warship, ...), each
    region's paired only among its own, while the doors between regions (the gates' portals, Central City's way to the
    Greatest Stretch) are the game's; regions.txt can be changed. Chaos: every door. (Area took the place of the
    overworld mode, which shuffled the doors between areas: a save made with that keeps its own shuffle.) The seed is
    made so that with
    everything, every place the game's own doors reach is reached, and the game can be finished: the items are placed
    with what the shuffled doors reach, and the seed is played through before the game starts (a shuffle that fails is
    dropped for another; roomlogic\README.txt, ENTRANCE RANDO). Making it takes a few seconds. The spoiler log lists
    the doors. A save keeps its shuffle (and needs the same build's door data, data\rndER.txt, to put it back; a save
    made with an earlier build's doors that this one still has, roomlogic\erflat.py's ER_LEGACY, loads as it was made).
    On Hyrule's and Gate 6's maps a tile and its place are a door: the place's exit next to where the tile has the
    player come in. Its other exits back to the map that come out at the same tile (a town's far side, a palace's way
    out after its boss, a place of several rooms' last one) follow that door: they lead where it now leads. Forest 1's
    tile, which has the player come in mid-room, is a door with its exits too. A crossing's far side (a bridge's, a
    pass's: out on the other side of a river or mountain) still comes out there, as nothing on the map leads into it
    on that side; the encounter fights and the Forest Palace aren't shuffled.
    Gate 4's stages, which go one way in the game (each room's exit leads into the next, nothing back), have a way back
    in a Randomizer game: each of their rooms but the boss rooms has an exit at its edge where the player comes in (its
    arrow shown, walked into, as the forward ones are), to the end of the room before, beside that room's exit
    (rndgen.py's MM_BACK_EXITS; the roomStart hook makes them, and the room logic has them). So each room's exit and the
    next room's way back are a door, which Chaos shuffles (a stage's rooms are one area, as every Access Gate's are, so
    Overworld leaves them). The ways into the boss rooms stay one way.
    Gate 5's Metroid hatches don't keep its doors to each other: a door with a hatch in front of its exit pairs with any
    other (going back through it takes what opens the hatch, any weapon for most, as the logic has it). A player who
    comes in behind one without that, with no other way out, has the pause menu's Teleport.
    Left out of every mode: the Subconscious Filter and the Discombobulated, hallways with no places (roomlogic\er.py's
    LEFT_OUT). The Discombobulated's way on to its boss is gone in the endgame world, so in a Randomizer game its way in
    (rMain_87's drop) leads straight to the boss's room (Defective's), and that room's way out back to rMain_87 (the
    roomStart hook; roomlogic\overrides.txt's link lines), but in a game whose doors were shuffled with an earlier
    build's (ER_LEGACY), whose shuffle may go through its hallways.
    Gate 5's checkpoint (where dying there, and loading a save made there, go back to) is set wherever the player comes
    into Gate 5 from outside it, as the game sets it at the gate's own way in: Entrance Rando and the Randomizer's warps
    can come into any of its rooms (the roomStart hook). A save made in Gate 5 by an earlier build with no checkpoint set
    (it went to the title screen) loads in the room it was made in, at a way into it (the load hook).
  - Boss Rando: each boss's place (its room; Ridley's and the Parasitic Seed's: the exit the story went into their
    fights by) gets another boss's fight. Walking up to the boss there (as below) starts that boss's fight in its own
    room, the boss gallery's way; won, the player comes back to where the fight started and the place counts as beaten
    (its heart container is there, a Nightmare Gate's reward too, and it isn't fought again). The 54 bosses fought the
    Randomizer's way are shuffled, the Nightmare Gates' seven among them (Kamek, Final Nightmare, Blackmore, Elpizo,
    Shadow Form, Nightmare, Sephiroth); the CHAOS Warmaster stays the last fight, at the end of the CHAOS Warship, The
    Executive stays in his own room (his fight needs nothing: below), and so does Hexor, an optional fight at the
    Distortion's dead end (fought the gallery's way, his fight ends with his first form). Ridley's fight is his three
    (below), and they move together: his fight at Bowser's place is Ridley, Ridley (Lava), then the tunnel chase,
    walking up to Bowser. Not in it, as the Randomizer leaves them to the game: the second fights of a room (Death
    (Legion), Sigma Epsilon, Decimator 20000), the Leviathan road, the Abomination's fight (the gallery's Wahfuu, the
    instrument quest's end) and the CHAOS Warmaster EX. The items are placed with what each place's fight now takes
    (roomlogic\bosses.txt has what each fight takes), and the seed is played through before the game starts. The
    spoiler log lists the fights. A save keeps its shuffle.
  - Chip Randomizer (not with Entrance Rando Chaos: there the player has all six, as the Archipelago world has it too):
    the six Program Chips are items, in the places of the six smallest Internetz chests (rndgen.py's chip_slots), and
    Access Gate N's portal can only be used with chip N, as can the Nightmare Gate portal beside it, made of that gate's
    game (Nightmare Gate A with chip 1, B 2, C 3, D 4, F 5, G 6; E, in the Vault, and H take none), wherever Entrance
    Rando has the portal lead. Without the chip, pressing Up at the portal only says which chip opens it (the mod's
    oAccessGate, rndPortalChip). Nothing else into a gate's rooms takes a chip: a door Entrance Rando joined to them, a
    boss fight. The logic has the same rule: roomlogic\overrides.txt's need lines for the portals ("chip N"), which the
    build turns into the mod's list of portals (portal_chips), so no chip is ever placed behind a portal it opens; the
    build checks that for its seeds without Entrance Rando, and every seed is played through before the game starts.
    The pause menu shows as many chips as the player has. Off: all six are had from the start, and the logic counts
    them as had. A save (or a multiworld) from before the portals took the chips has them as its items were placed: a
    portal into Access Gate N's rooms from outside them takes chip N, by where it leads (rndChipPortals 0).
  - The skill tree: its red nodes (the gate locks) open with the Program Chips, section N with chip N, so with Chip
    Randomizer off the whole tree is open from the start. In the game each section opens with Access Gate N's ability
    set (1 the Mario Ability Set, 2 Link, 3 Belmont, 4 Mega Man, 5 Samus, 6 Gate 6's), which a Randomizer game finds in
    any order: with the Mario Ability Set late, every section would stay locked. A section's skills still come after
    the skills before them (mod\scripts\menuSpendAP.gml: the game's own script, with the sets counted by the chips).
  - The dash meter shows with the air dash alone too (the game shows it with the dash, which the story gives first;
    both take its energy: rndgen.py's GAME_PATCHES, oHUD's Draw).
  - The Distortion (Hexor's rooms, his fight too) is played as Jeremy's mech, as the story does: a scene before it makes
    the player the mech, which the endgame world hasn't, so a Randomizer game makes them it as they come into one of its
    rooms (rndgen.py's MECH_ROOMS, the roomStart hook), and any other room makes them their own character again. Entrance
    Rando leaves the doors within it as they are (the logic's ways through its rooms being Jerry's and Claire's), its
    gate's door shuffled as before: it's a dead end with no places. (Not in a Chaos game whose shuffle is from a build
    before this, which shuffled its doors.)
  - A room whose code doesn't set the area (global.location, which the game keeps from the room before: Gate 1's rooms
    after its first, whose rooms before them are always Gate 1's in the game) gets its own as the player comes into it
    from another area (rndgen.py's room table, the roomStart hook); else what goes by the area went by the one before's
    (Gate 6's enemy spawns, Castlevania's chicken hearts). And what the rooms' instances set by the area as they're made,
    before the room's own code sets it, is set again then: the water's (in Gate 5 and Gate 6 the rooms move it, as in
    Gate 6's Watery Caves; elsewhere it moves itself).
  - Cackletta: only the Mario Ability Set's stomp hurts her, as the logic has it; in a Randomizer game, where the player
    has other weapons there, no damage type does anything to her (a weapon's hit took more than her four lives at once
    and left her fight stuck: rndgen.py's GAME_PATCHES, her Create).
  - The ability sets' items are progressive: each one is that set's next weapon (Link: Master Sword, Bow & Arrow, Fuse
    Bomb). Swapping characters and sets is always on. The Gate 6 sets only work in Gate 6 and Nightmare Gate G (whose
    own sets they are), as in the game, and in The Executive's fight, which gives both characters both of them whole,
    as the game's own fight does (his phases are made for them), so it needs nothing of the player's: the logic
    doesn't count him.
  - Some areas take abilities away as the game does: the CHAOS Warship's last rooms and Warship Z (jumping, the double
    jump and the Mario Ability Set left; the CHAOS Warmaster's room and the one before it, rWarshipZ_E1 and E2, as
    before his fight: their code makes the player Jeremy's mech once the story's past him, and he's the Randomizer's
    last fight, so there the player stays their own character: the roomStart hook). That lasts while
    the player stays in the area (the rooms whose names start as the one that took them away does, up to its last
    "_"); any other room gives back everything the player has found, and the ability sets they had picked. The mod's
    own version of the game's abilSetRemove notes which room took them away (mod\scripts\abilSetRemove.gml: it then
    runs the game's own). Gate 6's and the Nightmare Gates' own loadouts (Gate 6's Game Powers and the movement
    abilities only; a Nightmare Gate's own set and few abilities, e.g. Gate A's walking, jumping and the Mario Ability
    Set) aren't kept: every ability found works there. The logic's needs for each gate stay as they are
    (roomlogic\overrides.txt: Gate A takes the Mario Ability Set, and so on). A Nightmare Gate's first room still puts
    its own set on as the player comes in, if they have it. The ability swap goes round the sets the player has, the
    Game Powers too in Gate 6 and Gate G (mod\scripts\pSwapAbility.gml, in place of the game's, which in Gate 6 won't
    leave the Game Powers and goes from Link only to Mega Man); Gate 6's gate room turns the Game Powers on as the
    player comes in, and leaving Gate 6 turns back to the set they had before.
  - The player stays who they are, Jerry or Claire. A boss fight starts with the character the player is (the boss
    gallery's setup, which the fights use, puts in the one its fight is for: Claire for Metroid's bosses, Jerry for
    Mega Man's, and so on; the mod's rndBossSetup switches back). A room whose code switches between them as the player
    comes in (Nightmare Gates B, C, D and F's first rooms, Cackletta's fight, the Bubble Tower's climb), or to one of
    them from a character only some rooms make the player, is switched back to who they were the frame before
    (oRndWatcher keeps it), or from such a character to the one played last (the roomStart hook). Swapping in
    Nightmare Gate F keeps the gate's own jump and ice running, which its rooms' code gives (the game forces Claire
    there, and the swap gave the standard ones: the mod's charSwitcher, rndgen.py's SCRIPT_PATCHES). Left as they are: the CHAOS Warship's two-floor rooms (rWarshipA, rWarshipB:
    their code puts Jerry and Claire each on their own floor by where the player comes in), the rooms the player comes
    into inside a Morph Ball tunnel (Claire in the Morph Ball, as the game has it: oPlayer1), and the characters only
    some rooms make the player (Jeremy's mech in the Distortion, the Abomination's fights' own). The logic already has
    swapping characters always working, so seeds are as before.
  - A Nightmare Gate's first room has a way straight to its boss's room, which the game opens once the boss's room has
    been come into (eGateProg 7) or the gate's instrument is had (9). In a Randomizer game it's there only once the
    player has been in the boss's room (rndGateReach, kept in the save; a save from before has it for the gates whose
    boss's room was come into, whose boss there is beaten or whose fight there was started): the instrument can be had
    before the gate's been gone through (Instrument Randomization), and a fight in that room from another place (Boss
    Rando) sets 7 too. The logic hasn't that way (it reads the gates as not got to yet), so seeds are as before.
  - The RPG level (Gate 6's, 1 to 64) makes the four base sets (Link, Mega Man, Belmont, Samus) hit Gate 6's enemies
    and bosses harder: 1x at level 1, up to 2x at level 64 (each level adds 1/63), on top of the rest (the skill tree,
    equipment, the enemy's resistances). It counts against the Prototype Game's enemies (affiliation 6: Gate 6's, the
    same ones in Nightmare Gate G, and The Executive) and nothing else. Gate 6's own two sets, whose attacks grow with
    the level already, aren't changed (mod\scripts\rndG6Mult.gml, run by the mod's takeDamage: the game's own, changed,
    rndgen.py's SCRIPT_PATCHES).
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
  - A boss beaten gives the AP the story gives after its fight (rndgen.py's BOSS_AP: the story's scenes that give it
    don't run in these fights), and then a level's worth on top: as much AP as the level the player is at then takes
    (20/100 and a boss's 50: 70/100, then 100 more, 170/100, a level up). The Abomination gives the level's worth
    once it's beaten. On Normal, as the game's own boss AP (none on Easy).
  - The Barrens' Sand Crawler (Wahfuu Jr.) comes up under the player on the sand, as in the game, till its fight is
    beaten (with Boss Rando, wherever it was fought): the mod's oSandCrawlerSpawner. The game's own has it gone by the
    Deserted Tower's progress, which the endgame world has done.
  - Bosses are fought in their own rooms: walking up to where a boss's fight starts (or leaving its room past it: by an
    exit on the other side of the fight from the side the player came in on) starts it, as the room's own fight (the
    room's code makes the boss), with the player's own
    abilities and the life and ammo they came in with. A boss has to be beaten to go on: given up from the game over
    screen, the player is back where they came into the room, and walking up to it again starts it again. Leaving the
    fight's room by one of its doors (some, like the Blade Bot's in Low Facility G, stay open) gives it up the same way
    (the exitPlayer hook: the game goes to the boss gallery, as from the game over screen). (These fights
    have the boss gallery's flag on underneath, so a beaten boss ends its fight the gallery's way, without the story's
    scenes; the mod's oHUD doesn't show the gallery's timer in them.) Ridley and the
    Parasitic Seed, whose rooms the endgame world's exits go past, are fought going through the exit the story used
    to go into them (rndgen.py, BOSS_VIA). A boss's heart container is there once it's beaten. The Nightmare Gates'
    bosses are fought the same way (their rooms' own scenes don't start), and each leaves its gate's reward.
  - Ridley is three fights in a row, as in the story (rndgen.py's BOSS_CHAIN): Ridley, then Ridley (Lava) in the same
    room, then the tunnel chase, each starting as soon as the last is won (by way of the boss gallery, which the game
    goes back to in between: the mod's rndBossNextLink), with the life and ammo the last was won with (the tunnel's
    room refills them, as the story's does). Only the third won beats his place. Retry from the game over screen starts
    the fight lost again, with what it started with; given up, the player is back where they came into the room, and
    the next try starts again from the first. His way in is the hatch at the bottom of rSamus5_Lv4_N's shaft, which the
    endgame world seals: the mod makes it a blue Metroid door while his place isn't beaten (opened from above: the logic
    has it needing Samus's bombs, samus 6, as his fight does). Won, the player is back in rSamus5_Lv4_N, by the shaft
    (rndgen.py's BOSS_VIA_BACK): the hatch leads into the tunnel, whose story chase and escape would start again.
  - A boss place not beaten yet shows its boss in the middle of its arena (where its fight holds the camera), faint and
    drifting a little, facing left (most arenas are come into from the left): a preview of the fight (oRndBossPreview;
    the look is made from the boss's sprites by bosspv.py, as the tracker's head is, but whole). With Boss Rando, the place shows dark smoke instead till its fight has been
    started once, then the boss fought there (rndBossSeen, kept in the save); a place Boss Rando leaves its own boss
    in shows it. None where the fight is gone into by an exit (Ridley's, the Parasitic Seed's) or starts as the room
    is come into (the Virus Parasite's).

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
    taken. The screen the player is in has its own space at the top, under the header however far the page is
    scrolled, whichever tab is showing ("No Checks" in the middle of it in a room without any, with the room's name
    over it); Follow the player goes to its tab as they move, its other screens below. Hide taken leaves out what's
    taken.
  - items.html, the Item Tracker: the progression the player has, lit (the movement abilities, each ability set's
    attacks with their own pictures, the Game Powers, the instruments, the cursed equipment), and how many of each
    upgrade of how many there are (keys, heart pieces and containers, heart energy, quivers, missile tanks, Game
    Power, air upgrades, weapon upgrades, bomb upgrades, skill points, Internetz mods: the progress page's counts, the
    general store's included; the keys' tooltip lists every locked door, a line each, with its key Found, Not Found
    or Used), and under them the bosses, ten a row in the boss gallery's order, the CHAOS Warmaster
    (the win) last: each one's head (cut out of its sprites: tracker.py's BOSS_ICONS), lit once it's beaten (with Boss
    Rando, the boss fought, wherever it was), and the Abomination's once it is. The Executive and Hexor aren't there
    (the logic doesn't count them). For a stream: items.html?bg=transparent (or a colour: bg=00ff00), and
    scale=2 for bigger pictures (items.html?bg=transparent&scale=2).
  The screens' names (tracker_names.txt) are the game's own where it has them: the area banners, the teleport menu's
  places, Gate 4's stage map, the jukebox's titles; a screen's number is its room's own place in its group (a letter
  as its place in the alphabet). Any can be changed there, a check given a name of its own, and the locked doors'
  places (the keys' tooltip) are there too; then build again.

Archipelago
  The Randomizer can be one game of an Archipelago multiworld (game name "DT3+"): its items can be in other players'
  games, and theirs in its places. Three parts:
  - the DT3+ world, archipelago\dt3plus.apworld in the build (made from archipelago\dt3plus: its locations, items and
    logic are the same as the mod's, data.py written by the build). Install it with the Archipelago Launcher's
    "Install APWorld" (or put it in Archipelago's custom_worlds folder with the Launcher closed); Archipelago 0.6.4 or
    later. Use the world and the mod from the same build: the doors and bosses it shuffles are the mod's own.
  - the DT3+ Client (client.py, in the world: the Launcher's "DT3+ Client"). The game can't connect to the server
    itself, so the client does, and the two trade small text files in %LOCALAPPDATA%\DT3PlusArchipelago (client.py
    describes each; every file starts with the multiworld's seed and the slot, so neither side reads another game's).
  - the mod's Archipelago mode: type ap on the title screen, then start a New Game while the client is connected. No
    items are placed in the game: a place taken sends its check to the client (another world's item says whose it is
    and shows as a multicoloured orb), and the items the server sends are given as they come, with who sent them.
    DeathLink both ways when the multiworld has it on. A save carries on with the client connected again: checks made
    meanwhile are sent then.
  The world's options, in the player's YAML, are the new game's options window's (the seed and the spoiler log are the
  multiworld's own, and its spoiler lists the shuffled doors and boss fights):
    entrance_rando            off, gate_swap, area, chaos (overworld, from before area, is area). The world shuffles
                              the doors as the mod does
                              (archipelago\dt3plus\erlogic.py is roomlogic\erflat.py's own code, copied by the build,
                              with the room logic's tables, erdata.json), keeping a shuffle only if with everything it
                              reaches every place the game's own doors do, and the goal; its logic is then the room
                              logic itself, worked out for each set of items with the doors as shuffled.
    boss_rando                true/false: the bosses shuffled the same way, the logic with each place's new fight.
    instrument_randomization  true/false: the instruments are the multiworld's items and the Nightmare Gates' rewards
                              its locations (off: each reward is its gate's own instrument, not a location).
    chip_randomizer           true/false: the Program Chips are the multiworld's items, in the pool in the place of
                              six Internetz chests, and each Access Gate needs its own (off: had from the start, not
                              items; the logic counts them as had). Always off with entrance_rando chaos (the world
                              turns it off as it starts making the seed, and says so).
    traps                     off, two_minutes, five_minutes, ten_minutes: the trap items (30, 6 of each) are the
                              multiworld's items, in the place of as many Internetz chests, each lasting that long (the
                              client gives the mod the time: trapmins). true, from before the times, is five_minutes.
    shop_equipment            shuffled (from the multiworld's seed) or as_normal.
    guarantee_early_weapons   true/false: one weapon set's first item (Link, Belmont, Mega Man or Samus, at random) in
                              the player's own world, at a place they can get to from the start (Archipelago's local
                              early items).
    ability_spread            near, normal, far: the order Archipelago tries the world's locations in for progression
                              items (it takes the first one it can): the ones that take the fewest items to reach
                              mostly first (near), as shuffled (normal), or the ones that take the most first (far).
                              About 6, 11 and 15 spheres in the playthrough.
  The client passes the world's options to the game (session.txt, from the world's slot data), and a new Archipelago
  game puts them in: the shops, Instrument Randomization, Chip Randomizer, Boss Rando's fights and Entrance Rando's
  doors, the last two only if the world's boss list and door data's hash are this build's (else it says so and leaves
  them as they are).
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
  many layers they have (with Chip Randomizer, each also played through, with no chip behind a portal it opens); then writes
  the room logic Entrance Rando and Boss Rando make seeds from (data\rndER.txt, roomlogic\erflat.py) and makes ten
  seeds of each of their modes (and Chaos with Boss Rando, and some with Chip Randomizer), each played through;
  then the trackers' data (tracker\data.js, with the same room logic, and the items' pictures and the bosses' heads in
  tracker\icons: tracker.py).
  python tools\modkit\randomizer\rndgen.py --world-from <save.dts>
  re-reads world.txt (the endgame world's values) from a finished save.

  mod\         the mod's own code, copied into the build (a <event>.prefix.gml gets the game's own event after it)
  The build also copies some of the game's own events into the mod, changed (the pickups', oHUD's Draw: rndgen.py's
  SIMPLE_PICKUPS and GAME_PATCHES), so build it again after changing those in the game.
  world.txt    the endgame world state, save file keys and values from a 100% save
  roomlogic\   the logic: each room's file, how the rooms join, changes to them (overrides.txt), the regions the
               area mode of Entrance Rando shuffles within (regions.txt), and the program that makes them
               (roomlogic\README.txt)
  logic.txt    last-resort changes to single places (below)
  tracker_names.txt  the Check Tracker's tabs and screens, names for single checks, and the locked doors' places
                     (Trackers, above)
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
    Leviathan road (41), which aren't fights a room makes, and each room's second boss (Death, Sigma, Ridley and the
    Decimator have two). Ridley's second and the tunnel chase are fought as part of his (Playing, above).
  - A save from an earlier build of the mod doesn't carry over (its items are numbered differently): start a new game.
