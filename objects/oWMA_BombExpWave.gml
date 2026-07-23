#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Bomb Explosion Wave
event_inherited()
image_speed=0

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
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
  atkTime+=1
  if atkTime=2 {image_index=1}
  else if atkTime=4 {image_index=2}
  else if atkTime=6 {image_index=3}
  else if atkTime=8 {image_index=4}
  else if atkTime=10 {image_index=5}
  else if atkTime=12 {image_index=6}
  else if atkTime=14 {image_index=7}
  else if atkTime=16 {image_index=8}
  else if atkTime=18 {image_index=9}
  else if atkTime>=20 {instance_destroy()}
}
