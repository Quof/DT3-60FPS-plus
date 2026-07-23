#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_alpha-=fadeSpd
if image_alpha<=0 {instance_destroy()}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_blend_mode(bm_add)
draw_set_alpha(image_alpha)
draw_set_color(image_blend)
draw_rectangle(x,y,x+size,y+size,0)
draw_set_blend_mode(bm_normal)
