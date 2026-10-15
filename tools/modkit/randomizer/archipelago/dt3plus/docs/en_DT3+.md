# DT3+

## Where is the options page?

The [player options page for this game](../player-options) contains all the options you need to configure and export
a config file.

## What does randomization do to this game?

DT3+ is played through its Randomizer mod. A new game starts in the open endgame world (every area open, the story
done, no CHAOS invasion) in Central City, able to walk and jump. Every collectible the pause menu's progress page counts
(heart pieces and containers, treasure chests, arrow quivers, heart energy, missile tanks, Game Power, air upgrades,
Internetz mods, weapon upgrades, skill points, bomb upgrades, keys, the Item Finder, the X-Special charge and the Spring
Ball), the other movement abilities (dash, air dash, double jump, the High Jump Boots) and every ability set (the Mario
Ability Set, Link, Belmont, Mega Man, Samus and the two Gate 6 sets, progressively) is shuffled into the multiworld.
Each key opens one locked door of its own.

Bosses are fought in their own rooms with the abilities found so far, and must be beaten to go past them. Tower defense
and the Trial Master's cursed trials have to be done again for their rewards.

The Randomizer's own new-game options are the world's options:

- **Entrance Rando** (Off, Gate Swap, Overworld, Chaos): where the doors lead is shuffled. Gate Swap: the Access Gates'
  and Nightmare Gates' doors; Overworld: those, the doors between two areas and the maps' ways in and out; Chaos: every
  door. Going back through a door returns you where you came from.
- **Boss Rando**: walking up to a boss starts another boss's fight, in that boss's own room; beating it counts as
  beating the boss whose room it is. The CHAOS Warmaster, The Executive and Hexor stay where they are.
- **Instrument Randomization**: the 8 instruments are items of the multiworld, and each Nightmare Gate's reward (left
  where its boss is beaten) is a location. Off: each gate's boss leaves its own instrument.
- **Shop Equipment** (Shuffled, As Normal): the equipment shops' stock shuffled between the shops, or each shop's own.
- **Guarantee Early Weapons**: one weapon (the first item of the Link, Belmont, Mega Man or Samus set) is placed in your
  own world, at a place you can get to from the start.
- **Ability Spread** (Near, Normal, Far): how far from the start the multiworld's progression items tend to be in your
  world: mostly in the places that need the fewest items to reach (Near), anywhere (Normal), or in the places that need
  the most first (Far).

The seed and the spoiler log are the multiworld's own. The spoiler log lists the shuffled doors and boss fights.

## What is the goal of DT3+ when randomized?

Get the 8 instruments (each Nightmare Gate's boss leaves its own instrument where it's beaten; with Instrument
Randomization they're anywhere in the multiworld), beat the Abomination, then defeat the CHAOS Warmaster at the end of
the CHAOS Warship (his fight is there once the Abomination is beaten).

## What items and locations get shuffled?

The Randomizer's locations: every pickup and treasure chest in the game's rooms, and the heart containers the bosses
and the 7th trial give; with Instrument Randomization, the Nightmare Gates' rewards too. The items are what those hold,
plus every ability the story would have given (but jumping), and with Instrument Randomization the instruments.

## Which items can be in another player's world?

Any of them.

## What does another world's item look like in DT3+?

A multicoloured Archipelago orb. Touching it sends the item to its player; your own items show as themselves.

## When the player receives an item, what happens?

It's given at once, with a message saying what it is and who found it.

## Is the logic exact?

The logic comes from the rooms themselves: a program runs the game's own movement through each room (jumps, double
jumps, air dashes, dashes, springs, moving platforms, the Strike Chain, the Morph Ball) and joins the rooms by their
exits, so each location needs what actually gets the player there from the start. With Entrance Rando, Boss Rando or
Instrument Randomization the world runs that room logic itself, with the doors and bosses as it shuffled them (the same
code the mod uses for its own seeds). It leaves some room for error (its jumps are a little lower than the game's, and
it doesn't count landings on the very edge of a ledge), so nothing in logic needs pixel-perfect play. Places it can't
work out (behind switches, puzzles, or a boss's or trial's reward) need every progression item in logic, so they never
hold one.
