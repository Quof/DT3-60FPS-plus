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
  else if room=rWarshipZ_A or room=rWarshipZ_B or room=rWarshipZ_C or room=rWarshipZ_D or room=rWarshipZ_H
  {
    atkPower=14
  }
  else
  {
    atkPower=12
  }
}
else {atkPower=10}
damageType="ELEMENTAL"
bCanTakeDamage=false
bShowHealthBar=false
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
