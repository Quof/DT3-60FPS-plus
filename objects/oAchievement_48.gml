#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_xscale=4
image_yscale=4
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oGame.time mod 5=0
{
  var tCheckAchieve;
  tCheckAchieve=string_char_at(global.tokenRecognitions,48)
  if tCheckAchieve="0"
  {
    var tAchievement;
    tAchievement=instance_create(0,0,oAchievementNotice)
    tAchievement.myAchievement="Farreaching Bird"; tAchievement.checkNum=48
  }
}
