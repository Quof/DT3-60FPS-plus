"""
DT3+ for Archipelago: the DT3+ Randomizer mod's game as an Archipelago world. The locations, the item pool and the
logic are the Randomizer's own (data.py, made from the game by tools/modkit/randomizer/rndgen.py; the logic, the room
logic itself, with Entrance Rando's doors and Boss Rando's bosses as shuffled: erlogic.py and erdata.json); the game talks to the
server through the DT3+ Client (client.py), which trades small text files with it. The doors and bosses the world
shuffles go to the game in its slot data, through the client.
"""
import json
import logging
import pkgutil
from typing import Any, Dict, List, Optional, TextIO

from BaseClasses import Item, ItemClassification, Location, Region, Tutorial
from worlds.AutoWorld import WebWorld, World
from worlds.LauncherComponents import Component, Type, components, launch_subprocess

from . import data, erlogic
from .options import AbilitySpread, DT3PlusOptions, option_groups
from .rules import ReachLogic, location_depths, set_location_rules


def launch_client(*args: str) -> None:
    from .client import launch
    launch_subprocess(launch, name="DT3PlusClient", args=args)


components.append(Component("DT3+ Client", func=launch_client, component_type=Type.CLIENT, game_name=data.GAME,
                            supports_uri=True, description="Connects the DT3+ Randomizer mod to a multiworld."))

# the room logic's tables (erdata.json), read once
_tables: Optional[erlogic.Flat] = None


def tables() -> erlogic.Flat:
    global _tables
    if _tables is None:
        _tables = erlogic.load(json.loads(pkgutil.get_data(__name__, "erdata.json").decode("utf-8")))
    return _tables


# how many tries a shuffle of the doors gets (each one kept only if with everything it reaches every place the game's own
# doors do, and the goal: erlogic.everything_ok, as the mod's new game does)
SHUFFLE_TRIES = 500
ENTRANCE_MODE_BITS = (0, 1, 2, 4)  # the option's Off, Gate Swap, Area, Chaos: erlogic's mode bits
# Ability Spread Near: how much a location's place in the order of how many items it takes counts against chance
# (fill_hook). With 0.3 a playthrough has about 6 spheres (Normal about 11, Far about 15)
SPREAD_NEAR_WEIGHT = 0.3


class DT3PlusItem(Item):
    game = data.GAME


class DT3PlusLocation(Location):
    game = data.GAME


class DT3PlusWeb(WebWorld):
    theme = "partyTime"
    option_groups = option_groups
    tutorials = [Tutorial("Multiworld Setup Guide",
                          "A guide to playing DT3+ in an Archipelago multiworld.",
                          "English", "setup_en.md", "setup/en", ["DT3+"])]


