#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
//gravity=0.25
//gravity_direction=270
waterGrav=0.25 //60fps change (added): gravity is applied in the Step event instead of GM's built-in gravity (see Step)
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
//60fps change (added): spawners set GM's built-in hspeed/vspeed, which GM applies in full every frame (and its gravity
//every frame too), so splashes flew 2x/4x as fast and far at 60/120fps. Take the speed over on the first step and
//move it here, scaled: gravity then move, same order as GM at 30fps.
if speed!=0 {_hspeed=hspeed; _vspeed=vspeed; speed=0}
_vspeed+=waterGrav*gDeltaTime
correctHSpeedVSpeed(self)
image_angle=_direction
image_alpha-=fadeSpd*gDeltaTime
if image_alpha<=0
  instance_destroy()
correctSpeedDirection(self)
