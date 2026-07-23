#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
efSwirlTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
efSwirlTime+=1
if efSwirlTime mod 3=0
{
  for(i=0;i<image_yscale;i+=1)
  {
    var tEffect;
    tEffect=instance_create(x+random(16),y+8+(i*16)+random(16),oEffectB)
    tEffect.type=3; tEffect.sprite_index=sEf_Dist_Barrier; tEffect.newBlend=-1
    tEffect.speed=1; tEffect.direction=90; tEffect.image_xscale=choose(-1,1)
    tEffect.fadeSpd=0.03; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
  }
}
