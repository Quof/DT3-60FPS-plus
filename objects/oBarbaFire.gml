#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-3,-3,3,3)

//Enemy base statistics
atkPower=oBarba.atkPower
damageType="ELEMENTAL"
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
hitWall=0
_direction=0
_speed=0
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tEffect=instance_create(x,y,oEffect)
tEffect.sprite_index=sSamusCannonHit
tEffect.image_speed=0.5; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  _speed=bulletSpeed
  if _direction>=270
    image_angle-=15*gDeltaTime
  else
    image_angle+=15*gDeltaTime

  if isCollisionTop(1)
    hitWall=1
  if isCollisionBottom(1)
    hitWall=2
  if isCollisionLeft(1)
    hitWall=3
  if isCollisionRight(1)
    hitWall=4

  if hitWall>=1
  {
    instance_destroy()
  }
  _hspeed=hspeed
  _vspeed=vspeed
  x+=_hspeed*gDeltaTime
  y+=_vspeed*gDeltaTime
}
else
  _speed=0

correctSpeedDirection(self)
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
