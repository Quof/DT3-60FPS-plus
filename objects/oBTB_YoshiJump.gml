#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
decay=5
jumpBoost=16
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=0
{
  oPlayer1.yVel=-jumpBoost
  jumpBoost-=1
  decay-=1
  if decay<=0 {instance_destroy()}
}
