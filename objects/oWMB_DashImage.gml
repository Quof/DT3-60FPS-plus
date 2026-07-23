#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
progTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  progTime+=1
  if progTime>=8
  {
    image_alpha-=0.25
    if image_alpha<=0 {instance_destroy()}
  }
}
