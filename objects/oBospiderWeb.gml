#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_xscale=0.2
bUsed=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bUsed=2
  {
    image_xscale-=0.2
    if image_xscale<=0 {instance_destroy()}
  }
  else
  {
    if image_xscale<1 {image_xscale+=0.2}
  }
}
