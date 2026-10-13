from dataclasses import dataclass

from Options import DeathLink, PerGameCommonOptions, StartInventoryPool


@dataclass
class DT3PlusOptions(PerGameCommonOptions):
    death_link: DeathLink
    start_inventory_from_pool: StartInventoryPool
