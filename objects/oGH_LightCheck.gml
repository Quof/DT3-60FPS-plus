#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
bOpened=0
lightCheck="0"

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var lightCheck;
lightCheck=string_char_at(global.gateHLamps,myLight)
if lightCheck="1" {bOpened=1}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if myLight=4 {bOpened=(428251).bOpened}
  else if myLight=5 {bOpened=(428252).bOpened}
  else if myLight=6 {bOpened=(428256).bOpened}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
if bOpened=1
{
  draw_set_alpha(0.2)
  draw_set_blend_mode(bm_add)
  draw_circle_color(x,y,16,make_color_rgb(240,193,64),c_black,false)
  draw_set_blend_mode(bm_normal)
}
