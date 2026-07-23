#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=1

//Enemy base statistics
eName="Bad Smiley"
eLevel=35
maxLife=10
life=maxLife
pointWorth=50
atkPower=1
for(i=0;i<6;i+=1)
{
  resType[i]=5
}
dieEffect=0
baseItemChance=50
baseDropIndex=50

jeremyText="Why do these exist? Why are bad smileys allowed to exist...? Just destroy it you guys... just... destroy it!"
chaoText="What Jeremy said. Burn it!"
devText="I hate bad smileys... a lot."

deathAnim=0

var tCheckAchieve;
tCheckAchieve=string_char_at(global.tokenRecognitions,40)
if tCheckAchieve="1" {instance_destroy()}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if life<=0
  {
    deathAnim+=1
    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_HardHit1,0,0.9,1)}
      tEffect=instance_create(x+random_range(-9,9),y+random_range(-8,8),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.04
    if image_alpha<0
    {
      var tCheckAchieve;
      tCheckAchieve=string_char_at(global.tokenRecognitions,40)
      if tCheckAchieve="0"
      {
        var tAchievement;
        tAchievement=instance_create(0,0,oAchievementNotice)
        tAchievement.myAchievement="Burn Bad Smileys"; tAchievement.checkNum=40
      }
      instance_destroy()
    }
  }
  enemyStepEvent()
}
