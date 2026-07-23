#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

damageType="NORMAL"
weaponTag=110
atkPower=150
stunTime=5
weaponRehitTime=30
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
  if instance_exists(myTrap)
  {
    x=myTrap.x
    y=myTrap.y
    if type=0
    {
      image_angle=myTrap.image_angle
    }
  }
  else {instance_destroy()}
}
