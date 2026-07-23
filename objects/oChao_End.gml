#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.4
changeProg=0
changeTime=0
circleAlpha=1
circleRadius=0
myColor=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if changeProg=1
{
  y+=1
  if y>=276 {changeProg+=1}
}
else if changeProg=2
{
  circleRadius+=1
  if circleRadius>=48
  {
    sprite_index=sChaoHumanForm; image_speed=0; image_index=0; image_blend=c_black
    image_xscale=0.1; image_yscale=0.1
    changeProg+=1
  }
}
else if changeProg=3
{
  changeTime+=1
  if changeTime>=5
  {
    image_xscale+=0.02; image_yscale+=0.02
    if image_xscale>=1 {changeTime=0; changeProg+=1}
  }
}
else if changeProg=4
{
  changeTime+=1
  if changeTime>=5
  {
    if myColor<255 {myColor+=5}
    image_blend=make_color_rgb(myColor,myColor,myColor)

    circleAlpha-=0.015

    circleRadius-=1
    if circleRadius<=0 and myColor>=255 {image_blend=c_white; changeProg+=1}
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_self()
if circleRadius>0
{
  draw_set_alpha(circleAlpha)
  draw_set_color(c_white)
  draw_circle(x,y,circleRadius,0)
}
