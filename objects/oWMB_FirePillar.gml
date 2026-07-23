#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Flame Pillar
event_inherited()
image_speed=0

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="EXPLOSION"
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
  if atkTime=3 {image_index=1}
  else if atkTime=6 {image_index=2}
  else if atkTime=9 {image_index=3}
  else if atkTime=12 {image_index=4}
  else if atkTime=15 {image_index=5}
  else if atkTime>=17 {instance_destroy()}
}
