/*
Comparison-aware keyboard check.

argument0: GameMaker key code.

Returns 1 while the key is held.

Normal mode:
    Uses GameMaker's keyboard_check() exactly as before.

Comparison mode:
    Uses GlobalKeyboard.dll so this game can read the physical keyboard
    while another window has focus.
*/

var tKey;
tKey = argument0;

/*
Windows virtual-key codes for letters use uppercase A-Z (65-90).
GameMaker control strings may contain lowercase letters, so normalize them.
*/
if tKey >= 97 and tKey <= 122
{
    tKey -= 32;
}

if global.comparisonInputEnabled = 1
{
    return external_call(global.globalKeyIsDown, tKey);
}

return keyboard_check(argument0);
