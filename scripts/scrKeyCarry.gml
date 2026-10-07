/*
key carry change (added): left/right held through a screen transition stay held.

GM forgets which keys are held when the room changes, and afterwards only the key pressed last comes back (Windows'
key repeat only repeats that one). So holding right and then pressing jump used to stop the player on the next screen.

Now a left/right key (scrController 1/2: the bound key or the arrow key) that was held when the room changed, and still
is, keeps counting as held (global.kbCarry, read in scrKeyboardCheck) until it's let go. It's read from the keyboard
directly (keyboard_check_direct), and only while the game window has focus.
Keys the game drops on purpose stay dropped: every io_clear() is followed by scrKeyCarryClear(), and a key is only
carried if the game still had it held just before the room changed (global.kbWasHeld).

argument0: 0 = every frame, from oKeyCodesHighFPS's Step: note which of these keys are held
           1 = room start, from oKeyCodesHighFPS's Room Start: carry the ones that were held and still are
           2 = room end, from oKeyCodesHighFPS's Room End: also note a key pressed in the frame the room changes, in case
               the room changed before the Step (only adds: if GM has already forgotten the keys here, the Step's note
               is kept)
*/
var i,tKey;

//not in the first frames, before gm82core has set window_has_focus() (global.gpFrames: scrGamepadPoll) and before
//oGame has set up scrKeyboardCheck (rIntro)
if argument0!=0 and global.gpFrames<=2 {exit}

for(i=0;i<4;i+=1)
{
  if i=0 {tKey=ord(global.ctrlLeft)}
  else if i=1 {tKey=vk_left}
  else if i=2 {tKey=ord(global.ctrlRight)}
  else {tKey=vk_right}
  if tKey>=8 and tKey<256 //(0-7 are mouse buttons for keyboard_check_direct)
  {
    if argument0=0 {global.kbWasHeld[tKey]=scrKeyboardCheck(tKey)}
    else if argument0=2 {if scrKeyboardCheck(tKey) {global.kbWasHeld[tKey]=1}}
    else if global.kbWasHeld[tKey]=1
    {
      if window_has_focus() and keyboard_check_direct(tKey) {global.kbCarry[tKey]=1}
    }
  }
}
