#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//for(i=1;i<=14;i+=1)
//for(i=1;i<=16;i+=1) //gamepad change: + 15/16, menu Confirm/Back (scrController)
for(i=1;i<=18;i+=1) //gamepad change: + 15/16, menu Confirm/Back (scrController) //options tabs change: + 17/18, the Options tabs (U/L1, I/R1)
{
  kCode[i]=0
  kCodePressed[i]=0
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if gDeltaDoTicks != 1 { exit; }
//for(i=1;i<=14;i+=1)
//for(i=1;i<=16;i+=1) //gamepad change: + 15/16, menu Confirm/Back (scrController)
for(i=1;i<=18;i+=1) //gamepad change: + 15/16, menu Confirm/Back (scrController) //options tabs change: + 17/18, the Options tabs (U/L1, I/R1)
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
