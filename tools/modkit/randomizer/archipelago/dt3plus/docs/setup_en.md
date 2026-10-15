# DT3+ Setup Guide

## Required Software

- DT3+ with its Mods folder, and the Randomizer mod in it (Mods\Randomizer)
- [Archipelago](https://github.com/ArchipelagoMW/Archipelago/releases) 0.6.4 or later
- The DT3+ world, dt3plus.apworld, from the same build of the Randomizer as the mod (Entrance Rando and Boss Rando
  shuffle the mod's own doors and bosses: a world from another build can't be put in the game)

## Installing

1. Install Archipelago. Open the Archipelago Launcher and choose "Install APWorld", then pick dt3plus.apworld (or put
   the file in Archipelago's custom_worlds folder, with the Launcher closed).
2. In DT3+, on the title screen, open Mods and turn the Randomizer on. Restart the game.

## Making a YAML

Use the Archipelago Launcher's "Generate Template Options" to make a template for DT3+ (in the Players\Templates
folder), or the options page. The DT3+ options are the Randomizer's new-game options: Entrance Rando (off, gate_swap,
overworld, chaos), Boss Rando, Instrument Randomization, Chip Randomizer, Shop Equipment (shuffled, as_normal),
Guarantee Early Weapons and Ability Spread (near, normal, far), with DeathLink and the standard ones. For example:

```yaml
name: Player
game: DT3+
DT3+:
  entrance_rando: overworld
  boss_rando: true
  instrument_randomization: true
  chip_randomizer: true
  shop_equipment: shuffled
  guarantee_early_weapons: true
  ability_spread: normal
  death_link: false
```

## Joining a multiworld

1. Open the Archipelago Launcher and start the "DT3+ Client". Connect it to the server (address and slot name).
2. In DT3+, on the title screen, type `ap` (a message says the next new game is an Archipelago game), then start a New
   Game. It starts in Central City with the world's options (its doors and bosses as the multiworld shuffled them), its
   items coming from the multiworld.
3. To carry on later, start the DT3+ Client and connect, then load your save.

The client and the game trade small files in `%LOCALAPPDATA%\DT3PlusArchipelago` (the client's `/bridge` command shows
it). Keep the client open while playing: checks made while it's closed are sent once it reconnects, and items found
meanwhile arrive then.

## DeathLink

With DeathLink on (in the YAML, or the client's `/deathlink` command), a game over in DT3+ is sent to the others, and
their deaths end yours. A game over chosen from the pause menu isn't sent.
