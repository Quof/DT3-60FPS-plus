#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
shotTime=0
atkPower=8
jawAngle=0
jawSpd=1

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("newStart") {shotTime=newStart}
if variable_local_exists("newSpd") {jawSpd=newSpd}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  shotTime+=1*jawSpd
  if shotTime>=shotDelay and shotTime<=shotDelay+19
  {
    if image_xscale=1 {jawAngle-=1*jawSpd}
    else {jawAngle+=1*jawSpd}
  }
  else if shotTime=shotDelay+24
  {
    newAttack=instance_create(x+(8*image_xscale),y+2,oTrapProjectile)
    newAttack.sprite_index=sWolfHeadShot
    newAttack.image_speed=0
    newAttack.image_index=1
    newAttack.atkPower=atkPower
    newAttack.bulletSpeed=7
    if image_xscale=-1 {newAttack.direction=180}
  }
  else if shotTime>=shotDelay+30 and shotTime<=shotDelay+49
  {
    if image_xscale=1 {jawAngle+=1*jawSpd}
    else {jawAngle-=1*jawSpd}
  }
  else if shotTime>=shotDelay+49 {jawAngle=0; shotTime=0}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sWallHeadJaw,0,x,y,image_xscale,image_yscale,jawAngle,image_blend,image_alpha)
