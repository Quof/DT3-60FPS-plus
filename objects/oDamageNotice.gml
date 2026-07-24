#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
hspeed=random_range(-2,2)
vspeed=-random_range(4,6)
dispTime=10

ranChoice=0
drawColor=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
  x -= hspeed
  y -= vspeed
  x += hspeed * gDeltaTime
  y += vspeed * gDeltaTime
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if view_current=0
{
  vspeed+=0.38*gDeltaTime


  draw_set_halign(fa_center)
  draw_set_alpha(image_alpha)

  if damageColor=c_white
  {
    draw_set_font(fnt_HUDnum)
    ranChoice=irandom_range(1,6)
    if ranChoice=1 {drawColor=make_color_rgb(102,46,137)} //purple
    else if ranChoice=2 {drawColor=make_color_rgb(26,152,213)} //blue
    else if ranChoice=3 {drawColor=make_color_rgb(113,239,14)} //green
    else if ranChoice=4 {drawColor=make_color_rgb(255,247,152)} //yellow
    else if ranChoice=5 {drawColor=make_color_rgb(247,137,8)} //orange
    else if ranChoice=6 {drawColor=make_color_rgb(245,16,2)} //red
    textDropShadow(round(damageValue),x,y,drawColor,c_black,2)
  }
  else if damageColor=c_silver
  {
    draw_set_font(fnt_HUDnum)
    textDropShadow(round(damageValue),x,y,drawColor,c_black,2)
  }
  else
  {
    draw_set_font(fnt_EnemyName)
    textDropShadow(round(damageValue),x,y,damageColor,c_black,2)
  }

  dispTime-=1*gDeltaTime
  if dispTime<=0
  {
    image_alpha-=0.05*gDeltaTime
    if image_alpha<=0 {instance_destroy()}
  }
}
