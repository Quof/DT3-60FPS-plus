#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

damageType="SHOT"
weaponTag=120
atkPower=15*(1+oIdentifier.grazePercent)
global.recAtkNum+=1
stunTime=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  _speed=12
  x += cos(degtorad(_direction)) * _speed * gDeltaTime
  y -= sin(degtorad(_direction)) * _speed * gDeltaTime
}
else {_speed=0}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
