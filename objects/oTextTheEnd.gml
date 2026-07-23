#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_alpha=0
textProg=0
textTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if textProg=0 //50+60+50=160
{
  image_alpha+=0.02
  if image_alpha>=1 {textProg=1}
}
else if textProg=1
{
  textTime+=1
  if textTime>=60
  {
    image_alpha-=0.02
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_font(fnt_GameOver)
draw_set_halign(fa_center)
draw_set_alpha(image_alpha)
textDropShadow("The End?",view_xview[0]+240,view_yview[0]+160,c_white,c_black,4)
