DT3+ MODS
=========

A mod is a folder in this Mods folder with a mod.ini in it. Turn mods on or off on the title screen (Mods, under Exit
Game; it shows when there are mods here). Mods are loaded when the game starts, so a change takes effect the next time
it's started. What happened while loading them is written to Mods\mod_log.txt (errors included: code that doesn't
compile is left out and named there), with how long each part of the loading took.

Only use mods you trust. A mod's code runs as part of the game, with everything the game's own code can do, including
reading and writing files on your computer.

Mods change nothing in the game's own files. With a mod turned off, the game is as it was; a save made in a mod's room
is loaded in that mod's fallback room instead (see mod.ini), and the mod's own save data stays in the save file
untouched until the mod is on again.


THE FILES
---------

  <mod folder>\
    mod.ini                     about the mod, its sounds, music and location names
    sprites\<name>.png .ini     sprites (new, or replacing the game's sprite of that name)
    backgrounds\<name>.png .ini backgrounds (new, or replacing the game's)
    fonts\<name>.ini            fonts (installed on the computer)
    sound\, music\              the files mod.ini names
    scripts\<name>.gml          scripts
    objects\<name>\             objects (new, or changes to the game's object of that name)
    rooms\<name>\               new rooms
    patches\<room>\             changes to the game's own rooms
    hooks\<hook>.gml            code the game runs at certain points in its own code

Names are the room editor's: objects, sprites, rooms and so on are named in the files the way they are in the project.
A mod's own resources can be named in its code like the game's (oMyEnemy, rMyRoom, sMySprite): they're made global
variables holding the resource. So give them names nothing else in the game has (a prefix of your own helps), and
letters, digits and _ only.


mod.ini
-------

  [mod]
  name=My Mod
  author=Me
  version=1.0
  description=What it adds.
  legacy=0
  order=0
  fallbackRoom=rCCity_NorthA
  fallbackX=640
  fallbackY=320

  [sounds]
  count=1
  var0=snd_MyHit
  file0=MyHit.wav

  [music]
  count=1
  track0=2001
  var0=msc_MyTheme
  file0=MyTheme.ogg
  credit0=Game [Title]
  gain0=0

  [locations]
  count=1
  id0=111
  name0=My Area

[mod]: name and description are shown in the Mods window. legacy=1 is for a mod made for the original 30fps game
(see DT3+ AND 30FPS MODS), 0 (the default) for one made for DT3+. Mods load in order of order (lowest first), then by
folder name; a later mod's changes win. fallbackRoom, fallbackX and fallbackY are where a save made in one of the mod's
rooms goes, and the player's position there, when the mod is off.

[sounds]: sound effects (in sound\), loaded when the game starts: global.<var> gets each one, for playSound.

[music]: music tracks (in music\). findMusic(track) plays them like the game's own. A track with a number the game has
plays instead of the game's track while the mod is on (the game's still plays while the file isn't there, so a mod can
leave its music files for the player to add); use numbers the game doesn't have for new tracks. Track 9000 is the
title screen music. global.<var> gets the track when it's loaded (var is optional). The credit is shown in the pause
menu while it plays. gain is the track's loudness adjustment in dB, as the game has for its own tracks
(getReplayGain): 0 if left out.

[locations]: location names, for locationCheck(id) and the area name in the pause menu.

Avoid # and ; in file names: ini files can read them as the start of a comment.


SPRITES, BACKGROUNDS, FONTS
---------------------------

sprites\<name>.png is a strip of the sprite's frames, left to right, all the same size. sprites\<name>.ini:

  [sprite]
  frames=4
  xorig=16
  yorig=32
  transparent=0
  smooth=0
  sepmasks=0
  bboxmode=0
  left=0
  top=0
  right=0
  bottom=0
  kind=0
  tolerance=0

frames is how many frames the strip has, xorig and yorig the origin. transparent=1 makes the bottom left pixel's colour
transparent (for images without alpha). The rest is the collision mask, as sprite_collision_mask takes it: separate
masks per frame, the box (bboxmode 0 automatic, 1 the full image, 2 manual: left, top, right, bottom), the shape (kind
0 precise, 1 rectangle, 2 disk, 3 diamond) and the alpha tolerance.

backgrounds\<name>.png with backgrounds\<name>.ini ([background] transparent=, smooth=).
fonts\<name>.ini: [font] face=, size=, bold=, italic=, first=, last= (the character range).

A sprite or background with the name of one of the game's own replaces it while the mod is on.


SCRIPTS
-------

scripts\<name>.gml is called from the mod's code as name(arguments), like the game's scripts: argument0...argument15,
argument[n], argument_count and return work as usual. (GameMaker 8 can't add scripts while the game runs, so a mod's
scripts are compiled code the game calls for it: write the call as name( with no space before the bracket.) The game's
own code can't call them; hooks can.

A script with the name of one of these game scripts is the mod's version of it, and runs instead of it everywhere the
game calls it (if two mods have one, the later mod's):

  abilSetRemove, awardAwesome, charSwitcher, characterCreateEvent, characterDrawEvent, characterStepEvent,
  checkWeaponHit, enemyDefeat, enemyDrawEvent, enemyStepEvent, equipmentInit, hitPlayer, internetzDrop,
  locationCheck, makeEnemyActive, menuAbilitySet, menuEquipment, menuMap, menuOptions, menuProgress,
  menuRecognitions, menuSpendAP, npcTrivia, pMoveAirDash, pMoveDashBack, pMoveDashForward, pMoveDoubleJump,
  pMoveJump, pMoveWallDash, pSwapAbility, pSwapCharacter, playerHeartDisplay, playerTechStart, playerTechUse,
  scrFullStatRestore, showMessage, storeStatus, takeDamage, weaponDmgMod

It replaces all of the game's script, so start from the game's version (DT3+'s, with its 60fps code). Its code runs
as DT3+ code, every frame, even in a 30fps mod. Other game scripts can't be replaced.


OBJECTS
-------

objects\<name>\object.ini and a .gml file per event, named as in the project's object files:

  Create_0  Destroy_0  Alarm_0...Alarm_11  Step_0 (step) Step_1 (begin step) Step_2 (end step)
  Collision_<object>  Keyboard_<key>  KeyPress_<key>  KeyRelease_<key>  Mouse_<n>
  Other_<n> (Other_4 room start, Other_10...Other_25 user events 0-15, ...)  Draw_0  Trigger_<n>

object.ini:

  [object]
  sprite=sMyEnemy
  mask=
  parent=oEnemyBase
  depth=0
  solid=0
  visible=1
  persistent=0
  inherit=
  block=
  events=replace
  append=
  legacy=

parent is an object, the game's or the mod's. inherit is the object whose events event_inherited() runs (the parent if
it's left out; empty: none). block lists events the object must not get from its parent, comma separated (e.g.
Step_2,Draw_0): they run inherit's instead. events is for one of the game's objects: replace (the default: each event
the mod has replaces the object's) or append (each is added after the object's own). append, also for one of the
game's objects, lists events (comma separated) that are added after the object's own while the mod's other events
replace theirs: adding to an event is quicker to load than replacing it. legacy is for one of the mod's
new objects: 1 if its code was written for 30fps, 0 if for DT3+ (left out: the mod's own legacy setting), so a DT3+ mod
can have 30fps objects in it (see DT3+ AND 30FPS MODS).

For one of the game's objects, only the settings object.ini has are changed (the mod's events for it are 30fps code in a
30fps mod, DT3+ code otherwise).

Replacing one of the game's events means clearing it when the mods load, which takes long (seconds) for an object many
others inherit from (oDamagableBase, oEnemyBase, oEProjectileBase...): add lines after the event (append) where that
does the same. A few of the game's events are replaced without clearing them (the list in scripts\scrModEvInit.gml,
which tools\modkit\addevoverride.py adds to): the game's event runs the mod's version in place of its own code, and
what other mods add after it still runs. tools\modkit\validate.py warns about a replaced event that takes long. Changing the game's objects changes them everywhere: if a mod only needs a changed
copy for its own rooms, make a new object with the game's object as its parent (the mod tools call these clones).

When two mods both have a new object of the same name, it's one object: the later mod's events and settings replace
the earlier mod's.


ROOMS
-----

rooms\<name>\ is a room in the GameMaker 8.2 project format, as the project's rooms folder has them: room.txt,
instances.txt, layers.txt with a <depth>.txt for each tile layer, code.gml (the room's creation code) and <instance
name>.gml for an instance's creation code. The easiest way to make one is in GameMaker 8.2, in a copy of the project,
then copying the room's folder here.

An instance's name in instances.txt (8 hex digits) is taken as its id in the room editor: GID(that id) finds the
instance (the game's rooms do the same for instances their code refers to), and the instance has it in modOrigId.

The tiles and instances are made when the room starts (by its creation code, which the game sets): the instances in
the order the room has them, then their creation code, in the same order. As in a room made in the editor, an
instance's creation code runs before its create event (an instance without creation code gets its create event as
it's made), and what the code sets, sprite_index and depth included, is there for the create event. All the room's
instances are there when the creation code runs: GID() finds one that comes later in the room. An instance whose
creation code destroys it (if ... {instance_destroy()}) is gone without its object's create or destroy event running.
Then the room's own creation code runs.

Only room.txt is read when the game starts. The rest of a room (its instances, tiles and code) is read the first time
the room is entered, so errors in it (code that doesn't compile, an object or background that isn't there) are added to
Mods\mod_log.txt then.

A mod's rooms can't replace the game's: change those with patches.


PATCHES
-------

patches\<room>\patch.txt changes one of the game's rooms when it starts (after its own creation code), one line per
change; lines starting with # are comments. Code is given as a file name next to patch.txt (- for none). An instance
is found by its object (not its children) and where it was placed in the room editor:

  add|object|x|y|id|code.gml          makes an instance; its creation code runs at this line, before its create
                                      event (the instances are all made before the first line runs). id: an id
                                      GID() finds it by (0 for none)
  remove|object|x|y                   takes the instance out (without its destroy event: it was never there)
  move|object|x|y|new x|new y         moves it; later lines find it at its new place
  code|object|x|y|code.gml            runs code in it, after its own creation code
  precode|object|x|y|code.gml         the same; the mod tools write these before the lines that take instances out
  gid|object|x|y|id                   lets GID(id) find it
  roomcode|code.gml                   runs code after the room's own creation code
  roomcodeset|code.gml                replaces the room's creation code: the room's own doesn't run, and this runs
                                      after all the other lines (so after the instances the patch adds)
  tileadd|background|x|y|left|top|width|height|depth
  tileremove|depth|x|y                deletes the tile in that layer that has the point x,y on it

These change the room itself, when the mods are loaded:

  caption|text                        its caption (the rest of the line)
  roomsize|width|height
  roombg|n|visible|foreground|background|x|y|htiled|vtiled|hspeed|vspeed
                                      background n, as room_set_background takes it (the background by name)
  roomcolor|colour|draw               its background colour (red+green*256+blue*65536) and whether it's drawn

A patch's code is kept as text and run with execute_string when its line runs, which keeps loading quick for a mod
with many patches; check that it compiles (tools\modkit\validate.py does). roomcode and roomcodeset code runs in an
instance of its own, so the plain variables a room's code sets stay out of oGame.

A persistent room is only patched the first time it starts.


HOOKS
-----

hooks\<hook>.gml is code the game runs at a point in its own code, in the instance running that code; a mod can have
one file per hook. argument0 and argument1 are what the hook passes. Where the game uses what hooks return, it takes
the last value other than 0.

  init           the game's variables are set up (initGameVars, a new game or a loaded save), and once when the mods
                 are loaded: set the mod's global variables here
  save           saveData, with the save file open: write the mod's data, in a section of its own (ini_write_real...)
  load           loadSaveData, with the save file open: read it back
  roomStart      every room's start (oGame), after the patches
  titleCode      a code typed on the title screen (Enter); argument0 is the code
  gameOverHint   oGameOver: argument0 0 for the boss and situation hints, 1 for the room hints; set hintMessage
  gameOverRetry  oGameOver's Retry outside the boss gallery: send the player somewhere and return 1 to replace the
                 game's own retry
  exitPlayer     oExit, as the player goes through it (argument0 its exitType): can change toRoom, newMapX, newMapY
  playerHit      takeDamage, the player hit: argument0 the damage, argument1 what hit
  mechShield     playerTechStart, the mech's shield: return 1 after putting shields up the mod's own way
  drawHUD        oHUD's draw, with the HUD on, after the rest of it
  drawTitle      the title screen's draw, after its notes on the modes that are on (*Easy Mode* and so on, at the
                 left, y 166-186): draw the mod's own there (y 196 is the next free line)


DT3+ AND 30FPS MODS
-------------------

DT3+ runs at 60 or 120fps, and its code works out a frame's worth of everything from gDeltaTime (0.5 at 60fps, 0.25
at 120fps: a 30fps step is 1), with gDeltaDoTicks 1 on the frames that are 30fps ticks. A mod made for DT3+ (legacy=0)
does the same: its code runs as written, every frame.

A mod made for the original 30fps game (legacy=1) is run so it works as it did at 30fps:
  - its step, collision, held key and held mouse button events only run on 30fps ticks, with gDeltaTime 1
  - its other events (create, alarms, user events, presses...), room and creation code and hooks run when they happen,
    with gDeltaTime 1
  - its draw events run every frame; what they change in the instance only counts on 30fps ticks when the event starts
    with a line //tickvars:a,b,c naming those variables (the mod tools write it)
  - its objects' alarms count 30fps steps, and their speed, gravity and path speed only move them on 30fps ticks
  - event_inherited() runs the event of the object inherit= names (the parent if not given)
  - code that sets room_speed should set global.modSpeedMul instead (2: twice as fast); it's back to 1 in the next room
  - oGame.time counts the game's frames (2 or 4 a 30fps tick at 60/120fps): use oGame.time30, which counts 30fps
    ticks, as oGame.time did at 30fps (the mod tools change it)
  - the player's ...Pressed keys (kActAPressed and so on) are only on for the frame of the press, which needn't be a
    30fps tick: look for the key being down now and not on the last tick instead (oKeyCodes.kCodePressed is on for a
    whole tick, and is fine)

A mod made for DT3+ can have 30fps objects in it too (object.ini legacy=1): they run as above, the rest as DT3+ code.
The game's scripts a mod replaces always run as DT3+ code.


MAKING A MOD FROM AN EDITED COPY OF THE GAME
-------------------------------------------

tools\modkit in the project converts a mod that was made as an edited copy of the original game (decompiled and split
with gmksplit) into a mod folder, and checks a mod folder the way the game reads it:

  python tools\modkit\convert.py <config.json>
  python tools\modkit\validate.py <mod folder> <project folder>

See tools\modkit\altered_insanity\config.json for an example. Changes to the game's own scripts and system objects
can't be converted as they are: they're listed in the mod's report.txt and kept in its unported folder, to be done as
hooks, or merged into DT3+'s versions of those scripts and objects:

  python tools\modkit\mergemod.py init <config.json>     merges the mod's changes into DT3+'s versions, marking
                                                         conflicts to finish by hand (then make them work at 60fps)
  python tools\modkit\mergemod.py check <config.json>    what's left to do
  python tools\modkit\mergemod.py update <config.json>   after DT3+ changed those scripts or objects

tools\modkit\altered_beast\config.json does that (and convert.py then builds the mod with the merged versions in it),
and so does tools\modkit\distorted\config.json, for a mod that changes the whole game: most of its rooms are patched,
and its new objects and scripts are ported to DT3+'s 60fps code by hand (its ported folder).
