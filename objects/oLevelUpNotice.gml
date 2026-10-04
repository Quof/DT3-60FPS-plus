#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
_vspeed=-4
_hspeed=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
_vspeed+=0.2*gDeltaTime; yGravBias=0.2 //(no braces: GM8 treats code that starts with a block as only that block)
if _vspeed>=-0.25
{
  image_alpha-=0.04*gDeltaTime
  if image_alpha<=0 {instance_destroy()}
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
  if global.optShowHUD=1 {draw_self()}
}
