#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_alpha=0.33
xx=0
yy=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
xx+=0.25
yy-=0.6
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//draw_background_part_ext(backMetD2,0,0,32,32,x,y,image_xscale,image_yscale,image_blend,image_alpha)
draw_background_tiled_ext(backMetD2,x+xx,y+yy,image_xscale,image_yscale,image_blend,image_alpha)
