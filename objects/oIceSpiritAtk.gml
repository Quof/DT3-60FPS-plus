#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
image_alpha=0

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="ELEMENTAL"
bCanBeBlocked=1
blockCost=450
bParryOpp=1
formTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  image_angle=direction+45
  formTime+=1
  if formTime=1 {playSound(global.snd_Magic,0,0.9,27000)}
  else if formTime=25 {playSound(global.snd_LightballSpread,0,0.9,27000)}

  if formTime>=1 and formTime<=5
  {
    image_alpha+=0.2
  }
  else if formTime=15
  {
    image_index=1
    for(i=0;i<12;i+=1)
    {
      var tEffect;
      tEffect=instance_create(x+random_range(-14,14),y+random_range(-14,14),oEffectB)
      tEffect.type=3; tEffect.sprite_index=sEfDiffusionParticle; tEffect.newBlend=-1; tEffect.image_alpha=0.75
      tEffect.direction=random(360); tEffect.speed=random(1)+1; tEffect.friction=random(0.01)+0.01
      tEffect.fadeSpd=0.025; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=random_range(-3,3)
    }
  }
  else if formTime>=25
  {
    speed=bulletSpeed
  }
}
else {speed=0}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if decayTime=-100
  instance_destroy()
