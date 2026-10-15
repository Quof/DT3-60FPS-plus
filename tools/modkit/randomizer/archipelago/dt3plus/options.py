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
    Overworld: those, the doors between two areas and the maps' ways in and out.
    Chaos: every door.
    Every place stays reachable and the game can be finished. The logic is the rooms' own with the doors as shuffled.
    """
    display_name = "Entrance Rando"
    option_off = 0
    option_gate_swap = 1
    option_overworld = 2
    option_chaos = 3
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
    Gate's rooms can only be gone into once its own chip is found (Program Chip 1 opens Gate 1, and so on): going in
    without it turns you back. A location in a gate needs its chip in logic, so no chip is ever behind its own gate.
    Off: you start with all 6.
    """
    display_name = "Chip Randomizer"


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
    shop_equipment: ShopEquipment
    guarantee_early_weapons: GuaranteeEarlyWeapons
    ability_spread: AbilitySpread
    death_link: DeathLink
    start_inventory_from_pool: StartInventoryPool


option_groups = [
    OptionGroup("Randomizer", [EntranceRando, BossRando, InstrumentRandomization, ChipRandomizer, ShopEquipment,
                               GuaranteeEarlyWeapons, AbilitySpread]),
]
