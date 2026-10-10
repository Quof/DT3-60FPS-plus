/*
Marks whatever is held right now as already held in oKeyCodes and oKeyCodesHighFPS, so it doesn't count as a new press.
Used when the gamepad controls change while a button is held (GAMEPAD list), so that button doesn't then act in the
menu on the next tick. Call scrGamepadPoll first so global.gpHeld follows the new controls.
*/
var i,tHeld;
//for(i=1;i<=16;i+=1)
for(i=1;i<=18;i+=1) //options tabs change: + 17/18, the Options tabs (U/L1, I/R1)
{
  tHeld=scrController(i)
  oKeyCodes.kCode[i]=tHeld
  oKeyCodes.kCodePressed[i]=0
  oKeyCodesHighFPS.kCode[i]=tHeld
  oKeyCodesHighFPS.kCodePressed[i]=0
}
