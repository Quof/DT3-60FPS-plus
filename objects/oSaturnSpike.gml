#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.5

//Enemy base statistics
atkPower=50000000000+irandom(50000000000)
bCanTakeDamage=false
bShowHealthBar=false
decayTime=16
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  _speed=9
  speed=0
  x += cos(degtorad(_direction)) * _speed * gDeltaTime
  y -= sin(degtorad(_direction)) * _speed * gDeltaTime
  decayTime-=1*gDeltaTime
  if decayTime<=0 {instance_destroy()}
}
else {speed=0;_speed=0}
