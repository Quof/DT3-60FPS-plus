#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCanDealDamage=false
damageType="ELEMENTAL"
atkProg=0

var tEffect,tScaling;
for(i=0;i<20;i+=1)
{
  tScaling=0.6+random(0.4)
  tEffect=instance_create(x-14+random(28),y,oEffect)
  tEffect.sprite_index=sMMSmokeCloud; tEffect.image_alpha=0.7+random(0.2); tEffect.image_speed=0.35
  tEffect.image_xscale=tScaling; tEffect.image_yscale=tScaling
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-2-random(5)
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
    image_index+=0.045
    if image_index>=2.85
    {
      sprite_index=sDraculaFireWave
      image_speed=0.33
      image_yscale=9
      bCanDealDamage=1
      atkProg+=1
    }
  }
  else
  {
    atkProg+=1
    if atkProg>=75 {instance_destroy()}
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bCanDealDamage=1
{
  for(i=0;i<9;i+=1)
    draw_sprite(sDraculaFireWave,image_index,x,y-(32*i))
}
else {event_inherited()}
