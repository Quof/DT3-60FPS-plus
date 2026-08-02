#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: bulletSpeed,atkDelay
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
atkPower=oHexor_Main.atkPower

atkProg=0
atkTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if atkProg=0 //Spin outward
  {
    image_angle+=11*gDeltaTime
    _speed=bulletSpeed
    x += cos(degtorad(_direction)) * _speed * gDeltaTime
    y -= sin(degtorad(_direction)) * _speed * gDeltaTime
    atkTime+=1*gDeltaTime
    if atkTime>=atkDelay
    {
      instance_destroy()
    }
  }
}
else {_speed=0}
