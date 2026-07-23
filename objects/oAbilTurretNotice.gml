#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
lifeTime=20
abilCount=0
textColFill=make_color_rgb(255,248,155)
textColBorder=make_color_rgb(16,8,8)

if global.hudDefend=0 {currAbil="GROUND"}
else if global.hudDefend=1 {currAbil="FLOAT"}
else if global.hudDefend=2 {currAbil="AIR"}
else if global.hudDefend=3 {currAbil="SHOCK"}
else if global.hudDefend=4 {currAbil="MEGA"}
else {instance_destroy()}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
lifeTime-=1
if lifeTime<=10
{
  image_alpha-=0.1
  if lifeTime=0
    instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if view_current=0
{
  draw_set_alpha(image_alpha)
  draw_set_font(fnt_NES)
  draw_set_halign(fa_center)
  textDropShadow(currAbil,oPlayer1.x,oPlayer1.y-62,textColFill,textColBorder,3)
}
