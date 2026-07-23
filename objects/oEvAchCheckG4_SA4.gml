#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
achProg=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if achProg=0
{
  if oPlayer1.x<=512 {achProg=1}
}
else if achProg=1
{
  if oPlayer1.x>=3536
  {
    var tCheckAchieve;
    tCheckAchieve=string_char_at(global.tokenRecognitions,34)
    if tCheckAchieve="0"
    {
      var tAchievement;
      tAchievement=instance_create(0,0,oAchievementNotice)
      tAchievement.myAchievement="Laser Point Precision"; tAchievement.checkNum=34
    }
    achProg=100
  }
}
