#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: spinSpd
event_inherited()
sprite_index=sScaledCollision
image_xscale=2
image_yscale=8

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
atkPower=12

laserProg=0
maxLength=320

colTime=0
colPhase=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //Color change
  if colPhase=0
  {
    colTime-=5
    if colTime<=135 {colPhase=1}
  }
  else if colPhase=1
  {
    colTime+=5
    if colTime>=255 {colPhase=0}
  }

  if laserProg=0
  {
    if image_xscale<maxLength {image_xscale+=2}
  }
  else if laserProg=1
  {
    image_xscale-=4
    if image_xscale<=4 {instance_destroy()}
  }
  image_angle-=spinSpd
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
image_blend=make_color_rgb(255,255,colTime)
draw_sprite_ext(sVP_LaserBeam,0,x,y,image_xscale,1,image_angle,image_blend,1)
draw_sprite_ext(sVP_LaserBorder,0,x,y,image_xscale,1,image_angle,c_white,1)
//draw_sprite_ext(sChaosLaserBeam,0,x,y,image_xscale,1,image_angle,image_blend,1)
//draw_sprite_ext(sChaosLaserBorder,0,x,y,image_xscale,1,image_angle,c_white,1)
