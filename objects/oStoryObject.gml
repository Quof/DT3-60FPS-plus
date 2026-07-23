#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
depth=50
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Story object script.
Everything set in object creation.
*/
playSound(soundToPlay,0,1,1)
newMessage=instance_create(x-70,y-80,oMessageSign)
newMessage.message=stringToShow
newMessage.fadingTime=fadingTime
newMessage.signSize=boxSize
instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_blend_mode(bm_add)
draw_set_alpha(0.5)
draw_circle_color(bbox_left+(sprite_width/2),bbox_top+(sprite_height/2),24,make_color_rgb(240,160,70),c_black,false)
draw_set_blend_mode(bm_normal)
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
