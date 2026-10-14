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
