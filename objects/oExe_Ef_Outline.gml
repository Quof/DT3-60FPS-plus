#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=0
{
  image_alpha-=0.1
  if image_alpha<=0 {instance_destroy()}
}
