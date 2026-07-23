#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.25
image_alpha=0.85
smokeTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if checkScreenArea(x,y,48)
{
  smokeTime+=1
  if smokeTime>=3
  {
    var tFFScl,tEffect;
    tFFScl=random(0.25)
    tEffect=instance_create(x+random_range(-6,6),y-6-random(4),oEffectB)
    tEffect.type=3; tEffect.sprite_index=sMMSmokeCloud; tEffect.newBlend=-1
    tEffect.image_xscale=0.5+tFFScl; tEffect.image_yscale=0.5+tFFScl; tEffect.image_alpha=0.75
    tEffect.direction=random_range(87,93); tEffect.speed=random(1)+1.5; tEffect.depth=99; tEffect.image_speed=0.25
    tEffect.fadeSpd=0.03; tEffect.image_blend=c_dkgray; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
    smokeTime=0
  }
}
