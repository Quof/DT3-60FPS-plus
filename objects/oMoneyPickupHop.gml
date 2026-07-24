#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if x>=oPlayer1.x
  xVel=2.5
else
  xVel=-2.5
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  yVel+=0.3*gDeltaTime
  if isCollisionBottom(1)
  {
    if checkScreenArea(x,y,48)=1 {playSound(global.snd_RupeeBounce,0,1,1)}
    yVel=-5
  }
  if isCollisionLeftEdit(1)
    xVel*=-1
  if isCollisionRightEdit(1)
    xVel*=-1
  moveTo(xVel*gDeltaTime,yVel*gDeltaTime)

  if isCollisionSolid()
    y-=2

  if y>room_height+24
    instance_destroy()
}
