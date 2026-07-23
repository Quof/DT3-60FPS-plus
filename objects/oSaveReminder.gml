#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
hspeed=random_range(-2,2)
vspeed=-random_range(3,4)
dispTime=10
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
vspeed+=0.2
draw_set_halign(fa_center)
draw_set_alpha(image_alpha)
draw_set_font(fnt_HUDnum)
textDropShadow("Don't forget to save!",x,y,c_white,c_black,2)

dispTime-=1
if dispTime<=0
{
  image_alpha-=0.04
  if image_alpha<=0 {instance_destroy()}
}
