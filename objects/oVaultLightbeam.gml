#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite_index=sLightbeam
image_blend=make_color_rgb(170,170,255)
pulse=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
pulse+=1
if pulse>=1 and pulse<=40 {image_alpha+=0.0005}
else if pulse>=41 and pulse<=80
{
  image_alpha-=0.0005
  if pulse=80 {pulse=0}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if checkScreenArea(x,y,abs(sprite_width+4))=1
{
  draw_set_blend_mode(bm_add)
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  draw_set_blend_mode(bm_normal)
}
