#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
parent="trap"
event_inherited()
size=2
#define Collision_oPlayerShieldBubble
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if size=1
{
  var tEffect;
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sMMchargeComplete
  tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

  instance_destroy()
}
#define Collision_oJCGameFlameShield
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if size=1
{
  var tEffect;
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sMMchargeComplete
  tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

  with other {instance_destroy()}
  instance_destroy()
}
