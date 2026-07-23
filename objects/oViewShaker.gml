#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Requires: shakeTime (-1 for infinite)
if instance_number(oViewShaker)>1 {instance_destroy(); exit}
x=oPlayer1.x
y=oPlayer1.y
view_object[0]=oViewShaker
shakeAmt=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if shakeTime mod 2=0 {shakeAmt=-4}
  else {shakeAmt=4}
  if oPlayer1.x<240 {x=240+shakeAmt}
  else if oPlayer1.x>room_width-240 {x=room_width-240+shakeAmt}
  else {x=oPlayer1.x+shakeAmt}
  y=oPlayer1.y
  shakeTime-=1
  if shakeTime=0
  {
    view_object[0]=oPlayer1
    instance_destroy()
  }
}
