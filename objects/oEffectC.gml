#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: rotation,moveArc,fadeSpd,scaleSpd
image_angle+=rotation
direction+=moveArc

image_alpha-=fadeSpd
if image_alpha<=0 {instance_destroy()}

image_xscale-=scaleSpd; image_yscale-=scaleSpd
if image_xscale<=0 {instance_destroy()}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if newBlend!=-1
{
  draw_set_blend_mode(bm_add)
  if followID!=-1
  {
    if instance_exists(followID)
      draw_sprite_ext(sprite_index,image_index,followID.x+xFollow,followID.y+yFollow,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  }
  else
  {
    if instance_exists(followID)
      draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  }
  draw_set_blend_mode(bm_normal)
}
else
{
  if followID!=-1
  {
    if instance_exists(followID)
      draw_sprite_ext(sprite_index,image_index,followID.x+xFollow,followID.y+yFollow,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  }
  else
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}
