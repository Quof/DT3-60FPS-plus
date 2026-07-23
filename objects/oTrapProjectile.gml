#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-2,-2,2,2)

//Enemy base statistics
bShowHealthBar=false
bCanTakeDamage=false
bBlownUp=false
size=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  image_angle=direction
  speed=bulletSpeed
  dist=point_distance(x,y,xstart,ystart)
  if dist>32
  {
    if isCollisionTop(1)
      bBlownUp=true
    if isCollisionBottom(1)
      bBlownUp=true
    if isCollisionLeft(1)
      bBlownUp=true
    if isCollisionRight(1)
      bBlownUp=true

    if bBlownUp=true
      instance_destroy()
  }
}
else
  speed=0
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
