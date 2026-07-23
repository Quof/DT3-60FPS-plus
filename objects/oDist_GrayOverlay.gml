#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
wallX=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=0
{
  wallX+=1
  if wallX>=room_width/2
  {
    instance_destroy()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(0.4)
draw_set_color(c_gray)
draw_rectangle(0,0,wallX,room_height,0)
draw_rectangle(room_width-wallX,0,room_width,room_height,0)
