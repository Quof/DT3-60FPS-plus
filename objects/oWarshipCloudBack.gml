#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
topColor=make_color_rgb(56,72,136)
bottomColor=make_color_rgb(88,80,112)

if room=rWarshipF or room=rWarshipG
{
  topEnd=82
  bottomEnd=280
}
else if room=rWarshipH or room=rWarshipI
{
  topEnd=62
  bottomEnd=260
}
else if room=rCh21_WarshipSkies
{
  topEnd=72
  bottomEnd=270
}
else
{
  topEnd=102
  bottomEnd=300
}

if room=rWarshipZ_EscapeB or room=rWarshipZ_EscapeC
{
  topColor=make_color_rgb(28,36,68)
  bottomColor=make_color_rgb(44,40,56)
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(1)
draw_set_color(topColor)
draw_rectangle(0,0,room_width,topEnd,0)
draw_set_color(bottomColor)
draw_rectangle(0,bottomEnd,room_width,room_height,0)
