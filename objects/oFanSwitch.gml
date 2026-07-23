#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: fanMax, fanID[]
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

  for(i=0;i<fanMax;i+=1)
  {
    if fanID[i].spinning=1 {fanID[i].spinning=0}
    else {fanID[i].spinning=1}
  }
  reHitTime=20
}
