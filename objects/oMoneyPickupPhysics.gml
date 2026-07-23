#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  yVel+=0.3
  if isCollisionBottom(1)
  {
    xVel=0
    yVel=0
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
