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
and the Trial Master's cursed trials have to be done again for their rewards. The equipment shops' stock is shuffled
between the shops.

## What is the goal of DT3+ when randomized?

Get the 8 instruments (each Nightmare Gate's boss leaves its own instrument where it's beaten), beat the Abomination,
then defeat the CHAOS Warmaster at the end of the CHAOS Warship (his fight is there once the Abomination is beaten).

## What items and locations get shuffled?

The Randomizer's locations: every pickup and treasure chest in the game's rooms, and the heart containers the bosses
and the 7th trial give. The items are what those hold, plus every ability the story would have given (but jumping).

## Which items can be in another player's world?

Any of them.

## What does another world's item look like in DT3+?

A multicoloured Archipelago orb. Touching it sends the item to its player; your own items show as themselves.

## When the player receives an item, what happens?

It's given at once, with a message saying what it is and who found it.

## Is the logic exact?

The logic comes from the rooms themselves: a program runs the game's own movement through each room (jumps, double
jumps, air dashes, dashes, springs, moving platforms, the Strike Chain, the Morph Ball) and joins the rooms by their
exits, so each location needs what actually gets the player there from the start. It leaves some room for error (its
jumps are a little lower than the game's, and it doesn't count landings on the very edge of a ledge), so nothing in
logic needs pixel-perfect play. Places it can't work out (behind switches, puzzles, or a boss's or trial's reward) need
every progression item in logic, so they never hold one.
