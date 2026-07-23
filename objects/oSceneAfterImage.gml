#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
imageColor=make_color_rgb(64,128,88)
init=0
xShift=0
yShift=0
xScaling=0
yScaling=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if init=0
{
  if variable_local_exists("xShiftSet")
    xShift=xShiftSet
  if variable_local_exists("yShiftSet")
    yShift=yShiftSet
  if variable_local_exists("xScalingSet")
    xScaling=xScalingSet
  if variable_local_exists("yScalingSet")
    yScaling=yScalingSet
  init=1
}
x+=xShift
y+=yShift
image_xscale+=xScaling
image_yscale+=yScaling
image_alpha-=imageFade
if image_alpha<=0
  instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,imageColor,image_alpha)
