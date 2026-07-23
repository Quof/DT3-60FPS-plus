#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: drawType,xMove,yMove,moveMax,soundUse
viscidTop=1
makeActive()

moveTime=0
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
  if progCheck=1 //Move direction on a set time
  {
    if soundUse=1 {playSound(global.snd_Slam,0,1,1)}
    soundUse=0
    xVel=xMove
    yVel=yMove
    moveTime+=1
    if moveTime>=moveMax
    {
      xVel=0; yVel=0
      progCheck=2
    }
  }
  scrPlatformCrush()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if drawType=0 //Hidden Program Facility
{
  draw_background_part(tileHPF,0,0,48,32,x,y)
  draw_background_part(tileHPF,16,0,48,32,x+48,y)
}
