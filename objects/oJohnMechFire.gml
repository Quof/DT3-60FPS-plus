#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.33

damageType="ELEMENTAL"
weaponTag=109
atkPower=500
stunTime=5
bCanPierce=1
lifeTime=150
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  image_angle=direction
  speed=moveSpd
  lifeTime-=1
  if lifeTime<=0 {instance_destroy()}
}
else {speed=0}
