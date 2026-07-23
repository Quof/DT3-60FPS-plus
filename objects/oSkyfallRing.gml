#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: moveSpd
image_speed=0
image_angle=90
spinFrm=0

oEvCh21Falling.skyRingOffset+=40
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
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

  y-=moveSpd
  if y<=-32 {instance_destroy()}
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSound(global.snd_ComicHit1,0,0.85,1)
oEvCh21Falling.skyRingAmt+=1
if oEvCh21Falling.skyRingAmt=23
{
  var tCheckAchieve;
  tCheckAchieve=string_char_at(global.tokenRecognitionsSetTwo,8)
  if tCheckAchieve="0"
  {
    var tAchievement;
    tAchievement=instance_create(0,0,oAchievementNoticeSS)
    tAchievement.myAchievement="Pointless Rings"; tAchievement.checkNum=8
  }
}
instance_destroy()
