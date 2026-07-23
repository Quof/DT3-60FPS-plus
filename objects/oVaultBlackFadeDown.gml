#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
fadeDist=96
pulsate=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
pulsate+=0.05
fadeDist+=sin(pulsate)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_blend_mode(bm_subtract)
draw_rectangle_color(view_xview[0],view_yview[0]-32,view_xview[0]+480,view_yview[0]-32+fadeDist,c_white,c_white,c_black,c_black,0) //top
draw_rectangle_color(view_xview[0],view_yview[0]+384-fadeDist,view_xview[0]+480,view_yview[0]+384,c_black,c_black,c_white,c_white,0) //bottom
draw_set_blend_mode(bm_normal)
