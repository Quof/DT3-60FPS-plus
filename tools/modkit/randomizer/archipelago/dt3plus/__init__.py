"""
DT3+ for Archipelago: the DT3+ Randomizer mod's game as an Archipelago world. The locations, the item pool and the
logic are the Randomizer's own (data.py, made from the game by tools/modkit/randomizer/rndgen.py --ap); the game talks
to the server through the DT3+ Client (client.py), which trades small text files with it.
"""
from typing import Any, Dict, List

from BaseClasses import Item, ItemClassification, Location, Region, Tutorial
from worlds.AutoWorld import WebWorld, World
from worlds.LauncherComponents import Component, Type, components, launch_subprocess

from . import data
from .options import DT3PlusOptions
from .rules import set_location_rules


def launch_client(*args: str) -> None:
    from .client import launch
    launch_subprocess(launch, name="DT3PlusClient", args=args)


components.append(Component("DT3+ Client", func=launch_client, component_type=Type.CLIENT, game_name=data.GAME,
                            supports_uri=True, description="Connects the DT3+ Randomizer mod to a multiworld."))


class DT3PlusItem(Item):
    game = data.GAME


class DT3PlusLocation(Location):
    game = data.GAME


class DT3PlusWeb(WebWorld):
    theme = "partyTime"
    tutorials = [Tutorial("Multiworld Setup Guide",
                          "A guide to playing DT3+ in an Archipelago multiworld.",
                          "English", "setup_en.md", "setup/en", ["DT3+"])]


class DT3PlusWorld(World):
    """
    DT3+ is a fan-made platformer across many games' worlds. In the Randomizer, a new game starts in the open endgame
    world with nothing but walking: every collectible, movement ability, ability set and key is somewhere in the
    multiworld. Get the 8 instruments and beat the Abomination, then defeat the CHAOS Warmaster.
    """
    game = data.GAME
    web = DT3PlusWeb()
    options_dataclass = DT3PlusOptions
    options: DT3PlusOptions
    topology_present = False

    item_name_to_id = {name: item[0] for name, item in data.ITEMS.items()}
    location_name_to_id = {name: loc[0] for name, loc in data.LOCATIONS.items()}
    item_name_groups = {
        "Keys": set(data.DOOR_KEYS),
        "Movement": {"Jump", "Dash", "Air Dash", "Double Jump", "Progressive High Jump Boots"},
        "Ability Sets": {name for name in data.PROG_ITEMS[5:12]},
        "Cursed Equipment": set(data.CURSED_GEAR),
    }

    def create_item(self, name: str) -> DT3PlusItem:
        item_id, classification, _count = data.ITEMS[name]
        return DT3PlusItem(name, ItemClassification(classification), item_id, self.player)

    def get_filler_item_name(self) -> str:
        return data.FILLER

    def create_regions(self) -> None:
        # every location is in one region: what each needs is its rule (rules.py)
        menu = Region("Menu", self.player, self.multiworld)
        menu.add_locations({name: loc[0] for name, loc in data.LOCATIONS.items()}, DT3PlusLocation)
        victory = DT3PlusLocation(self.player, data.VICTORY_LOCATION, None, menu)
        victory.place_locked_item(DT3PlusItem("Victory", ItemClassification.progression, None, self.player))
        menu.locations.append(victory)
        self.multiworld.regions.append(menu)

    def create_items(self) -> None:
        pool: List[DT3PlusItem] = []
        for name, (_item_id, _classification, count) in data.ITEMS.items():
            pool += [self.create_item(name) for _ in range(count)]
        unfilled = len(self.multiworld.get_unfilled_locations(self.player))
        while len(pool) < unfilled:
            pool.append(self.create_item(self.get_filler_item_name()))
        self.multiworld.itempool += pool

    def set_rules(self) -> None:
        set_location_rules(self)
        self.multiworld.completion_condition[self.player] = lambda state: state.has("Victory", self.player)

    def fill_slot_data(self) -> Dict[str, Any]:
        return {
            "data_version": data.VERSION,
            "death_link": bool(self.options.death_link.value),
            "shop_seed": self.random.randint(0, 999999),
        }
