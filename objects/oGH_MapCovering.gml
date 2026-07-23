#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if collision_rectangle(x,y,x+(image_xscale*16),y+(image_yscale*16),oPlayer1,0,1)
  {
    if image_alpha>0 {image_alpha-=0.1}
  }
  else if collision_rectangle(x,y,x+(image_xscale*16),y+(image_yscale*16),oGH_DummyDoor,0,1)
  {
    if image_alpha>0 {image_alpha-=0.1}
  }
  else
  {
    if image_alpha<1 {image_alpha+=0.1}
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(image_alpha)
draw_set_color(c_black)
draw_rectangle(x,y,x+(image_xscale*16),y+(image_yscale*16),0)
