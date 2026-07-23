#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=0.9; image_yscale=0.9
image_speed=0

//Enemy base statistics
bShowHealthBar=0
bShowDamage=0
bCanTakeDamage=0
bCanDealDamage=0
atkPower=10

explodeProg=0
circleWarnRad=16
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if explodeProg=0
  {
    circleWarnRad-=0.33
    if circleWarnRad<=0
    {
      bCanDealDamage=1
      explodeProg=1
    }
  }
  else if explodeProg=1
  {
    image_index+=0.5
    if image_index>=image_number-0.5 {instance_destroy()}
  }
}
#define Collision_oIdentifier
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bCanDealDamage=true and global.gamePaused=false
{
  with oPlayer1
    hitPlayer(other.id)
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if explodeProg=0
{
  draw_set_alpha(1)
  draw_set_color(c_red)
  draw_circle(x,y,circleWarnRad,1)
  draw_circle(x,y,circleWarnRad+1,1)
}
else if explodeProg=1
{
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}
