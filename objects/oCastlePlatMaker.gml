#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
platDelay=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if platDelay>0 {platDelay-=1}
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if platDelay=0
{
  var tPlat;
  tPlat=instance_create(x,y,oMCastle_PlatB)
  if image_angle=0 {tPlat.xVel=2; tPlat.yVel=0}
  else if image_angle=90 {tPlat.xVel=0; tPlat.yVel=-2}
  else if image_angle=180 {tPlat.xVel=-2; tPlat.yVel=0}
  else if image_angle=270 {tPlat.xVel=0; tPlat.yVel=2}
  platDelay=90
  if other.bCanPierce=0
  {
    with other {instance_destroy()}
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_self()
if platDelay>0
{
  draw_set_alpha(1)
  draw_set_color(c_black)
  draw_set_font(fnt_GOoptions)
  draw_set_halign(fa_center)
  draw_text(x,y-8,platDelay)
}
