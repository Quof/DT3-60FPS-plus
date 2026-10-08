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

/*
quick restart change (added): U and I held through a Quick Restart don't count until they're let go and pressed again
(the player made after the restart would see them as just pressed: Swap Character/Ability Set by default).
scrQuickRestartInput lets go of the lock.
*/
if (tKey = 85 and global.qrLockU = 1) or (tKey = 73 and global.qrLockI = 1)
{
    return 0;
}

if global.comparisonInputEnabled = 1
{
    return external_call(global.globalKeyIsDown, tKey);
}

/*
key carry change (added): a left/right key held through a screen transition still counts as held until it's let go
(scrKeyCarry explains why). It's read from the keyboard directly, only while the game window has focus. It uses the
same key code as keyboard_check below (argument0), so it's always the same key.
*/
if argument0 >= 8 and argument0 < 256
{
    if global.kbCarry[argument0] = 1
    {
        if keyboard_check_direct(argument0) and window_has_focus() {return 1;}
        global.kbCarry[argument0] = 0;
    }
}

return keyboard_check(argument0);
