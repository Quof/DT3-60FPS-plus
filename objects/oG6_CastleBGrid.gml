#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_alpha=0
bRise=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bRise=1
{
  image_alpha+=0.0025
  if image_alpha>=0.2 {bRise=0}
}
else
{
  image_alpha-=0.0025
  if image_alpha<=0.02 {bRise=1}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(image_alpha)
draw_set_color(c_white)
for(i=0;i<room_width;i+=16)
{
  draw_line(i,0,i,room_height)
}
for(i=0;i<room_height;i+=16)
{
  draw_line(0,i,room_width,i)
}
