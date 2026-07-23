#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bottomColor=make_color_rgb(24,32,64)

if room=rExtGateG_1 or room=rExtGateG_2 or room=rExtGateG_3 or room=rExtGateG_4 or room=rExtGateG_5
{
  bottomColor=make_color_rgb(40,48,48)
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if room=rExtGateG_1 or room=rExtGateG_2 or room=rExtGateG_3 or room=rExtGateG_4 or room=rExtGateG_5
{
  draw_set_alpha(1)
  draw_set_color(bottomColor)
  draw_rectangle(0,view_yview[0]+yStartDraw,room_width,room_height,0)
}
else
{
  draw_set_alpha(1)
  draw_set_color(bottomColor)
  draw_rectangle(0,yStartDraw,room_width,room_height,0)
}
