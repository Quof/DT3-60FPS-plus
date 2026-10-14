"""
The Randomizer's logic as access rules (data.LOCATIONS: what each location needs, worked out from the game's rooms).
A location's requirement is a list of alternatives, any one of which is enough, each a list of (item, count); None
means every progression item (data.EVERYTHING: a place the logic doesn't reach, a boss's or a trial's reward). The
Trial Master's trials also need the three pieces of cursed equipment they make the player wear.
"""
from typing import TYPE_CHECKING, Callable, List, Optional, Sequence, Tuple

from BaseClasses import CollectionState
from worlds.generic.Rules import set_rule

from . import data

if TYPE_CHECKING:
    from . import DT3PlusWorld


def make_rule(player: int, alternatives: Optional[Sequence[Sequence[Tuple[str, int]]]],
              trial: bool) -> Optional[Callable[[CollectionState], bool]]:
    alts: List[List[Tuple[str, int]]] = [list(data.EVERYTHING)] if alternatives is None else [list(a) for a in alternatives]
    cursed = list(data.CURSED_GEAR) if trial else []
    if any(not alt for alt in alts) and not cursed:
        return None

    def rule(state: CollectionState) -> bool:
        if cursed and not state.has_all(cursed, player):
            return False
        for alt in alts:
            if all(state.has(name, player, n) for name, n in alt):
                return True
        return False
    return rule


def set_location_rules(world: "DT3PlusWorld") -> None:
    player = world.player
    for name, (_location_id, requirement, trial) in data.LOCATIONS.items():
        rule = make_rule(player, requirement, trial)
        if rule:
            set_rule(world.multiworld.get_location(name, player), rule)
    victory = make_rule(player, None, False)
    if victory:
        set_rule(world.multiworld.get_location(data.VICTORY_LOCATION, player), victory)
