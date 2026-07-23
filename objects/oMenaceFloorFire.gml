#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
atkPower=8
bCanTakeDamage=false
bShowHealthBar=false

image_speed=0.33
image_angle=270
image_alpha=0.85
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index+1,x,y,2.5,2.5,image_angle,image_blend,0.2)
draw_sprite_ext(sprite_index,image_index+1,x,y,1.75,1.75,image_angle,image_blend,0.3)
event_inherited()