class DT3PlusWorld(World):
    """
    DT3+ is a fan-made platformer across many games' worlds. In the Randomizer, a new game starts in Central City in the
    open endgame world, able to walk and jump: every collectible, the other movement abilities, the ability sets and the
    keys are somewhere in the multiworld. Get the 8 instruments and beat the Abomination, then defeat the CHAOS
    Warmaster.
    """
    game = data.GAME
    web = DT3PlusWeb()
    options_dataclass = DT3PlusOptions
    options: DT3PlusOptions
    topology_present = False

    item_name_to_id = {**{name: item[0] for name, item in data.ITEMS.items()}, **data.INSTRUMENTS, **data.CHIPS,
                       **data.NIGHTMARE, **data.TRAPS}
    location_name_to_id = {**{name: loc[0] for name, loc in data.LOCATIONS.items()}, **data.GATE_REWARDS}
    item_name_groups = {
        "Keys": set(data.DOOR_KEYS),
        "Movement": {"Dash", "Air Dash", "Double Jump", "Progressive High Jump Boots"},
        "Ability Sets": set(data.SET_ITEMS),
        "Cursed Equipment": set(data.CURSED_GEAR),
        "Instruments": set(data.INSTRUMENTS),
        "Program Chips": set(data.CHIPS),
        "Nightmare Abilities": set(data.NIGHTMARE),
        "Traps": set(data.TRAPS),
    }

    ir: bool
    chips: bool
    skip_td: bool
    part: Optional[List[int]]
    fight: Optional[List[int]]
    logic: Optional[ReachLogic]
    everything: List[Any]

    def generate_early(self) -> None:
        options = self.options
        self.ir = bool(options.instrument_randomization.value)
        # Chip Randomizer: the Program Chips are items (each Access Gate's portal, and the Nightmare Gate portal beside
        # it, takes its gate's chip, wherever Entrance Rando has the portal lead); off, they're had from the start (rules:
        # the logic counts them as had). Not with Entrance Rando chaos: off there, as the mod's options window has it
        if options.entrance_rando.value == options.entrance_rando.option_chaos and options.chip_randomizer.value:
            logging.info("DT3+ (%s): Chip Randomizer is off with Entrance Rando chaos" % self.player_name)
            options.chip_randomizer.value = 0
        self.chips = bool(options.chip_randomizer.value)
        # Skip Tower Defense: tower defense's rewards there from the start, their logic the room logic's (rules:
        # world_locations, data.TOWER_DEFENSE); off, they need everything
        self.skip_td = bool(options.skip_tower_defense.value)
        # every progression item (the win, and what a place the logic doesn't reach needs)
        self.everything = list(data.EVERYTHING) + ([(name, 1) for name in data.INSTRUMENTS] if self.ir else []) + \
            ([(name, 1) for name in data.CHIPS] if self.chips else [])
        # Entrance Rando: each door end's new partner (-1: its own); Boss Rando: the boss fought at each boss's place.
        # The logic is the room logic's with them (rules.ReachLogic), in every world, as the mod places its own seeds:
        # a boss fight also waits for the share of the checks in logic it takes (the mod's roomlogic\bosses.txt, "@ N%"),
        # which only the room logic's reach counts
        self.part, self.fight, self.logic = None, None, None
        mode_bit = ENTRANCE_MODE_BITS[options.entrance_rando.value]
        f = tables()
        if mode_bit or options.boss_rando.value or self.ir:
            for _ in range(SHUFFLE_TRIES):
                part = erlogic.shuffle(f, mode_bit, self.random) if mode_bit else [-1] * len(f.ends)
                if part is None:
                    continue
                fight = erlogic.br_shuffle(f, self.random) if options.boss_rando.value else None
                if mode_bit and not erlogic.everything_ok(f, part, f.hv, f.base_places, fight, self.ir):
                    continue
                break
            else:
                raise Exception("DT3+ (%s): no shuffle of the doors worked out in %d tries"
                                % (self.player_name, SHUFFLE_TRIES))
            self.part, self.fight = part, fight
        else:
            part, fight = [-1] * len(f.ends), None
        self.logic = ReachLogic(self.player, f, part, fight, self.ir, () if self.chips else data.CHIPS)
        # Guarantee Early Weapons: a weapon set's first item among this world's first places
        if options.guarantee_early_weapons.value:
            self.multiworld.local_early_items[self.player][self.random.choice(data.WEAPON_SETS)] = 1

    def create_item(self, name: str) -> DT3PlusItem:
        if name in data.INSTRUMENTS:
            return DT3PlusItem(name, ItemClassification.progression, data.INSTRUMENTS[name], self.player)
        if name in data.CHIPS:
            return DT3PlusItem(name, ItemClassification.progression, data.CHIPS[name], self.player)
        if name in data.NIGHTMARE:
            return DT3PlusItem(name, ItemClassification.useful, data.NIGHTMARE[name], self.player)
        if name in data.TRAPS:
            return DT3PlusItem(name, ItemClassification.trap, data.TRAPS[name], self.player)
        item_id, classification, _count = data.ITEMS[name]
        return DT3PlusItem(name, ItemClassification(classification), item_id, self.player)

    def get_filler_item_name(self) -> str:
        return data.FILLER

    def create_regions(self) -> None:
        # every location is in one region: what each needs is its rule (rules.py)
        menu = Region("Menu", self.player, self.multiworld)
        locations = {name: loc[0] for name, loc in data.LOCATIONS.items()}
        if self.ir:
            locations.update(data.GATE_REWARDS)
        menu.add_locations(locations, DT3PlusLocation)
        victory = DT3PlusLocation(self.player, data.VICTORY_LOCATION, None, menu)
        victory.place_locked_item(DT3PlusItem("Victory", ItemClassification.progression, None, self.player))
        menu.locations.append(victory)
        self.multiworld.regions.append(menu)

    def create_items(self) -> None:
        pool: List[DT3PlusItem] = []
        counts = {name: count for name, (_item_id, _classification, count) in data.ITEMS.items()}
        # (Chip Randomizer: the chips in the place of the Internetz items the mod puts them in place of)
        if self.chips:
            for name in data.CHIP_MONEY:
                counts[name] -= 1
        # (Traps: the trap items in the place of the Internetz items the mod puts them in place of: other ones than the
        # chips')
        if self.options.traps.value:
            for name in data.TRAP_MONEY:
                counts[name] -= 1
        for name, count in counts.items():
            pool += [self.create_item(name) for _ in range(count)]
        if self.ir:
            pool += [self.create_item(name) for name in data.INSTRUMENTS]
        if self.chips:
            pool += [self.create_item(name) for name in data.CHIPS]
        if self.options.traps.value:
            pool += [self.create_item(name) for name in data.TRAP_ITEMS]
        # the Nightmare abilities: each at one of the story's ability pickups the logic reaches (STORY_LOCATIONS), at
        # random, as the mod's own new game puts them (rndGenerate), so not in the pool
        for location_name, name in zip(self.random.sample(data.STORY_LOCATIONS, len(data.NIGHTMARE)), data.NIGHTMARE):
            self.get_location(location_name).place_locked_item(self.create_item(name))
        unfilled = len(self.multiworld.get_unfilled_locations(self.player))
        while len(pool) < unfilled:
            pool.append(self.create_item(self.get_filler_item_name()))
        self.multiworld.itempool += pool

    def set_rules(self) -> None:
        set_location_rules(self)
        self.multiworld.completion_condition[self.player] = lambda state: state.has("Victory", self.player)

    def fill_hook(self, progitempool, usefulitempool, filleritempool, fill_locations) -> None:
        # Ability Spread: the fill puts a progression item in the first location in this list it can, so this world's
        # locations, in their places in it, are put in order of how many items they take to reach: the most first
        # (Far), or the fewest first with some chance in it (Near: each one's place in that order weighed with a random
        # number, SPREAD_NEAR_WEIGHT of the one to the other)
        spread = self.options.ability_spread.value
        if spread == AbilitySpread.option_normal:
            return
        at = [i for i, location in enumerate(fill_locations) if location.player == self.player]
        if not at:
            return
        depth = location_depths(self)
        mine = sorted((fill_locations[i] for i in at), key=lambda location: depth.get(location.name, 0.0),
                      reverse=spread == AbilitySpread.option_far)
        if spread == AbilitySpread.option_near:
            n = len(mine)
            key = {location.name: SPREAD_NEAR_WEIGHT * k / n + (1 - SPREAD_NEAR_WEIGHT) * self.random.random()
                   for k, location in enumerate(mine)}
            mine.sort(key=lambda location: key[location.name])
        for i, location in zip(at, mine):
            fill_locations[i] = location

    def fill_slot_data(self) -> Dict[str, Any]:
        # (the doors and bosses as the mod's strings: rndERString, four digits an end, its partner+1; rndBRString(0), two
        # digits a boss, the boss fought at its place)
        options = self.options
        return {
            "data_version": data.VERSION,
            "death_link": bool(options.death_link.value),
            "shop_seed": self.random.randint(0, 999999),
            "shop_shuffle": int(options.shop_equipment.value),
            "entrance_rando": int(options.entrance_rando.value),
            "er_hash": data.ER_HASH,
            "er_parts": "".join("%04d" % (p + 1) for p in self.part) if options.entrance_rando.value else "",
            "boss_rando": int(options.boss_rando.value),
            "br_fight": "".join("%02d" % b for b in self.fight) if self.fight else "",
            "br_types": data.BOSS_TYPES,
            "instrument_randomization": int(self.ir),
            "chip_randomizer": int(self.chips),
            # (the chips are the gates' portals', as this world's logic has them: the mod goes by it, rndPortalChip)
            "chip_portals": 1,
            # (Skip Tower Defense: the mod has tower defense won from the start, its rewards there: rndSkipTDApply)
            "skip_tower_defense": int(self.skip_td),
            "traps": int(options.traps.value > 0),
            # (how long this world's trap items last: the client gives the mod it, trapmins)
            "trap_minutes": options.traps.minutes[options.traps.value],
        }

    def write_spoiler(self, spoiler_handle: TextIO) -> None:
        if self.fight is None and not self.options.entrance_rando.value:
            return
        name = self.multiworld.get_player_name(self.player)
        if self.fight is not None:
            spoiler_handle.write("\n\nDT3+ Boss Rando (%s): each boss's place, and the boss fought there\n" % name)
            for place, boss in enumerate(self.fight):
                if tables().boss_shuf[place]:
                    spoiler_handle.write("    %s's place (%s): %s\n"
                                         % (data.BOSS_NAMES[place], data.BOSS_PLACES[place], data.BOSS_NAMES[boss]))
        if self.options.entrance_rando.value:
            f = tables()
            spoiler_handle.write("\n\nDT3+ Entrance Rando, %s (%s): each pair of exits leads to each other\n"
                                 % (self.options.entrance_rando.current_option_name, name))
            for end, partner in enumerate(self.part):
                if partner > end:
                    spoiler_handle.write("    %s  <->  %s\n" % (f.end_names[end], f.end_names[partner]))
            # (a map's room's other ways back to the map that come out where a shuffled end's exit does: they lead where
            # it now does)
            fol = [(x, end, xname) for x, end, xname in f.follow_list if self.part[end] >= 0]
            if fol:
                spoiler_handle.write("  Exits that lead where a door's exit above does:\n")
                for x, end, xname in fol:
                    spoiler_handle.write("    %s  ->  as %s\n" % (xname, f.end_names[end]))
