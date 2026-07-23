#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if x>=oPlayer1.x
  xVel=2.5*gDeltaTime
else
  xVel=-2.5*gDeltaTime
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  yVel+=0.3*gDeltaTime*gDeltaTime
  if isCollisionBottom(1)
  {
    if checkScreenArea(x,y,48)=1 {playSound(global.snd_RupeeBounce,0,1,1)}
    yVel=-5*gDeltaTime
  }
  if isCollisionLeft(1)
    xVel*=-1
  if isCollisionRight(1)
    xVel*=-1
  moveTo(xVel,yVel)

  if isCollisionSolid()
    y-=2

  if y>room_height+24
    instance_destroy()
}
