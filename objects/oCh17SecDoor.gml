#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()

progCheck=0
deathCheck=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if progCheck=1 //Door closes
  {
    yVel=4
    if y>=ystart
    {
      yVel=0
      progCheck=2
    }
  }

  scrPlatformCrush()
}
