#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-7,-7,7,7)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
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
  yVel+=grav
  if yVel<0 {image_angle=90}
  else if yVel>0 {image_angle=270}

  if isCollisionBottom(1)
    instance_destroy()
  moveTo(xVel,yVel)

  if y>room_height+32
    instance_destroy()
}
