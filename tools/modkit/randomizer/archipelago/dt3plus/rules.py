"""
The Randomizer's logic as access rules, one of two ways:
- the room logic itself, the mod's own (erlogic: what a set of items reaches from the start with the doors and the
  bosses as the world shuffled them, or as the game has them), which every world has (the world's logic: ReachLogic).
  It counts the checks in logic too, which a boss fight waits for a share of (the mod's roomlogic\\bosses.txt). What a
  state's items reach is worked out once and kept on the state. A location that needs everything still does
  (data.LOCATIONS' None, and the Nightmare Gates' rewards), as the mod has it.
- without it (world.logic None): data.LOCATIONS, what each location needs with the game's own layout, worked out from
  the game's rooms. A location's requirement is a list of alternatives, any one of which is enough, each a list of
  (item, count); None means every progression item (the world's everything: a place the logic doesn't reach, a boss's
  or a trial's reward). The Trial Master's trials also need the three pieces of cursed equipment they make the player
  wear. A location in an Access Gate needs its Program Chip, which without Chip Randomizer the player has from the start
  (not an item then: left out of what's needed). No share of the checks there: alternatives of items can't count them.
"""
import collections
from typing import TYPE_CHECKING, Callable, Dict, List, Optional, Sequence, Set, Tuple

from BaseClasses import CollectionState
from worlds.generic.Rules import set_rule

from . import data, erlogic

if TYPE_CHECKING:
    from . import DT3PlusWorld


def make_rule(player: int, alternatives: Optional[Sequence[Sequence[Tuple[str, int]]]], trial: bool,
              everything: Sequence[Tuple[str, int]], had: Set[str]) -> Optional[Callable[[CollectionState], bool]]:
    """a location's rule (alternatives: data.LOCATIONS' requirement, None for everything); had: items the player has
    from the start, which aren't items of the world (the Program Chips without Chip Randomizer)"""
    alts: List[List[Tuple[str, int]]] = [list(everything)] if alternatives is None else \
        [[(name, n) for name, n in a if name not in had] for a in alternatives]
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


class ReachLogic:
    """a shuffled layout's logic: the places (the mod's location numbers) a state's items reach, from the start, with the
    doors (part: each door end's new partner, -1 its own) and the bosses (fight: the boss fought at each boss's places,
    None each its own) as shuffled, and Instrument Randomization (ir); had: items the player has from the start, which
    aren't items of the world (the Program Chips without Chip Randomizer). Worked out for a state's items once and kept
    on the state; more items coming are added to it, fewer work it out again"""
    def __init__(self, player: int, f: "erlogic.Flat", part: List[int], fight: Optional[List[int]], ir: bool,
                 had: Sequence[str] = ()) -> None:
        self.player = player
        self.f, self.part, self.fight, self.ir = f, part, fight, ir
        self.nums = sorted(data.REQ_ITEMS)
        self.names = [data.REQ_ITEMS[n] for n in self.nums]
        self.base = [sum(1 for name in names if name in had) for names in self.names]
        self.num_of = {name: num for num, names in data.REQ_ITEMS.items() for name in names}
        self.attr = "dt3plus_reach_%d" % player

    def counts(self, have: Dict[str, int]) -> Tuple[int, ...]:
        """the requirement numbers' counts (in self.nums' order) of items had"""
        return tuple(b + sum(have.get(name, 0) for name in names) for b, names in zip(self.base, self.names))

    def reach(self, counts: Tuple[int, ...]) -> "erlogic.Reach":
        return erlogic.Reach(self.f, self.part, {num: n for num, n in zip(self.nums, counts) if n}, self.fight, self.ir)

    def places(self, state: CollectionState) -> Set[int]:
        have = state.prog_items[self.player]
        counts = tuple(b + sum(have[name] for name in names) for b, names in zip(self.base, self.names))
        kept = getattr(state, self.attr, None)
        if kept is not None:
            old, r = kept
            if old == counts:
                return r.places
            if all(a >= b for a, b in zip(counts, old)):
                for num, a, b in zip(self.nums, counts, old):
                    if a > b:
                        r.add(num, a - b)
                setattr(state, self.attr, (counts, r))
                return r.places
        r = self.reach(counts)
        setattr(state, self.attr, (counts, r))
        return r.places


