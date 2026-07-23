#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
atkProg=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if !instance_exists(ownerID) {instance_destroy()}
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.damageType="PIERCE" or other.damageType="SHOT"
{
  if instance_exists(ownerID) {ownerID.shieldPower+=1}
  var tEffect;
  tEffect=instance_create(ownerID.x,ownerID.y-30,oEffect)
  tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=2; tEffect.image_yscale=2
  tEffect.followID=ownerID.id; tEffect.xFollow=0; tEffect.yFollow=-25
  tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  with other {instance_destroy()}
}
