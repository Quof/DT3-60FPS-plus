#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
timeTillFade=5
xx=x
yy=y
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
yy-=0.25
timeTillFade-=1
if timeTillFade<=0
{
  image_alpha-=0.1
  if image_alpha<=0 {instance_destroy()}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if view_current=0
{
  draw_set_font(fnt_OtherStats)
  draw_set_halign(fa_left)
  draw_set_alpha(image_alpha)
  textDropShadow(string("+") +string(round(AwesomeValue)),view_xview[0]+xx,view_yview[0]+yy,c_white,c_black,1)
}
