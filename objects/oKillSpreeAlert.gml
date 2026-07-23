#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
fadeTime=80
textColorMain=make_color_rgb(192,248,136)
textColorShadow=make_color_rgb(16,16,16)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
fadeTime-=1
if fadeTime<=20 {image_alpha-=0.05}
if fadeTime<=0 {instance_destroy()}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_halign(fa_center)
draw_set_font(fnt_UnrealGuy)
draw_set_alpha(image_alpha)
textDropShadow(currentKillSpree,view_xview[0]+240,view_yview[0]+76,textColorMain,textColorShadow,4)
