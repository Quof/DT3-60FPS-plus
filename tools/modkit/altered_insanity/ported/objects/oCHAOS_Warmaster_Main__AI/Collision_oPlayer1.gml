event_inherited()

if ATTACK_FORM!=3
{
  if bGoombaStomp=1 and superChangeAtk=0 //Achievement
  {
    var tCheckAchieve;
    tCheckAchieve=string_char_at(global.tokenRecognitions,45)
    if tCheckAchieve="0"
    {
      var tAchievement;
      tAchievement=instance_create(0,0,oAchievementNotice)
      tAchievement.myAchievement="Goomba Stomped"; tAchievement.checkNum=45
    }
    bGoombaStomp=0
  }
}
