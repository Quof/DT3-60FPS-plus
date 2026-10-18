"""
The DT3+ world's options: the Randomizer's own new-game options (its options window, oRndOptions), as a multiworld has
them. The seed and the spoiler log are the multiworld's own.
"""
from dataclasses import dataclass

from Options import Choice, DeathLink, OptionGroup, PerGameCommonOptions, StartInventoryPool, Toggle


class EntranceRando(Choice):
    """
    Where the doors lead is shuffled (going back through one returns you where you came from).
    Gate Swap: the Access Gates' and Nightmare Gates' doors.
    Area: the doors inside each region of the game (Initiate's Pass, Central City, Begonia, each Access Gate, ...), each
    region's among its own; the ways between regions lead where they do in the game.
    Chaos: every door.
    Every place stays reachable and the game can be finished. The logic is the rooms' own with the doors as shuffled.
    (overworld, the mode area took the place of, is area)
    """
    display_name = "Entrance Rando"
    option_off = 0
    option_gate_swap = 1
    option_area = 2
    option_chaos = 3
    alias_overworld = 2
    default = 0


class BossRando(Toggle):
    """
    Walking up to a boss starts another boss's fight, in that boss's own room (as the boss gallery does), and beating
    it counts as beating the boss whose room it is (a Nightmare Gate's reward is there after it). The CHAOS Warmaster,
    The Executive and Hexor stay where they are. The logic counts each place's new fight.
    """
    display_name = "Boss Rando"


class InstrumentRandomization(Toggle):
    """
    On: the 8 instruments are shuffled into the multiworld, and each Nightmare Gate's reward (left where its boss is
    beaten) is a location that can hold any item. Off: each gate's boss leaves its own instrument. Either way the
    Abomination needs all 8, and the Lost Entrance's barrier one.
    """
    display_name = "Instrument Randomization"


class ChipRandomizer(Toggle):
    """
    On: the 6 Program Chips are shuffled into the multiworld (in the place of six Internetz chests), and each Access
    Gate's portal opens only once its own chip is found (Program Chip 1 opens Gate 1's, and so on), as does the
    Nightmare Gate portal beside it (made of that gate's game; Nightmare Gate E's needs none), wherever Entrance Rando
    has the portal lead. Without the chip the portal can't be used. No chip is ever behind a portal it opens.
    The skill tree's sections open with the chips too (Program Chip 5 opens section 5).
    Off: you start with all 6, and the whole skill tree is open.
    Always off with Entrance Rando chaos.
    """
    display_name = "Chip Randomizer"


class Traps(Choice):
    """
    30 of the items are traps (6 of each), in the place of as many Internetz chests, and this is how long each lasts
    (off: no traps). In your world they look like Weapon Upgrades (or are in a chest, which sparkles as for any item but
    Internetz).
    Darkness Trap: every room is dark (as in Dark Mode).
    Rocketeer Trap: a CHAOS Rocketeer comes after you, and another in every room you go into.
    Teleport Trap: you're taken back to one of the ways into a room you've come in by this run, at random (at once).
    Achilles Trap: any hit kills you (as in Achilles Mode).
    Wind Orb Trap: the Green Warmaster's wind orb, which can't be destroyed, hunts you in every room you go into.
    The traps are items of the multiworld: yours can be in other worlds, and other games' traps in yours.
    (true, from before the times were a choice, is five_minutes)
    """
    display_name = "Traps"
    option_off = 0
    option_five_minutes = 1
    option_two_minutes = 2
    option_ten_minutes = 3
    alias_false = 0
    alias_true = 1
    default = 0
    # (each one's minutes: the world's slot data, trap_minutes)
    minutes = {0: 0, 1: 5, 2: 2, 3: 10}


class SkipTowerDefense(Toggle):
    """
    On: tower defense's six rewards (in Central City - North) are there to pick up from the start, as if you had won
    it, and they're locations that can hold any item (abilities and keys too). Off: they're there once its levels are
    won, and hold nothing the logic needs.
    """
    display_name = "Skip Tower Defense"


class ShopEquipment(Choice):
    """
    Shuffled: the equipment shops' stock is shuffled between the shops. As Normal: each shop sells its own.
    """
    display_name = "Shop Equipment"
    option_as_normal = 0
    option_shuffled = 1
    default = 1


class GuaranteeEarlyWeapons(Toggle):
    """
    A weapon (the first item of the Link, Belmont, Mega Man or Samus ability set, at random) is placed in your own
    world, at a place you can get to from the start.
    """
    display_name = "Guarantee Early Weapons"


class AbilitySpread(Choice):
    """
    How far from the start the multiworld's progression items tend to be in your world.
    Near: they tend to go to the locations that need the fewest items to reach.
    Normal: any location.
    Far: the locations that need the most items to reach come first.
    """
    display_name = "Ability Spread"
    option_near = 0
    option_normal = 1
    option_far = 2
    default = 1


@dataclass
class DT3PlusOptions(PerGameCommonOptions):
    entrance_rando: EntranceRando
    boss_rando: BossRando
    instrument_randomization: InstrumentRandomization
    chip_randomizer: ChipRandomizer
    traps: Traps
    skip_tower_defense: SkipTowerDefense
    shop_equipment: ShopEquipment
    guarantee_early_weapons: GuaranteeEarlyWeapons
    ability_spread: AbilitySpread
    death_link: DeathLink
    start_inventory_from_pool: StartInventoryPool


option_groups = [
    OptionGroup("Randomizer", [EntranceRando, BossRando, InstrumentRandomization, ChipRandomizer, Traps, SkipTowerDefense,
                               ShopEquipment, GuaranteeEarlyWeapons, AbilitySpread]),
]
