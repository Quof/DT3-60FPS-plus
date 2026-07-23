#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_alpha=0.25
sX=0
sY=0
sW=view_wview[0]
sH=view_hview[0]
cR=255
cG=255
cB=255

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
sX-=12
sY-=12
sW+=24
sH+=24
image_alpha-=0.01
cR-=12
cG-=0
cB-=0
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
  draw_surface_stretched_ext(screenCap,view_xview[0]+sX,view_yview[0]+sY,sW,sH,make_color_rgb(cR,cG,cB),image_alpha)
}
