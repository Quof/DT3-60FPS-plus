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
displayTime+=1
if displayTime>=1 and displayTime<=25
  image_alpha+=0.04
else if displayTime>=95
{
  image_alpha-=0.04
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
draw_set_halign(fa_left)
draw_set_alpha(image_alpha)
textDropShadow(bossName,view_xview[0]+120,view_yview[0]+84,c_black,c_white,4)
draw_set_font(fnt_HUDnum)
textDropShadow(bossTitle,view_xview[0]+120,view_yview[0]+120,c_black,c_white,4)
