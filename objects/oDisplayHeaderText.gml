#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
textColorMain=make_color_rgb(240,240,240)
textColorShadow=make_color_rgb(12,12,12)
decayTime=180
drawY=306
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if instance_exists(oLocationDisplay) {drawY=306}
else {drawY=326}

decayTime-=1
if decayTime<=20 {image_alpha-=0.05}
if decayTime<=0 {instance_destroy()}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if view_current=0
{
  draw_set_font(fnt_EnemyChat)
  draw_set_halign(fa_left)
  draw_set_alpha(image_alpha)
  textDropShadowExt(room_caption,view_xview[0]+8,view_yview[0]+drawY,textColorMain,textColorShadow,4,14,464)
}
