/*
input bleed change (added): whether one of the player's buttons (scrController code 5-10, 13, 14) is held. A keyboard key
that's down counts even when keyboard_check doesn't see it: after io_clear() (menus and dialogue call it), a key that's
still held only shows again once Windows repeats it, about half a second later. Used by scrButtonLockHeld/scrButtonLocked.
argument0: scrController code
*/
var tKey;
if scrController(argument0) {return 1}
tKey=""
if argument0=5 {tKey=global.ctrlJump}
else if argument0=6 {tKey=global.ctrlActA}
else if argument0=7 {tKey=global.ctrlActB}
else if argument0=8 {tKey=global.ctrlActC}
else if argument0=9 {tKey=global.ctrlCharSwap}
else if argument0=10 {tKey=global.ctrlAbilSwap}
else if argument0=13 {tKey=global.ctrlDashLeft}
else if argument0=14 {tKey=global.ctrlDashRight}
if string_length(tKey)=0 {return 0}
tKey=ord(tKey)
if tKey>=97 and tKey<=122 {tKey-=32} //lowercase letters: the same key (as scrKeyboardCheck)
if window_has_focus()
{
  if keyboard_check_direct(tKey) {return 1}
}
return 0
