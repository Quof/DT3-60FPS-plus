#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

damageType="NORMAL"
weaponTag=170
atkPower=600
stunTime=20
bCanPierce=1
decay=3
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  decay-=1
  if decay<=0 {instance_destroy()}
}
