#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
visible=0
image_speed=0
bCanDealDamage=false

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="ELEMENTAL"
atkProg=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  atkProg+=1
  if atkProg=1
  {
    playSound(global.snd_WindBlow,0,0.9,26000)
    var tFFScl,tEffect;
    for(i=0;i<32;i+=1)
    {
      tFFScl=random(0.1)
      tEffect=instance_create(x+random_range(-20,40),y-random(32),oEffectB)
      tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
      tEffect.image_alpha=0.9; tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl
      tEffect.direction=random_range(87,93); tEffect.speed=random(1.5)+1; tEffect.friction=random(0.02)+0.02
      tEffect.fadeSpd=0.03; tEffect.image_blend=make_color_rgb(random(50),random(50),255)
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
    }
  }
  else if atkProg=30
  {
    playSound(global.snd_PotShatter,0,0.92,18000)
    playSound(global.snd_HardHit3,0,0.95,18000)
    visible=1
    bCanDealDamage=true
  }
  else if atkProg=33 {image_index=1}
  else if atkProg=36 {image_index=2}
  else if atkProg=39 {image_index=3}
  else if atkProg=42
  {
    image_index=4
    bCanDealDamage=false
  }
  else if atkProg>=45 {instance_destroy()}
}
