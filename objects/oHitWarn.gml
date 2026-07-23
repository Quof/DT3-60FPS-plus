#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_alpha-=0.1
if image_alpha<=0 {instance_destroy()}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if view_current=0
{
  draw_sprite_ext(sHitWarn,0,view_xview[0],view_yview[0]-1,1.5,1.5,90,image_blend,image_alpha) //top-right
  draw_sprite_ext(sHitWarn,0,view_xview[0]+view_wview[0],view_yview[0],1.5,1.5,0,image_blend,image_alpha) //top-left
  draw_sprite_ext(sHitWarn,0,view_xview[0]+view_wview[0],view_yview[0]+view_hview[0],1.5,1.5,270,image_blend,image_alpha) //bottom-right
  draw_sprite_ext(sHitWarn,0,view_xview[0]-1,view_yview[0]+view_hview[0],1.5,1.5,180,image_blend,image_alpha) //bottom-left
}
