#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
vspeed=-3.5
friction=0.1
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if view_current=0
{
  draw_set_font(fnt_NES)
  draw_set_halign(fa_center)
  draw_set_alpha(1)
  textDropShadow(string("+") +string(moneyValue),round(x),round(y),c_white,c_black,1)

  if vspeed>=0 {instance_destroy()}
}
