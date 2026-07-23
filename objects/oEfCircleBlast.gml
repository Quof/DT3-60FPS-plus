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
draw_circle(x,y,myRad,0)
