#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.recCopierBroken+=1
if global.recCopierBroken=5
{
  var tCheckAchieve;
  tCheckAchieve=string_char_at(global.tokenRecognitions,16)
  if tCheckAchieve="0"
  {
    var tAchievement;
    tAchievement=instance_create(0,0,oAchievementNotice)
    tAchievement.myAchievement="Zephyr Loves You"; tAchievement.checkNum=16
  }
}
awardAwesome(250)
playSound(global.snd_BombExplode,0,0.94,1)
tEffect=instance_create(bbox_left+(sprite_width/2),bbox_top+(sprite_height/2),oEffect)
tEffect.sprite_index=sRobotExplosion; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
instance_destroy()
