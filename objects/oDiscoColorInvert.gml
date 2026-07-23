#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: xMove,xSize
if global.gamePaused=false
{
  x-=xMove
  if x<view_xview[0]-xSize-32 {instance_destroy()}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
colorInverter(0,xSize,room_height)
