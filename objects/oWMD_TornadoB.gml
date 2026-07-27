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
  if room=rWarshipZ_E3 {image_xscale+=0.12*gDeltaTime; image_yscale+=0.12*gDeltaTime} //EX MODE
  else {image_xscale+=0.11*gDeltaTime; image_yscale+=0.11*gDeltaTime}

  atkTime+=1*gDeltaTime
  if atkTime>=12
  {
    image_alpha-=0.05*gDeltaTime
    if image_alpha<=0.5 {instance_destroy()}
  }
}
