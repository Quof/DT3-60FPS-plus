#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: maxSize
event_inherited()
setCollisionBounds(-1,-1,1,1)
image_speed=0
image_xscale=0.2; image_yscale=0.2
image_alpha=0.5

damageType="SPECIAL"
weaponTag=105
bCanPierce=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  image_xscale+=0.2*global.speedMod; image_yscale+=0.2*global.speedMod
  if image_xscale>=maxSize {instance_destroy()}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_blend_mode(bm_add)
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_set_blend_mode(bm_normal)
