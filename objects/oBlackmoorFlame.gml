#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_blend=c_black
image_speed=0.25+random(0.25)
visible=0

//Enemy base statistics
atkPower=6
bCanTakeDamage=false
bCanDealDamage=false
bShowHealthBar=false
damageType="ELEMENTAL"
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if x>=oBlackmoorMain.x
{
  visible=1
  bCanDealDamage=1
  if random(50)>=49
  {
    var tEffect,tFFScl;
    tFFScl=random(0.25)
    tEffect=instance_create(x,y-16,oEffectB)
    tEffect.type=3; tEffect.sprite_index=sMMSmokeCloud
    tEffect.image_speed=0.5; tEffect.image_alpha=0.7; tEffect.image_blend=c_black
    tEffect.image_xscale=0.75+tFFScl; tEffect.image_yscale=0.75+tFFScl
    tEffect.direction=90; tEffect.speed=random(0.5)+1
    tEffect.friction=random(0.01)+0.02; tEffect.fadeSpd=0.01
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
  }
}
else
{
  visible=0
  bCanDealDamage=0
}
