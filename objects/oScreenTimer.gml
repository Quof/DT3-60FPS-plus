#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false and global.forceTime>0
  global.forceTime-=1
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.forceTime>0
{
  draw_set_alpha(image_alpha)
  draw_set_halign(fa_left)
  draw_set_font(fnt_Timer)
  textDropShadow(global.forceTime,view_xview[0]+x,view_yview[0]+y,mainColor,shadowColor,type)
}