def world_locations(world: "DT3PlusWorld") -> Dict[str, Tuple[int, Optional[list], bool]]:
    """the world's locations (as data.LOCATIONS has them): with Instrument Randomization, the gates' rewards too; with
    Skip Tower Defense, tower defense's rewards needing what the room logic has them need (data.TOWER_DEFENSE)"""
    locations = dict(data.LOCATIONS)
    if world.ir:
        locations.update({name: (location_id, None, False) for name, location_id in data.GATE_REWARDS.items()})
    if world.skip_td:
        locations.update({name: (locations[name][0], needs, False) for name, needs in data.TOWER_DEFENSE.items()})
    return locations


def chips_had(world: "DT3PlusWorld") -> Set[str]:
    """the Program Chips, had from the start without Chip Randomizer"""
    return set() if world.chips else set(data.CHIPS)


def set_location_rules(world: "DT3PlusWorld") -> None:
    player = world.player
    victory = world.multiworld.get_location(data.VICTORY_LOCATION, player)
    if world.logic is None:
        had = chips_had(world)
        for name, (_location_id, requirement, trial) in world_locations(world).items():
            rule = make_rule(player, requirement, trial, world.everything, had)
            if rule:
                set_rule(world.multiworld.get_location(name, player), rule)
        rule = make_rule(player, None, False, world.everything, had)
        if rule:
            set_rule(victory, rule)
        return

    logic: ReachLogic = world.logic
    everything = dict(world.everything)

    def has_everything(state: CollectionState) -> bool:
        return state.has_all_counts(everything, player)

    # (a place the room logic doesn't reach even with everything: as one that needs everything)
    full = logic.reach(logic.counts(everything)).places
    row_of = {name: i for i, name in enumerate(data.ROW_NAMES)}
    for name, (_location_id, requirement, trial) in world_locations(world).items():
        location = world.multiworld.get_location(name, player)
        row = row_of[name]
        if requirement is None or row not in full:
            set_rule(location, has_everything)
        elif trial:
            cursed = list(data.CURSED_GEAR)
            set_rule(location, lambda state, row=row: state.has_all(cursed, player) and row in logic.places(state))
        else:
            set_rule(location, lambda state, row=row: row in logic.places(state))
    set_rule(victory, has_everything)


def location_depths(world: "DT3PlusWorld", orders: int = 8) -> Dict[str, float]:
    """Ability Spread: how many of the world's progression items each of its locations takes to reach, on average over
    random orders of them (one that needs everything: all of them)"""
    items = [name for name, n in world.everything for _ in range(n)]
    total = len(items)
    locations = world_locations(world)
    names = [name for name in locations if world.multiworld.get_location(name, world.player).item is None]
    depth = dict.fromkeys(names, 0.0)
    row_of = {name: i for i, name in enumerate(data.ROW_NAMES)}
    for _ in range(orders):
        order = list(items)
        world.random.shuffle(order)
        left = [name for name in names if locations[name][1] is not None]
        when = {name: total for name in names}
        have: Dict[str, int] = collections.Counter(dict.fromkeys(chips_had(world), 1))
        reach = world.logic.reach(world.logic.counts({})) if world.logic else None
        for k in range(total + 1):
            rest = []
            for name in left:
                _location_id, requirement, trial = locations[name]
                if reach is not None:
                    got = row_of[name] in reach.places
                else:
                    got = any(all(have[item] >= n for item, n in alt) for alt in requirement)
                if got and trial:
                    got = all(have[item] for item in data.CURSED_GEAR)
                if got:
                    when[name] = k
                else:
                    rest.append(name)
            left = rest
            if k < total:
                have[order[k]] += 1
                if reach is not None:
                    reach.add(world.logic.num_of[order[k]], 1)
        for name in names:
            depth[name] += when[name] / orders
    return depth
