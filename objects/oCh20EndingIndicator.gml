#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePttT_Prog>=100
{
  endingLight=1
  lightGlow=make_color_rgb(64,100,240)
}
else
{
  endingLight=0
  lightGlow=make_color_rgb(240,100,64)
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_self()
draw_sprite(sWS_EndingLight,endingLight,x,y+25)
draw_set_blend_mode(bm_add)
draw_circle_color(x,y+27,16,lightGlow,c_black,false)
draw_set_blend_mode(bm_normal)
