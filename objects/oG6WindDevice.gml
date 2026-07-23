#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//This changes the direction of Gate 6 wind objects
//Requires: windMax, windID[]
reHitTime=0
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
  image_blend=make_color_rgb(255,120,120)

  for(i=0;i<windMax;i+=1)
  {
    windID[i].direction=windID[i].myDir[windID[i].dirIndex]
    if windID[i].dirIndex=0 {windID[i].dirIndex=1}
    else {windID[i].dirIndex=0}
  }
  reHitTime=20
}
