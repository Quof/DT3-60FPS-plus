#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-2,-2,2,2)

//Enemy base statistics
bShowHealthBar=false
bCanTakeDamage=false
size=1
_direction=0

weight=50
grav=0.2
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  image_angle=_direction
  dist=point_distance(x,y,xstart,ystart)
  if dist>24
  {
    if isCollisionTop(1)
      instance_destroy()
    if isCollisionBottom(1)
      instance_destroy()
    if isCollisionLeft(1)
      instance_destroy()
    if isCollisionRight(1)
      instance_destroy()
    if isCollisionSolid()
      instance_destroy()
  }
  yVel+=grav*gDeltaTime
  moveTo(xVel*gDeltaTime,yVel*gDeltaTime)

  if y>room_height+32
    instance_destroy()
}
