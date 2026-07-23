#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: bFollow,(idFollow,xFollow,yFollow),xScaling,yScaling,xShift,yShift,imageFade
image_speed=0
image_blend=make_color_rgb(64,128,88)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  x+=xShift
  y+=yShift
  image_xscale+=xScaling
  image_yscale+=yScaling
  image_alpha-=imageFade
  followInstance()
  if image_alpha<=0 {instance_destroy()}
}
