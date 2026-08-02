#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_blend=make_color_rgb(150,255,150)
progTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  progTime+=1*gDeltaTime
  if progTime>=4
  {
    image_alpha-=0.25*gDeltaTime
    if image_alpha<=0 {instance_destroy()}
  }
}
