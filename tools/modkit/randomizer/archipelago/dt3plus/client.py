"""
The DT3+ Client: connects the DT3+ Randomizer mod to an Archipelago server. The game (GameMaker 8) can't open a
connection itself, so the two trade small text files in a folder both know: %LOCALAPPDATA%\\DT3PlusArchipelago.
Every file starts with a line "seed|<seed name>|<slot name>", so neither side reads another game's files.

Client to game:
  session.txt    on connecting: the seed line, deathlink|0/1, then the world's options from its slot data: shopseed|
                 <number>, shops|0/1 (the shops' stock shuffled), er|<Entrance Rando: 0 off, 1 Gate Swap, 2 Area, 3
                 Chaos>, erhash|<the room logic data's hash>, erpart|<the doors' shuffle, the mod's rndERString>, br|0/1
                 (Boss Rando), brfight|<its shuffle, rndBRString(0)>, brtypes|<the bosses' types, rndBRString(1)>, ir|0/1
                 (Instrument Randomization), chips|0/1 (Chip Randomizer), chipportals|0/1 (1: the gates' portals take
                 the chips; 0: a world made before that, whose chips the gates' rooms took), trapmins|<how long its
                 trap items last, minutes: 5 from a world before that was a choice>; then version|<data version>,
                 connected|0/1
  locations.txt  what each of this world's locations holds (scouted): <location id>|<own 0/1>|<item id, 0 if not
                 own>|<item name>|<player it's for>|<flags>
  items.txt      every item received, in order: <item id>|<from this world 0/1>|<sender's name>
  death_in.txt   a DeathLink death: <time in ms>|<cause>
Game to client:
  checks.txt     the location ids the player has checked, a line each (the game adds to it)
  goal.txt       the player has won
  death_out.txt  the player died: <how many deaths so far>
"""
import asyncio
import os
import time
import typing

import Utils
from CommonClient import (ClientCommandProcessor, CommonContext, get_base_parser, gui_enabled, handle_url_arg, logger,
                          server_loop)
from NetUtils import ClientStatus

from . import data

BRIDGE_DIR = os.path.join(os.environ.get("LOCALAPPDATA") or os.path.expanduser("~"), "DT3PlusArchipelago")


def clean(text: typing.Any) -> str:
    """text as the game's files can have it: no separators or line breaks, plain ASCII (GameMaker 8's fonts)"""
    text = str(text).replace("|", "/").replace("\r", " ").replace("\n", " ")
    return text.encode("ascii", "replace").decode("ascii")


def write_file(name: str, lines: typing.List[str]) -> None:
    """writes a bridge file whole: a temporary file renamed over it, so the game never reads half of one"""
    path = os.path.join(BRIDGE_DIR, name)
    tmp = path + ".tmp"
    with open(tmp, "w", encoding="ascii", errors="replace", newline="\r\n") as f:
        f.write("\n".join(lines) + "\n")
    for _ in range(40):
        try:
            os.replace(tmp, path)
            return
        except PermissionError:  # the game has the file open this moment
            time.sleep(0.05)
    logger.warning("Couldn't write %s: something is holding it open.", path)


def read_lines(name: str) -> typing.List[str]:
    try:
        with open(os.path.join(BRIDGE_DIR, name), encoding="ascii", errors="replace") as f:
            return [line.strip() for line in f]
    except OSError:
        return []


class DT3PlusCommandProcessor(ClientCommandProcessor):
    def _cmd_bridge(self) -> bool:
        """Shows the folder where the client and the game trade files."""
        self.output(BRIDGE_DIR)
        return True

    def _cmd_deathlink(self) -> bool:
        """Turns DeathLink on or off for this session."""
        if isinstance(self.ctx, DT3PlusContext):
            self.ctx.death_link = not self.ctx.death_link
            Utils.async_start(self.ctx.update_death_link(self.ctx.death_link))
            self.ctx.write_session()
            self.output("DeathLink is now " + ("on." if self.ctx.death_link else "off."))
        return True


