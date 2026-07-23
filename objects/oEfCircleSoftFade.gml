#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: myRad, radScl, fadeSpeed
myRad+=radScl
image_alpha-=fadeSpeed
if image_alpha<=0 {instance_destroy()}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(image_alpha)
draw_set_color(image_blend)
draw_set_blend_mode(bm_add)
draw_circle_color(x,y,myRad,c_black,c_white,0)
draw_set_blend_mode(bm_normal)
