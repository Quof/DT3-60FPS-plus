#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=0
{
  draw_set_alpha(1)
  draw_set_color(backColor)
  draw_rectangle(-1,yStart,room_width+1,room_height+1,0)
}
else if type=1
{
  colorJungleTop=make_color_rgb(232-(oPlayer1.x/32),120-(oPlayer1.x/64),80-(oPlayer1.x/128))
  colorJungleBottom=make_color_rgb(240-(oPlayer1.x/32),168-(oPlayer1.x/64),40)
  draw_set_alpha(1)
  draw_set_color(colorJungleTop)
  draw_rectangle(-1,-1,room_width+1,yStart,0)
  draw_rectangle_color(-1,yStart,room_width+1,yEnd,colorJungleTop,colorJungleTop,colorJungleBottom,colorJungleBottom,0)
  draw_set_color(colorJungleBottom)
  draw_rectangle(-1,yEnd,room_width+1,room_height+1,0)
}
