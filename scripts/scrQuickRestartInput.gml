/*
quick restart change (added): Quick Restart's buttons, which can't be changed: U + I on the keyboard (the keys
themselves, whatever Swap Character/Swap Ability Set are set to), L1 + R1 on a gamepad (scrGamepadPoll). Called every
frame by oKeyCodesHighFPS. global.qrPressed is 1 on the frame both buttons are held after not being, so holding them
doesn't restart again; oPlayer1 restarts with it while the pause menu is up.
*/
var tHeld;
//U/I held through a Quick Restart count again once they're let go (scrKeyboardCheck; L1/R1: scrGamepadPoll)
if global.qrLockU=1 {if !keyboard_check_direct(ord("U")) {global.qrLockU=0}}
if global.qrLockI=1 {if !keyboard_check_direct(ord("I")) {global.qrLockI=0}}
tHeld=(scrKeyboardCheck(ord("U")) and scrKeyboardCheck(ord("I")))
if global.optGamePad=1 and global.gpQuickRestart=1 {tHeld=1}
global.qrPressed=(tHeld and global.qrHeld=0)
global.qrHeld=tHeld
