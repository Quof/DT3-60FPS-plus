#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
fadeTime=40
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  fadeTime-=1
  if fadeTime<=0
  {
    image_alpha-=0.02
    if image_alpha<=0 {instance_destroy()}
  }
}
