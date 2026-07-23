#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
textColor=make_color_rgb(236,236,236)
image_alpha=0.3
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if checkScreenArea(x,y,128)=1
{
  draw_set_color(textColor)
  draw_set_alpha(image_alpha)
  draw_set_font(fnt_VaultBack)
  draw_set_halign(fa_left)
  draw_text_ext(x+3,y-1,vaultString,4,240)
}
