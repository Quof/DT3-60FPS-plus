#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
fadingTime=70
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if fadingTime>0
{
  fadingTime-=1
  if fadingTime<=20
    image_alpha-=0.05
}
else
  instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_set_font(fnt_EnemyChat)
draw_set_halign(fa_left)
draw_set_alpha(image_alpha)
draw_set_color(make_color_rgb(255,248,155))
draw_text_ext(x+6,y+2,enemyMessage,12,80)
