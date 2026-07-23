#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
gravity=0.25
gravity_direction=270
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_angle=direction
image_alpha-=fadeSpd
if image_alpha<=0
  instance_destroy()
