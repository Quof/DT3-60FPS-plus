#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bShielding=1
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
if bShielding=1
{
  if other.damageType="PIERCE" or other.damageType="SHOT"
  {
    var tEffect;
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sMMchargeComplete
    tEffect.followID=id; tEffect.xFollow=0; tEffect.yFollow=0
    tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    with other {instance_destroy()}
  }
}
