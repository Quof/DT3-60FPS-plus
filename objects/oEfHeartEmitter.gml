#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
efTime=irandom(50)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
efTime+=1
if efTime>=efDelay
{
  var tEffect;
  tEffect=instance_create(x+8,y+8,oEffectB)
  tEffect.sprite_index=sFarreachesHeart; tEffect.type=3
  tEffect.fadeSpd=0.03; tEffect.hspeed=random_range(-0.5,0.5); tEffect.vspeed=-1
  tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
  efTime=irandom(20)
}
