#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
decay=20
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=0 //top left
{
  _hspeed=-2
  _vspeed=-6
}
else if type=1 //top right
{
  _hspeed=2
  _vspeed=-6
}
else if type=2 //bottom left
{
  _hspeed=-2
  _vspeed=-3
}
else if type=3 //bottom right
{
  _hspeed=2
  _vspeed=-3
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
_vspeed+=0.4

decay-=1
if decay<=0
  instance_destroy()
correctHSpeedVSpeed(self)
