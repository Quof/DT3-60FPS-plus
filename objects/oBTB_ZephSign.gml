#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
textColor=make_color_rgb(228,0,88)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_self()
draw_set_alpha(1)
draw_set_color(textColor)
draw_set_font(fnt_EnemyName)
draw_set_halign(fa_center)
draw_text(x,y+2,doorNum)
