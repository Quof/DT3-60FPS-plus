#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=0.1
image_yscale=0.1

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
size=2
atkProg=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if atkProg=0 //Grow shield
  {
    image_xscale+=0.1*gDeltaTime; image_yscale+=0.1*gDeltaTime
    //if image_xscale=1.3 {atkProg=1}
    if image_xscale>=1.3 {image_xscale=1.3; image_yscale=1.3; atkProg=1} //60fps change: in 0.05/0.025 steps the scale never lands exactly on 1.3 (float), so the shield kept growing and never turned with its owner
  }
  if !instance_exists(ownerID) {instance_destroy()}
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.bCanPierce=0 or other.sprite_index=sMMXgravityWell1
{
  var tEffect;
  tEffect=instance_create(x+(4*image_xscale),y,oEffect)
  tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=1.5; tEffect.image_yscale=1.5
  tEffect.followID=id; tEffect.xFollow=0; tEffect.yFollow=0
  tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  with other {instance_destroy()}
}
