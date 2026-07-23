#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
characterCreateEvent()
//makes Mario only able to run on example 1
if room!=room17
  canRun=0
//set this character to player 2
player=2
//need this variable to stop Mario from dying when jumping on two Goombas at once, see the Step event
temporarilyInvincibleFromGoombas=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
characterStepEvent()
if y>room_height
{
  instance_create(x,y,oCharacterDie)
  instance_destroy()
}
if x<0
{
  xVel=0
  x=0
}
else if x>room_width
{
  xVel=0
  x=room_width
}
//need this code to stop Mario from dying when jumping on two Goombas at once, see the oGoomba collision event for it to make sense
temporarilyInvincibleFromGoombas=0
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
characterDrawEvent()
