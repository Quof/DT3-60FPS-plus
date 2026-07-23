#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-13,-13,13,13)
image_speed=0.5
bCanDealDamage=false
visible=false
bFlyDown=false
flyPicY=y

//Enemy base statistics
eName="Sine Faller"
eLevel=17
maxLife=240
life=maxLife
pointWorth=22
atkPower=5
resType[0]=2
resType[1]=2
resType[2]=5
resType[4]=4
resType[5]=2
stunResist=2
baseItemChance=65
baseDropIndex=75
moneyWorth=5
affiliation=4
hitSound=global.snd_EnemyHitMM
dieSound=0
dieEffect=0
initDir=0
runAcc=1.4
inactiveDist*=1.5

jeremyText="Hey, we've seen this before. Nothing has changed aside from it being faster than before, well unless you remember the 'distorted' times back then. It's fairly durable, but with the right weapon, it's nothing at all."
chaoText="These actually don't behave the way they're supposed to. Sine Fallers in the original source would fly down like they do here, but instead of seeking you like they do here, they would zig-zag down."
devText="I wanted lots of enemy variety for DT3, and of course, that takes a lot of time. Even when making enemies that have similar behaviors. I'm a fan of reusing code, so it only felt right to port this guy over from the first game."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if life>0
  {
    if bActive=true
    {
      if bFlyDown=false
      {
        if visible=false
        {
          visible=true
          y-=352
        }
        y+=12
        if y>=flyPicY
        {
          bCanDealDamage=true
          bFlyDown=true
        }
      }
      if stunnedTime=0 and bFlyDown=true
      {
        if instance_exists(oPlayer1)
        {
          dir=player_sprite_center()
          moveTo(runAcc*cos(degtorad(dir)),-runAcc*sin(degtorad(dir)))
        }
      }
    }
  }
  else
  {
    playSound(global.snd_EnemyDieMM,0,1,1)
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sMMExplosion
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    instance_destroy()
  }
  enemyStepEvent()
}
