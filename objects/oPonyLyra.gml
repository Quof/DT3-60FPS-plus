#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.5
myDir=0
endLeft=1200
endRight=1616
runSpd=3

collAchChk=string_char_at(global.tokenRecognitionsSetTwo,3)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if myDir=0
  {
    x+=runSpd
    if x>=endRight
    {
      image_xscale=-1
      myDir=1
    }
  }
  else if myDir=1
  {
    x-=runSpd
    if x<=endLeft
    {
      image_xscale=1
      myDir=0
    }
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if collAchChk="0"
{
  var tCheckAchieve;
  tCheckAchieve=string_char_at(global.tokenRecognitionsSetTwo,3)
  if tCheckAchieve="0"
  {
    var tAchievement;
    tAchievement=instance_create(0,0,oAchievementNoticeSS)
    tAchievement.myAchievement="Magical Friendship"; tAchievement.checkNum=3
  }
  collAchChk="1"
}
