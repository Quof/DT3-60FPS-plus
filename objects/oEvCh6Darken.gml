#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_alpha=0
initVars=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
initVars=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if initVars=1
{
  distToPoint=point_distance(oPlayer1.x,0,0,0)
  image_alpha=(distToPoint/room_width)/1.75
  if image_alpha>=maxDark
    image_alpha=maxDark
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if initVars=1
{
  draw_set_alpha(image_alpha)
  draw_set_color(c_black)
  draw_rectangle(-1,-1,room_width+1,room_height+1,0)
}
