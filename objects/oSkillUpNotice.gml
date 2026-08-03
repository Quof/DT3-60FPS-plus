#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
_vspeed=-4
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
_vspeed+=0.2*gDeltaTime
if _vspeed>=-0.25
{
  image_alpha-=0.04*gDeltaTime
  if image_alpha<=0
    instance_destroy()
}
correctHSpeedVSpeed(self)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if view_current=0
{
  draw_self()
}
