#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

image_speed=random(0.25)+0.25

//Enemy base statistics
if global.location=99
{
  if room=rWarshipM {atkPower=10}
  else if room=rWarshipQ {atkPower=12}
  else
  {
    sprite_index=sWS_SpikeBall
    atkPower=12
  }
}
else {atkPower=10}
damageType="ELEMENTAL"
bCanTakeDamage=false
bShowHealthBar=false
