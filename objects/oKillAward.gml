#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
vspeed=-4.5
friction=0.15
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if view_current=0
{
  draw_set_font(fnt_Points)
  draw_set_halign(fa_center)
  draw_set_alpha(1)
  textDropShadow(round(pointValue),x,y,c_white,c_black,1)

  if vspeed>=0 {instance_destroy()}
}
