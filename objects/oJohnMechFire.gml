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
  image_angle=_direction
  _speed=moveSpd
  lifeTime-=1*gDeltaTime
  if lifeTime<=0 {instance_destroy()}
}
else {_speed=0}

x += cos(degtorad(_direction)) * _speed * gDeltaTime
y -= sin(degtorad(_direction)) * _speed * gDeltaTime
