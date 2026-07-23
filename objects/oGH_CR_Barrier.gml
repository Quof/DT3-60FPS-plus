#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_yscale=10

if global.gateHProg<=6 {instance_destroy()}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gateHLamps="111111111"
{
  sprite_index=sNull
}
else
{
  sprite_index=sInvisibleSolidMask
  for(i=0;i<2;i+=1)
  {
    var tEffect,tScl;
    tScl=1+random(0.5)
    tEffect=instance_create(x+random(16),y+random(160),oEffectB)
    tEffect.type=3; tEffect.sprite_index=sMMSmokeCloud; tEffect.newBlend=-1; tEffect.image_speed=0.2+random(0.2)
    tEffect.image_alpha=0.5; tEffect.fadeSpd=0.02; tEffect.image_blend=c_black; tEffect.image_xscale=tScl; tEffect.image_yscale=tScl
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
  }
}
