#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: moveSpd
image_blend=make_color_rgb(178,184,196)
image_alpha=0.7
image_xscale=0.33
image_yscale=0.33
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  x+=moveSpd
  if x>=room_width+abs(sprite_width) {instance_destroy()}
}
