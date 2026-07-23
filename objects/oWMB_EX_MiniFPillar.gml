#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Mini Flame Pillar
event_inherited()
image_speed=0
image_xscale=0.5; image_yscale=0.25

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
  if atkTime=1 {image_index=1}
  else if atkTime=2 {image_index=2}
  else if atkTime=3 {image_index=3}
  else if atkTime=4 {image_index=4}
  else if atkTime=5 {image_index=5}
  else if atkTime>=6 {instance_destroy()}
}
