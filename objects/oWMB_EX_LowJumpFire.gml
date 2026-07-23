#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Low jump fire pillars
event_inherited()
image_speed=0
image_xscale=0.5; image_yscale=0.25

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCanDealDamage=false
damageType="EXPLOSION"
atkProg=0
atkTime=0

var tEffect,tScaling;
for(i=0;i<20;i+=1)
{
  tScaling=0.3+random(0.2)
  tEffect=instance_create(x-7+random(14),y,oEffect)
  tEffect.sprite_index=sMMSmokeCloud; tEffect.image_alpha=0.7+random(0.2); tEffect.image_speed=0.35
  tEffect.image_xscale=tScaling; tEffect.image_yscale=tScaling
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-1-random(2.5)
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if atkProg=0
  {
    atkTime+=1
    if atkTime=8 {image_index=1}
    else if atkTime=16 {image_index=2}
    if atkTime>=24
    {
      playSound(global.snd_Bobomb,0,0.91,30000)
      sprite_index=sEfFirePillar
      bCanDealDamage=1
      atkTime=0; atkProg+=1
    }
  }
  else
  {
    atkTime+=1
    if atkTime=1 {image_index=1}
    else if atkTime=2 {image_index=2}
    else if atkTime=3 {image_index=3}
    else if atkTime=4 {image_index=4}
    else if atkTime=5 {image_index=5}
    else if atkTime>=6 {instance_destroy()}
  }
}
