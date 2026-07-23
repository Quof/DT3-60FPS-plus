#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
spinFrm=0
bRunThrough=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bRunThrough=0
  {
    spinFrm+=1
    if spinFrm=3 {image_index=1}
    else if spinFrm=6 {image_index=2}
    else if spinFrm=9 {image_index=3}
    else if spinFrm=12 {image_index=4}
    else if spinFrm=15 {image_index=3}
    else if spinFrm=18 {image_index=2}
    else if spinFrm=21 {image_index=1}
    else if spinFrm=24 {image_index=0; spinFrm=0}
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bRunThrough=0
{
  playSound(global.snd_ComicHit1,0,0.83,30000+(oCh9RingManager.ringColl*1500))
  oCh9RingManager.resetTime=32
  oCh9RingManager.ringColl+=1
  image_index=2
  image_blend=c_black
  bRunThrough=1
}
