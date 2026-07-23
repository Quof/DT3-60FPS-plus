#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
buttonProg=0
resetTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if resetTime>0
{
  resetTime-=1
  if resetTime=0 {buttonProg=0}
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if oKeyCodes.kCodePressed[4]=1
  {
    resetTime=20
    buttonProg+=1
    if buttonProg=4
    {
      var tCheckAchieve;
      tCheckAchieve=string_char_at(global.tokenRecognitions,4)
      if tCheckAchieve="0"
      {
        var tAchievement;
        tAchievement=instance_create(0,0,oAchievementNotice)
        tAchievement.myAchievement="Call of Dootied"; tAchievement.checkNum=4
      }
    }
  }
}
