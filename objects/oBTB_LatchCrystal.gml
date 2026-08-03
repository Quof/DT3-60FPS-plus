#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Required: moveDelay,moveSpd
event_inherited()
moveTime=0
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
  moveTime+=1
  if moveTime>=moveDelay
  {
    _direction+=180
    moveTime=0
  }
}
else {_speed=0}
correctSpeedDirection(self)
