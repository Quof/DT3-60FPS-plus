#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
init=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if init=0
    init=1
  if decayTime!=-100
  {
    decayTime-=1
    if decayTime<=0 {instance_destroy()}
  }

  speed=bulletSpeed
  if sprite_index=sRidleyFireball
  {
    image_xscale+=0.01; image_yscale+=0.01
    image_angle-=15
  }
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
  if bCanPierce=0 {instance_destroy()}
}

var tEffect;
tEffect=instance_create(x,y,oEffect)
tEffect.sprite_index=sMMchargeComplete
tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
instance_destroy()
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if decayTime=-100 and init=1
  instance_destroy()
