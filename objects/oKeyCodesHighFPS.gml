#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//gamepad change (added): rExtGateB_1 has one of these placed in it, so entering that room made another (persistent)
//copy each time, and its scrGamepadInit put the gamepad controls back to the defaults. Only the one made in rIntro is
//needed.
if instance_number(oKeyCodesHighFPS)>1 {instance_destroy(); exit}
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
//key carry change (added): note which left/right keys are held, for the screen transition carry (scrKeyCarry)
scrKeyCarry(0)
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//gamepad change (added): read the gamepad once per frame, before any Step event (oKeyCodes, this object's Step) asks
//scrController for it
scrGamepadPoll()
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//key carry change (added): left/right keys held through the screen transition stay held (scrKeyCarry)
scrKeyCarry(1)
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//key carry change (added): note the left/right keys held as the room ends, for the carry in Room Start (scrKeyCarry)
scrKeyCarry(2)