class DT3PlusContext(CommonContext):
    game = data.GAME
    items_handling = 0b111  # other worlds' items, this world's own, and the starting inventory
    command_processor = DT3PlusCommandProcessor

    def __init__(self, server_address: typing.Optional[str], password: typing.Optional[str]) -> None:
        super().__init__(server_address, password)
        os.makedirs(BRIDGE_DIR, exist_ok=True)
        self.slot_data: typing.Dict[str, typing.Any] = {}
        self.death_link = False
        self.deaths_out_seen: typing.Optional[int] = None
        self.room_seed_name = ""  # the multiworld's seed name, from the server's RoomInfo

    async def server_auth(self, password_requested: bool = False) -> None:
        if password_requested and not self.password:
            await super().server_auth(password_requested)
        await self.get_username()
        await self.send_connect()

    def make_gui(self):
        ui = super().make_gui()
        ui.base_title = "DT3+ Client"
        return ui

    # ---------------- the files the game reads
    def seed_line(self) -> str:
        # the slot name connected with (not its alias, which can change mid-game)
        return "seed|%s|%s" % (clean(self.room_seed_name), clean(self.auth or ""))

    def write_session(self, connected: bool = True) -> None:
        # (a seed from before the world had its options: the shops shuffled, nothing else)
        slot = self.slot_data
        write_file("session.txt", [
            self.seed_line(),
            "deathlink|%d" % int(self.death_link),
            "shopseed|%d" % int(slot.get("shop_seed", 0)),
            "shops|%d" % int(slot.get("shop_shuffle", 1)),
            "er|%d" % int(slot.get("entrance_rando", 0)),
            "erhash|%s" % clean(slot.get("er_hash", "")),
            "erpart|%s" % clean(slot.get("er_parts", "")),
            "br|%d" % int(slot.get("boss_rando", 0)),
            "brfight|%s" % clean(slot.get("br_fight", "")),
            "brtypes|%s" % clean(slot.get("br_types", "")),
            "ir|%d" % int(slot.get("instrument_randomization", 0)),
            "chips|%d" % int(slot.get("chip_randomizer", 0)),
            "chipportals|%d" % int(slot.get("chip_portals", 0)),
            "trapmins|%d" % int(slot.get("trap_minutes", 5) or 5),
            "version|%d" % int(slot.get("data_version", 0)),
            "connected|%d" % int(connected),
        ])

    def write_items(self) -> None:
        lines = [self.seed_line()]
        for item in self.items_received:
            sender = self.player_names.get(item.player, "Archipelago") if item.player else "Archipelago"
            lines.append("%d|%d|%s" % (item.item, int(item.player == self.slot), clean(sender)))
        write_file("items.txt", lines)

    def write_locations(self) -> None:
        lines = [self.seed_line()]
        for location, item in sorted(self.locations_info.items()):
            own = item.player == self.slot
            name = self.item_names.lookup_in_slot(item.item, item.player)
            lines.append("%d|%d|%d|%s|%s|%d" % (location, int(own), item.item if own else 0, clean(name),
                                                clean(self.player_names.get(item.player, "?")), item.flags))
        write_file("locations.txt", lines)

    # ---------------- the server
    def on_package(self, cmd: str, args: typing.Dict[str, typing.Any]) -> None:
        if cmd == "RoomInfo":
            self.room_seed_name = str(args.get("seed_name", ""))
        elif cmd == "Connected":
            self.slot_data = args.get("slot_data") or {}
            if self.slot_data.get("data_version", data.VERSION) != data.VERSION:
                logger.warning("This seed was made with another version of the DT3+ world than this client's.")
            self.death_link = bool(self.slot_data.get("death_link", False))
            Utils.async_start(self.update_death_link(self.death_link))
            self.deaths_out_seen = None
            self.write_session()
            self.write_items()
            locations = sorted(self.missing_locations | self.checked_locations)
            Utils.async_start(self.send_msgs([{"cmd": "LocationScouts", "locations": locations, "create_as_hint": 0}]))
            logger.info("Connected. Start a new Archipelago game in DT3+ (type ap on the title screen), or load one.")
        elif cmd == "LocationInfo":
            self.write_locations()
        elif cmd == "ReceivedItems":
            self.write_items()

    def on_deathlink(self, data_: typing.Dict[str, typing.Any]) -> None:
        super().on_deathlink(data_)
        cause = data_.get("cause") or "%s died." % data_.get("source", "Someone")
        write_file("death_in.txt", [self.seed_line(), "%d|%s" % (int(time.time() * 1000), clean(cause))])

    async def shutdown(self) -> None:
        if self.slot:
            self.write_session(connected=False)
        await super().shutdown()


async def game_watcher(ctx: DT3PlusContext) -> None:
    """what the game writes: its checks, its win and its deaths, sent to the server"""
    while not ctx.exit_event.is_set():
        try:
            await asyncio.wait_for(ctx.exit_event.wait(), 0.5)
        except asyncio.TimeoutError:
            pass
        if not ctx.server or not ctx.slot:
            continue
        seed = ctx.seed_line()

        lines = read_lines("checks.txt")
        if lines and lines[0] == seed:
            checks = {int(line) for line in lines[1:] if line.isdigit()}
            if checks - ctx.checked_locations:
                await ctx.check_locations(checks)

        lines = read_lines("goal.txt")
        if lines and lines[0] == seed and not ctx.finished_game:
            await ctx.send_msgs([{"cmd": "StatusUpdate", "status": ClientStatus.CLIENT_GOAL}])
            ctx.finished_game = True

        lines = read_lines("death_out.txt")
        if len(lines) >= 2 and lines[0] == seed and lines[1].isdigit():
            deaths = int(lines[1])
            if ctx.deaths_out_seen is not None and deaths > ctx.deaths_out_seen and ctx.death_link:
                await ctx.send_death("%s died in DT3+." % ctx.player_names.get(ctx.slot, "A player"))
            ctx.deaths_out_seen = deaths


def launch(*launch_args: str) -> None:
    async def main(args) -> None:
        ctx = DT3PlusContext(args.connect, args.password)
        ctx.auth = args.name
        ctx.server_task = asyncio.create_task(server_loop(ctx), name="server loop")
        watcher = asyncio.create_task(game_watcher(ctx), name="DT3PlusGameWatcher")
        if gui_enabled:
            ctx.run_gui()
        ctx.run_cli()
        await ctx.exit_event.wait()
        ctx.server_address = None
        await ctx.shutdown()
        await watcher

    parser = get_base_parser(description="DT3+ Client: connects the DT3+ Randomizer mod to an Archipelago server.")
    parser.add_argument("--name", default=None, help="Slot name to connect as.")
    parser.add_argument("url", nargs="?", help="Archipelago connection url")
    args = parser.parse_args(launch_args)
    args = handle_url_arg(args, parser=parser)
    Utils.init_logging("DT3PlusClient", exception_logger="Client")
    import colorama
    colorama.just_fix_windows_console()
    asyncio.run(main(args))
    colorama.deinit()
