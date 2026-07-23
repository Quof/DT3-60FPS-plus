#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite_index=sScaledCollision
image_alpha=0.6
image_speed=0.1
waterFrame=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
waterFrame+=image_speed
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_part_ext(sWaterTopB,waterFrame,0,0,image_xscale,8,x,y,1,1,image_blend,image_alpha)
draw_sprite_part_ext(sWaterOverlay,waterFrame,0,0,image_xscale,image_yscale,x,y+8,1,1,image_blend,image_alpha)
