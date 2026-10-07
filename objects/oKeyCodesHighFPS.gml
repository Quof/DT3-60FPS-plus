#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//for(i=1;i<=14;i+=1)
for(i=1;i<=16;i+=1) //gamepad change: + 15/16, menu Confirm/Back (scrController)
{
  kCode[i]=0
  kCodePressed[i]=0
}
scrGamepadInit() //gamepad change (added): gamepad support (Game Maker 8.2 joystick extension), read every frame in the Begin Step
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//for(i=1;i<=14;i+=1)
for(i=1;i<=16;i+=1) //gamepad change: + 15/16, menu Confirm/Back (scrController)
{
  if kCode[i]
  {
    kCode[i]=scrController(i)
    kCodePressed[i]=0
  }
  else
  {
    kCode[i]=scrController(i)
    if kCode[i]
      kCodePressed[i]=1
  }
}
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//gamepad change (added): read the gamepad once per frame, before any Step event (oKeyCodes, this object's Step) asks
//scrController for it
scrGamepadPoll()
