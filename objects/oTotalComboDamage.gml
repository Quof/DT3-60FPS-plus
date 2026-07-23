#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
decayTime=30
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
decayTime-=1*gDeltaTime
if decayTime<=0
{
  image_alpha-=0.1*gDeltaTime
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
  draw_set_font(fnt_HUDnum)
  draw_set_halign(fa_left)
  draw_set_alpha(image_alpha)
  textDropShadow(string("Total Damage: ") +string(round(damageTotal)),view_xview[0]+17,view_yview[0]+88,c_white,c_black,1)
}
