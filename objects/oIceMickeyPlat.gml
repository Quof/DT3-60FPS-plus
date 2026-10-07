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
  //myProg+=1
  //if myProg>=1 and myProg<=19 {image_xscale+=0.05*gDeltaTime*myScale}
  //else if myProg>=141 and myProg<=160 {image_xscale-=0.05*gDeltaTime*myScale}
  myProg+=1*gDeltaTime //60fps change: the timer counted frames while the growth was scaled, so the platform only grew to half/quarter width and lasted half/quarter as long at 60/120fps
  if myProg>0 and myProg<=19 {image_xscale+=0.05*gDeltaTime*myScale} //60fps change: covers every frame of the first tick
  else if myProg>140 and myProg<=160 {image_xscale-=0.05*gDeltaTime*myScale} //60fps change
  else if myProg>=161
  {
    myOwner.bPlatformReady=0
    instance_destroy()
  }
}
