#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
deathCheck=0
myProg=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  myProg+=1
  if myProg>=1 and myProg<=19 {image_xscale+=0.05*myScale}
  else if myProg>=141 and myProg<=160 {image_xscale-=0.05*myScale}
  else if myProg>=161
  {
    myOwner.bPlatformReady=0
    instance_destroy()
  }
}
