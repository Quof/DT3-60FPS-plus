"""
The Randomizer's logic estimate as access rules (data.LOCATIONS: what each location needs). A location needs, by the
time the story first reaches its area, what the story had given by then: counts of the progression items in
data.PROG_ITEMS, the keys of the first N locked doors in story order (each key opens its own door), and, for the Trial
Master's trials, the three pieces of cursed equipment they make the player wear.
"""
from typing import TYPE_CHECKING, Callable, List, Optional, Sequence, Tuple

from BaseClasses import CollectionState
from worlds.generic.Rules import set_rule

from . import data

if TYPE_CHECKING:
    from . import DT3PlusWorld


def make_rule(player: int, requirement: Sequence[int], trial: bool) -> Optional[Callable[[CollectionState], bool]]:
    counts: List[Tuple[str, int]] = [(name, n) for name, n in zip(data.PROG_ITEMS, requirement[:len(data.PROG_ITEMS)]) if n > 0]
    keys = list(data.DOOR_KEYS[:requirement[len(data.PROG_ITEMS)]])
    needed = keys + (list(data.CURSED_GEAR) if trial else [])
    if not counts and not needed:
        return None

    def rule(state: CollectionState) -> bool:
        for name, n in counts:
            if not state.has(name, player, n):
                return False
        return state.has_all(needed, player)
    return rule


def set_location_rules(world: "DT3PlusWorld") -> None:
    player = world.player
    for name, (_location_id, requirement, trial) in data.LOCATIONS.items():
        rule = make_rule(player, requirement, trial)
        if rule:
            set_rule(world.multiworld.get_location(name, player), rule)
    victory = make_rule(player, data.VICTORY_REQUIREMENT, False)
    if victory:
        set_rule(world.multiworld.get_location(data.VICTORY_LOCATION, player), victory)
