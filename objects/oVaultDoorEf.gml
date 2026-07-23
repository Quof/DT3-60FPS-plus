#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
phase=0
redrawTime=0
mySurface=surface_create(480,352)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
phase+=0.02
redrawTime+=1
if surface_exists(mySurface)
{
  if redrawTime mod 3=0
  {
    surface_set_target(mySurface)
    screen_redraw()
    surface_reset_target()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if surface_exists(mySurface)
{
  draw_surface_wave(mySurface,x,y,1,12,2,phase,x,y,240,192)
}
else
{
  mySurface=surface_create(480,352)
}
