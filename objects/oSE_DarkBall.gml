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
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  image_angle+=20
  if phase=0 //Bullets go out
  {
    speed=bulletSpeed
    bulletTime+=1
    if bulletTime>=40
    {
      speed=0
      bulletTime=0; phase+=1
    }
  }
  else if phase=1 //Bullets stop
  {
    bulletTime+=1
    if bulletTime>=20
    {
      if x>oPlayer1.x {xVel=-3}
      else {xVel=3}
      bulletTime=0; phase+=1
    }
  }
  else if phase=2 //Bullets gravity toward the floor
  {
    yVel+=grav
    if isCollisionTop(1) {bDestroy=1}
    if isCollisionBottom(1) {bDestroy=1}
    if isCollisionLeft(1) {bDestroy=1}
    if isCollisionRight(1) {bDestroy=1}
    moveTo(xVel,yVel)

    if bDestroy=1
    {
      myAtk=instance_create(x,y,oSE_DarkExplosionCon)
      myAtk.atkPower=atkPower
      instance_destroy()
    }
  }
}
else {speed=0}
