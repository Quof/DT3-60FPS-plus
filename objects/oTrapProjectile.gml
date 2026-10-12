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
_direction=0
_speed=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  image_angle=_direction
  _speed=bulletSpeed
  dist=point_distance(x,y,xstart,ystart)
  //if dist>32
  if dist>32 and gDeltaDoTicks //60fps change: walls checked once per 30fps tick, as at 30fps (four precise line checks every frame, for every trap shot in the room, lagged rooms full of spawners like rSkyCaveB at 60/120fps)
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
  {_speed=0}
correctSpeedDirection(self)
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
