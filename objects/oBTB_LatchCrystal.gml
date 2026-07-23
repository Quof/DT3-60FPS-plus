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
  speed=moveSpd
  moveTime+=1
  if moveTime>=moveDelay
  {
    direction+=180
    moveTime=0
  }
}
else {speed=0}
