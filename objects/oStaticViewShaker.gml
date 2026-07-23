#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Requires: shakeAmt
// This must be destroyed externally (Be sure to set the view to a new object before doing so)
if instance_number(oStaticViewShaker)>1 {instance_destroy(); exit}
view_object[0]=oStaticViewShaker
shakeTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  shakeTime+=1
  if shakeTime mod 2=0 {x=xstart-shakeAmt}
  else {x=xstart+shakeAmt}
}
