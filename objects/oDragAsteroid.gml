#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: bulletSpeed
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
atkPower=20
size=2
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  speed=bulletSpeed
  image_angle+=1
  if x<=-256 {instance_destroy()}
}
else {speed=0}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with other
{
  if sprite_index=sDrag_Shot1
  {
    tEffect=instance_create(x+random_range(-2,2),y+random_range(-2,2),oEffect)
    tEffect.sprite_index=sEfWireSparks; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
    tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_speed=0.5
    tEffect.image_xscale=0.25; tEffect.image_yscale=0.25; tEffect.image_angle=random(360)
  }
  else if sprite_index=sDrag_Shot2 or sprite_index=sRobotExplosion {}
  else {instance_destroy()}
}
