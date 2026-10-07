/*
socd change (added): whether direction argument0 is held (1 left, 2 right, 3 up, 4 down): its key or the arrow key, or
the gamepad with Gamepad Input on. This is what scrController returned for these before SOCD handling; scrSOCD uses it
for both directions of a pair.
*/
if argument0=1 {if scrKeyboardCheck(ord(global.ctrlLeft)) or scrKeyboardCheck(vk_left) {return 1}} //Move left
else if argument0=2 {if scrKeyboardCheck(ord(global.ctrlRight)) or scrKeyboardCheck(vk_right) {return 1}} //Move right
else if argument0=3 {if scrKeyboardCheck(ord(global.ctrlUp)) or scrKeyboardCheck(vk_up) {return 1}} //Look up
else if argument0=4 {if scrKeyboardCheck(ord(global.ctrlDown)) or scrKeyboardCheck(vk_down) {return 1}} //Duck
if global.optGamePad=1 {return global.gpHeld[argument0]}
return 0
