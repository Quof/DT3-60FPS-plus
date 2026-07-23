#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_blend=make_color_rgb(130,130,255)
image_alpha=0.08
speed=2
direction=180
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if checkScreenArea(x,y,32+string_width(binaryString)*2.5)=0 {instance_destroy()}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_color(image_blend)
draw_set_alpha(image_alpha)
draw_set_font(fnt_VaultBinary)
draw_set_halign(fa_left)
draw_text(x,y,binaryString)
