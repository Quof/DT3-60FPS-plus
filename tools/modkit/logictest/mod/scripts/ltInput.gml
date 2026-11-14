//Logic Test: the run's buttons this frame (oKeyCodesHighFPS's Begin Step, right after scrGamepadPoll has read the pad):
//they're what the gamepad holds (global.gpHeld, which scrController reads with Gamepad Input on: the run turns it on),
//so every Step event sees them as it would a real pad's. The run's game speed too (oGame's Begin Step uses it next frame)
var i;
global.optGamePad=1
for(i=1;i<=16;i+=1) {global.gpHeld[i]=global.ltHeld[i]}
global.modSpeedMul=global.ltSpeed
