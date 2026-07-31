#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-8,-8,8,8)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bDestroy=0
weight=100
grav=0.2
phase=0
bulletTime=0
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
  image_angle+=20*gDeltaTime
  if phase=0 //Bullets go out
  {
    _speed=bulletSpeed
    bulletTime+=1*gDeltaTime
    x += cos(degtorad(_direction)) * _speed * gDeltaTime
    y -= sin(degtorad(_direction)) * _speed * gDeltaTime
    if bulletTime>=40
    {
      _speed=0
      bulletTime=0; phase+=1
    }
  }
  else if phase=1 //Bullets stop
  {
    bulletTime+=1*gDeltaTime
    if bulletTime>=20
    {
      if x>oPlayer1.x {xVel=-3}
      else {xVel=3}
      bulletTime=0; phase+=1
    }
  }
  else if phase=2 //Bullets gravity toward the floor
  {
    yVel+=grav*gDeltaTime
    if isCollisionTop(1) {bDestroy=1}
    if isCollisionBottom(1) {bDestroy=1}
    if isCollisionLeft(1) {bDestroy=1}
    if isCollisionRight(1) {bDestroy=1}
    moveTo(xVel*gDeltaTime,yVel*gDeltaTime)

    if bDestroy=1
    {
      myAtk=instance_create(x,y,oSE_DarkExplosionCon)
      myAtk.atkPower=atkPower
      instance_destroy()
    }
  }
}
else {_speed=0}
