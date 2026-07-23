#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: fadeSpd
sW=view_wview[0]
sH=view_hview[0]

screenCap=surface_create(view_wview[0],view_hview[0])
surface_set_target(screenCap)
with oScreenEffect
  visible=0
screen_redraw()
with oScreenEffect
  visible=1
surface_reset_target()
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_alpha-=fadeSpd
if image_alpha<=0
{
  if surface_exists(screenCap) {surface_free(screenCap)}
  instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if surface_exists(screenCap)
{
  draw_surface_stretched_ext(screenCap,x,y,sW,sH,image_blend,image_alpha)
}
