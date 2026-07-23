#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if view_current=0
{
  image_alpha-=0.01*gDeltaTime
  if image_alpha<=0 {instance_destroy()}
  if global.optShowHUD=1
  {
    draw_set_font(fnt_Points)
    draw_set_halign(fa_left)
    draw_set_alpha(image_alpha)
    if type=0 {textDropShadow(string("Exp +") +string(round(pointValue)),view_xview[0]+8,view_yview[0]+288-yy,c_white,c_black,1)}
    else if type=1 {{textDropShadow("LEVEL UP!!",view_xview[0]+8,view_yview[0]+288-yy,c_white,c_black,1)}}
  }
}
