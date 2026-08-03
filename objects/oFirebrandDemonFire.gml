#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.33

damageType="NORMAL"
weaponTag=108
atkPower=250
stunTime=8
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
  _speed=moveSpd
  lifeTime-=1*gDeltaTime
  if lifeTime<=0 {instance_destroy()}
}
else {_speed=0}
correctSpeedDirection(self)
