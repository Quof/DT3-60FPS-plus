#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Tornado - Grow in place
event_inherited()
image_speed=0.33
image_alpha=0.9
image_xscale=0.1; image_yscale=0.1

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="ELEMENTAL"
size=2
atkTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if room=rWarshipZ_E3 {image_xscale+=0.12; image_yscale+=0.12} //EX MODE
  else {image_xscale+=0.11; image_yscale+=0.11}

  atkTime+=1
  if atkTime>=12
  {
    image_alpha-=0.05
    if image_alpha<=0.5 {instance_destroy()}
  }
}
