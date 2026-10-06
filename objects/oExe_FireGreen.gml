#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
image_index=1

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false

damageType="ELEMENTAL"

_direction=0
_speed=0
_hspeed=0
_vspeed=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//correctSpeedDirection(self)
event_inherited() //60fps change: this Step event (added during the speed/direction rename) replaced oExe_BulletBase's Step, which sets the speed and runs the curve/speed-change/orbit types, so these bullets never moved; the base Step also does the move (correctSpeedDirection)
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.weaponTag=21 or other.weaponTag=51
{
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  instance_destroy()
}
