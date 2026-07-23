#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

damageType="EXPLOSION"
weaponTag=108
atkPower=250
stunTime=5
bCanPierce=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  image_index+=0.25
  if image_index>=5.7
  {
    instance_destroy()
  }
}
