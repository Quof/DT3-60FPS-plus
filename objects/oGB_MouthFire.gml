#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//requires: xGrav,yGrav
event_inherited()
makeActive()
setCollisionBounds(-3,-3,3,3)
image_speed=0.33

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bDestroy=0
weight=50
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  xVel+=xGrav
  yVel+=yGrav
  hspeed=xVel
  vspeed=yVel
  image_angle=direction

  if isCollisionTop(1)
    bDestroy=1
  if isCollisionBottom(1)
    bDestroy=1
  if isCollisionLeft(1)
    bDestroy=1
  if isCollisionRight(1)
    bDestroy=1

  if bDestroy=1
  {
    instance_destroy()
  }
  if y>room_height+32
    instance_destroy()
}
else
{
  hspeed=0
  vspeed=0
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tEffect;
tEffect=instance_create(x,y,oEffect)
tEffect.sprite_index=sMMchargeComplete
tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
if other.bCanPierce=0
{
  with other {instance_destroy()}
}
instance_destroy()
