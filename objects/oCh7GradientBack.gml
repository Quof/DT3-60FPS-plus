#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=0
{
  draw_set_alpha(1)
  //draw_set_color(colorTop)
  //draw_rectangle(-1,-1,room_width+1,yStart,0)
  draw_rectangle_color(-1,yStart,room_width+1,yEnd,colorTop,colorTop,colorBottom,colorBottom,0)
  //draw_set_color(colorBottom)
  //draw_rectangle(-1,yEnd,room_width+1,room_height,0)
}
else if type=1
{
  draw_set_alpha(1)
  draw_set_color(colorTop)
  draw_rectangle(-1,yStart,room_width+1,room_height,0)
}
