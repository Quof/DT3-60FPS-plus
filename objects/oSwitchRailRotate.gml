#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
reHitTime=0
linkFrm=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if reHitTime>0
{
  reHitTime-=1
  if reHitTime=0
    image_blend=c_white
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if reHitTime=0 and other.bCanHitSwitch=1 and global.gamePaused=false
{
  playSound(global.snd_RBSwitch,0,1,1)
  if mySwitch.turnType=turnSymA {mySwitch.turnType=turnSymB}
  else {mySwitch.turnType=turnSymA}
  with oSwitchRailRotate
  {
    image_blend=make_color_rgb(255,120,120)
    reHitTime=20
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

linkFrm+=0.33
myDir=point_direction(x+8,y+8,mySwitch.x+8,mySwitch.y+8)
myDist=point_distance(x+8,y+8,mySwitch.x+8,mySwitch.y+8)
draw_sprite_ext(sZapTrap,linkFrm,x+8,y+8,myDist/32,0.5,myDir,c_blue,0.25)
