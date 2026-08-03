#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: decayTime,bulletSpeed
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
init=0
bulletProg=0
_direction=0
_speed=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  image_angle=_direction
  if bulletProg=1
  {
    _speed=bulletSpeed
  }
}
else {_speed=0}

x += cos(degtorad(_direction)) * _speed * gDeltaTime
y -= sin(degtorad(_direction)) * _speed * gDeltaTime
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
