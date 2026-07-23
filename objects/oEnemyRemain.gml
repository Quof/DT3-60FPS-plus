#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.optShowHUD=1
{
  draw_sprite(sprite_index,0,view_xview[0]+419,view_yview[0]+5)
  draw_set_color(make_color_rgb(16,8,8))
  draw_set_alpha(1)
  draw_set_font(fnt_Scan)
  draw_set_halign(fa_center)
  draw_text(view_xview[0]+446,view_yview[0]+17,enemyCount)
}
