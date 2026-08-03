#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.33
image_alpha=0.5

damageType="SHOT"
weaponTag=108
atkPower=80
stunTime=5
bCanPierce=1
weaponRehitTime=12
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
  if _direction>=90 and _direction<=270 {image_angle-=5}
  else {image_angle+=5}
  _speed=moveSpd
  lifeTime-=1
  if lifeTime<=0 {instance_destroy()}
}
else {_speed=0}
correctSpeedDirection(self)
