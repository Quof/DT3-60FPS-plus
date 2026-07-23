#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0

damageType="EXPLOSION"
weaponTag=105
bCanPierce=1
mySpeed=0.5
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  image_index+=mySpeed*global.speedMod
  if image_index>=image_number {instance_destroy()}
}
