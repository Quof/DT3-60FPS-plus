#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
y-=12
if y<-192 {instance_destroy()}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(0.4)
draw_set_blend_mode(bm_add)
draw_rectangle_color(64,y,416,y+96,c_black,c_black,c_maroon,c_maroon,false)
draw_rectangle_color(64,y+97,416,y+192,c_maroon,c_maroon,c_black,c_black,false)
draw_set_blend_mode(bm_normal)
