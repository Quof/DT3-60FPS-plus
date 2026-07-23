#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_alpha-=fadeAlpha*gDeltaTime
image_angle+=imageRot*gDeltaTime
if speed<=0
  instance_destroy()
