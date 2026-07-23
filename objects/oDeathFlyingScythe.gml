#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCanDealDamage=false
atkProg=0
circleRad=20
spinSpd=-15
decayTime=240
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if direction>90 and direction<270
{
  spinSpd*=-1
  image_xscale=-1
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if atkProg=0
  {
    circleRad-=1
    if circleRad<=0
    {
      bCanDealDamage=true
      atkProg=1
    }
  }
  else if atkProg=1
  {
    speed=bulletSpeed
    image_angle+=spinSpd
    decayTime-=1
    if decayTime<=0 {instance_destroy()}
  }
}
else {speed=0}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if decayTime<=180 {instance_destroy()}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if atkProg=0
{
  draw_set_color(c_white)
  draw_set_alpha(1)
  draw_circle(x,y,circleRad,1)
}
if atkProg=1
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
