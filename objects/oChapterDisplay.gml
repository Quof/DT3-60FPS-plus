#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
displayTime=0
image_alpha=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
displayTime+=1*gDeltaTime
if displayTime>=1 and displayTime<=50
  image_alpha+=0.02*gDeltaTime
else if displayTime>=150
{
  image_alpha-=0.02*gDeltaTime
  if image_alpha<=0
    instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_font(fnt_Chapter)
draw_set_halign(fa_center)
draw_set_alpha(image_alpha)
textDropShadow(newChapter,view_xview[0]+240,view_yview[0]+84,c_black,c_white,4)
