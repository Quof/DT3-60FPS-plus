/*
Call this once during game startup, before scrController is used.

Set argument0 to:
    1 = enable background/global keyboard input
    0 = use normal GameMaker keyboard input

GlobalKeyboard.dll must be beside the running game executable.
*/

global.comparisonInputEnabled = argument0;
global.globalKeyIsDown = -1;

if global.comparisonInputEnabled = 1
{
    global.globalKeyIsDown = external_define(
        "GlobalKeyboard.dll",
        "key_is_down",
        dll_cdecl,
        ty_real,
        1,
        ty_real
    );
}
