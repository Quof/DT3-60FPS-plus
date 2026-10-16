EVIL BOSS GALLERY
=================

A mod (Mods\EvilGallery, built by build.py here) that adds a second boss gallery with evil versions of the bosses:
harder fights made mostly of new attacks, each with a tell to read and an answer in the player's own kit. The game's
own fights and rooms are untouched; the only change to a game room is the gate in the Boss Gallery (a patch).

  python tools\modkit\evil_gallery\build.py <empty output folder>     then copy the output to Mods\EvilGallery

build.py takes mod\ (the objects, scripts, hooks and each room's creation code, mod\roomcode) and adds what it makes from
the game's files: the evil sprites (recolor.py: the game's sprites with their colours moved to an evil palette), the
gate's arch and swirl, the rooms (copies of the game's) and the patch. Build it again after those game files change.


GETTING IN, SCORES
------------------

At the end of the Boss Gallery's entrance floor (where its first score sign was; the sign is moved next to the entrance
signs) is a dark arch with a swirl in it: Up there goes to the Evil Boss Gallery (rEvgGallery, the Boss Gallery's layout,
darker), in front of the same arch, which leads back. Its doors are the gallery's own (oEvgDoor): the evil ones open,
the rest sealed. A door starts its fight with the same abilities the Boss Gallery gives for that boss (the NORMALIZED
lever works the same), and every way out of an evil fight (a win, giving up, Retry and [Skip] work as in the gallery)
comes back to the evil gallery.

Each evil boss keeps its best time and fewest hits in a win (saved with the game, section EvilGallery), shown on its
door, with medals for the hits: bronze for 3-4, silver for 1-2, gold for none. Assist Mode can play them but isn't
recorded.


THE FIGHTS
----------

Each has about 1.4 times the boss's life and the same damage; what makes it harder is the new moves, the boss's own
moves coming quicker, and a last phase. Every new move has a tell (a pose, a sound, a line or band showing where it'll
go) long enough to react to, and a way through it with the abilities that fight gives.

Evil Bowser (rEvgBowser; Mario's jump and stomp, Jerry and Claire)
  Bowser's fight on the bridge of bricks, with his stomps, fireballs and switch phase, plus:
  - shockwaves: every stomp's landing sends a flame along the floor each way (a short hop clears it)
  - hammer volley: he holds a hammer up, then throws six in arcs at different distances (read the arcs, find the gap)
  - meteor: he crouches, leaps to the ceiling and follows the player along it, flashes and locks on (a mark on the
    floor and a red line under him), then drops fast: the landing shakes the arena and its shockwaves are doubled
  - inferno: he roars and calls Paratroopas; embers rise, then the whole floor bursts into flame, wave after wave from
    under him outwards. The Paratroopas, flying across at different heights, are the way over it: bounce on them
  - fireball bursts (two or three, foot high then chest high), fire rain at each new row, and in his last phase Bullet
    Bills from each side in turn, low then high. The top row of bricks is reinforced: his first stomp only cracks it
  Inspirations: Fury Bowser and Molten/Dry Bowser (the arena itself turning on the player, the stomp that shakes the
  ground), Kirby's Extra Mode bosses (the same boss, new moves added to the old ones).

Evil Helmethead (rEvgHelmet; Jerry, Link with sword and arrows)
  Helmethead's walk-and-shoot, plus moves that make the sword and the arrows each the right answer at different times:
  - head toss: his head flies out in an arc and back like a boomerang; while it's off, his neck is open and every hit
    does double
  - shield charge: he crouches behind his shield, then runs the arena's length. From in front nothing hurts him; jump
    over and every hit from behind does double. A short stagger at the end
  - polarity helmets: his heads come off as flying helmets that flash white and swap colour every few seconds: a red
    (iron) one shrugs off the sword, a blue (mirror) one throws arrows back. Hit each with what its colour is weak to
  - barrier (60%): he can't be hurt until both helmets are broken; meanwhile they take turns to dive at the player
    (a warning line, then straight down). Anything that hits a diving helmet knocks it down dazed, and damage to a
    dazed helmet hurts him too
  - orbit (40%): the helmets circle him, big, stopping arrows and hurting to touch, and his shots come three at a time;
    at 20% they dive again, faster, and his moves come more often
  Inspirations: Zelda II's Iron Knuckles and Helmethead (high and low shield reads, the head that comes off), Hades'
  Extreme Measures (the same boss with a new pattern that changes how its old moves have to be answered).

Evil Death (rEvgDeath; Claire, Belmont with whip, dagger, holy water and the dash)
  Death's duel, faster (his combos, jumps, flying scythes and Wrath), plus three moves, one every few seconds while he's
  free, in an order of their own for each phase:
  - sickle storm: sickles circle above him, then one by one stop, aim (a flashing line shows where) and fly. Anything
    breaks one (the whip gets heart energy for it), and holy water's fire under the ring burns them
  - phantom rush: he fades out and phantoms of him tear across the arena from each side in turn, each after a red band
    shows its height: on the floor (jump it: a full jump) or above a standing player's head (stay on the ground). A dash
    goes through either
  - soul siphon: he plants his scythe in a vortex that pulls the player in (like Gate 6's strongest wind by the end),
    flashes red, then reaps all round him with a huge spin (jump it, or be far away). Holy water on him or into the
    vortex breaks it
  - holy water against his pentagram: the shield he raises against daggers breaks under holy water. Throw a dagger to
    bait it out, then holy water: he staggers. Staggered (by the shield or the siphon breaking) he's on his knees for
    about 2.5 seconds and every hit does double
  His phases come at 85%, 72%, 65% (his Wrath), 50% and 25%: more sickles, faster storms, phantoms high and low mixed.
  Inspirations: Castlevania's Death (scythes, sickle swarms), Hollow Knight's Absolute Radiance and Kingdom Hearts II's
  Data Organization (dense patterns in which every attack still has a read and an answer).


FILES
-----

mod\hooks         init, save, load (the records), roomStart (giving up an evil fight comes back to the evil gallery),
                  gameOverHint (the Game Over hints for the evil fights)
mod\scripts       evgRoomOf (a door's evil room), evgTally (a win's records), the evil Bowser's helpers
mod\objects       oEvgGate (the gate), oEvgDoor, oEvgGloom (the evil gallery's darkness); oEvgBowser and his
                  oEvgShockwave, oEvgFloorFlame, oEvgParatroopa, oEvgBulletBill; oEvgHelmet, oEvgHeadToss, oEvgHelm;
                  oEvgDeath, oEvgDeathHS (his hit spot), oEvgPentagram, oEvgSickle, oEvgPhantom, oEvgSiphon
mod\roomcode      each room's creation code
Evil Bowser and Evil Death are children of the game's Bowser and Death (oBowser, oDeath: the game's switches, hit spot
and shield find their boss by those names); Evil Helmethead is his own (oEnemyBase).
