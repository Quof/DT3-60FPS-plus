#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
efTimer=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
efTimer+=1
if efTimer mod 2=0
{
  var tEffect;
  tEffect=instance_create(view_xview[0]-48+random(view_wview[0]+96),view_yview[0]-40+random(view_hview[0]+80),oEffectB)
  tEffect.type=3; tEffect.sprite_index=sEfDiffusionParticle; tEffect.newBlend=-1; tEffect.depth=5; tEffect.image_alpha=0.6
  tEffect.fadeSpd=0.0075; tEffect.direction=random_range(230,310)
  tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0; tEffect.image_speed=0.3
  if oGateF_GravControl.lowGravOn=0 {tEffect.speed=random(1)+0.25}
  else if oGateF_GravControl.lowGravOn=1
  {
    if room=rExtGateF_5 {tEffect.speed=random(1)+2}
    else {tEffect.speed=random(0.25)+0.1}
  }
}
