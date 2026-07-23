#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
textTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
textTime+=1
if textTime>=60
{
  image_alpha-=0.04
  if image_alpha<=0 {instance_destroy()}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_font(fnt_ScreenText)
draw_set_halign(fa_left)
draw_set_alpha(image_alpha)
textDropShadow(screenText,view_xview[0]+x,view_yview[0]+y,image_blend,c_black,3)
