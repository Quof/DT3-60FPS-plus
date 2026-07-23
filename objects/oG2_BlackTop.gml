#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bMountain=0
if room=rBelmont3_5A
  yStart=928
else if room=rBelmont3_5B or room=rBelmont3_5C or room=rBelmont3_5D or room=rBelmont3_5E or room=rBelmont3_5G
  yStart=464
else if room=rBelmont3_5F or room=rBelmont3_5H
  yStart=288

if variable_local_exists("yStart")
{
  bMountain=1
  depth=1100000
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(1)
draw_set_color(c_black)
if global.location=10 //Gate 2
  draw_rectangle(0,0,room_width,79,0)
else if global.location=15 //Gate 3
{
  if bMountain=1
    draw_rectangle(0,yStart,room_width,room_height,0)
  else
    draw_rectangle(0,320,room_width,352,0)
}
