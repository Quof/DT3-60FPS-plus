#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
gravity=0.25
gravity_direction=270
_direction=0
_speed=0
_hspeed=0
_vspeed=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_angle=_direction
image_alpha-=fadeSpd*gDeltaTime
if image_alpha<=0
  instance_destroy()
correctSpeedDirection(self)
