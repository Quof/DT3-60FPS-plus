#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
phase=0
image_xscale=2
if global.location=55 {image_alpha=0.55}
else {image_alpha=0.45}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
phase+=0.02
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_blend_mode(bm_add)
draw_sprite_wave(sprite_index,image_index,view_xview[0]-16,view_yview[0]-64,1,12,2,phase)
draw_sprite_wave(sprite_index,image_index,view_xview[0]-16,view_yview[0]+192,1,12,2,phase)
draw_set_blend_mode(bm_normal)
