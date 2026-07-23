#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if room_width>room_height {sparkTime=round(y/16)}
else {sparkTime=round(x/16)}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  sparkTime+=1
  if sparkTime>=30
  {
    var tSpark;
    tSpark=instance_create(x+((32+random(14))*image_xscale),y+18+random(32),oTrapExplosion)
    tSpark.sprite_index=sEfWireSparks; tSpark.image_speed=0.35
    tSpark.image_angle=random(360); tSpark.image_alpha=0.75; tSpark.depth=9
    tSpark.atkPower=8; tSpark.damageType="NORMAL"; tSpark.decayTime=8
    sparkTime=0
  }
}
