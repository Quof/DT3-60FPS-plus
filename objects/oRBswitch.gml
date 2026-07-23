#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
reHitTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if reHitTime>0
    reHitTime-=1
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
  if global.rbSwitchBlueOn=false
    global.rbSwitchBlueOn=true
  else
    global.rbSwitchBlueOn=false
  with oRBswitch
    reHitTime=20
  //screen_redraw(); sleep(100)
}
#define Collision_oTrapBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if reHitTime=0 and global.gamePaused=false
{
  playSound(global.snd_RBSwitch,0,1,1)
  if global.rbSwitchBlueOn=false
    global.rbSwitchBlueOn=true
  else
    global.rbSwitchBlueOn=false
  with oRBswitch
    reHitTime=20
  //screen_redraw(); sleep(100)
}
#define Collision_oEProjectileBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if reHitTime=0 and global.gamePaused=false
{
  playSound(global.snd_RBSwitch,0,1,1)
  if global.rbSwitchBlueOn=false
    global.rbSwitchBlueOn=true
  else
    global.rbSwitchBlueOn=false
  with oRBswitch
    reHitTime=20
  //screen_redraw(); sleep(100)
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,global.rbSwitchBlueOn,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
