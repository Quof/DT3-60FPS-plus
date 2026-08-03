#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: bulletSpeed,arcAmt,falloff,decayTime
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
init=0
_speed=0
_direction=0
_speed=0
_direction=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if init=0 {init=1}

  _speed=bulletSpeed
  _direction+=arcAmt*gDeltaTime
  image_angle=_direction

  if arcAmt!=0
  {
    if arcAmt>0 {arcAmt-=falloff*gDeltaTime}
    else {arcAmt+=falloff*gDeltaTime}
  }
  if arcAmt>-0.2 and arcAmt<0.2 {arcAmt=0}

  if decayTime!=-100
  {
    decayTime-=1*gDeltaTime
    if decayTime<=0 {instance_destroy()}
  }
  _speed=0
  x += cos(degtorad(_direction)) * _speed * gDeltaTime
  y -= sin(degtorad(_direction)) * _speed * gDeltaTime

}
else {_speed=0}
correctSpeedDirection(self)
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if decayTime=-100 and init=1 {instance_destroy()}
