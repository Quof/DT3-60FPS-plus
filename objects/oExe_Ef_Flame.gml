#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=0
{
  image_angle-=15
  image_alpha-=0.05
  if image_alpha<=0 {instance_destroy()}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x+13,y-21,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sprite_index,image_index,x-13,y-21,image_xscale,image_yscale,-image_angle,image_blend,image_alpha)
draw_sprite_ext(sprite_index,image_index,x+13,y,image_xscale,image_yscale,-image_angle,image_blend,image_alpha)
draw_sprite_ext(sprite_index,image_index,x-13,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sprite_index,image_index,x+13,y+21,image_xscale,image_yscale,-image_angle,image_blend,image_alpha)
draw_sprite_ext(sprite_index,image_index,x-13,y+21,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
