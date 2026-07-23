#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-20,-22,20,-1)
image_speed=0

//Enemy base statistics
eName="Atareeter"
eLevel=18
maxLife=310
life=maxLife
pointWorth=22
atkPower=7
resType[0]=2
resType[1]=1
stunResist=5
baseItemChance=65
baseDropIndex=75
moneyWorth=5
affiliation=4
hitSound=global.snd_EnemyHitMM
dieSound=0
dieEffect=0
initDir=0
runAcc=0.5
inactiveDist*=1.5

startUp=0
spikeDrop=0
spikeAmt=0

jeremyText="In their original role, they had the same movement you see here, but they ate up the ground and left spikes within the ground itself. Here, they simply leave death spikes behind them. It's advisable to get rid of them as soon as possible. I believe they have a limit of 12 spikes, but that's plenty to get in your way."
chaoText="Isn't it unfair that the spikes stay even after destroying them? I think it is! You don't think Sigma will use these in really unfair situations do you?"
devText="The order in which each stage was made was Storm Eagle -> Overdrive Ostrich -> Toxic Seahorse. The testers pointed out that there were 2 birds in this group and wondered if I did that intentionally. It wasn't intentional, but after that realization, it was tempting to change the third to a bird from X3. You can see the decision I made."
extraInfo="Moderate stun resist."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0 and life>0
  {
    if initDir=0
    {
      if x>oPlayer1.x {image_xscale=-1}
      initDir=1
    }

    spikeDrop+=1
    if startUp=0
    {
      if spikeDrop=8 {image_index=1}
      else if spikeDrop=16 {xVel=runAcc*image_xscale; image_index=2; spikeDrop=-1; startUp=1}
    }
    else if startUp=1
    {
      if xVel>0
        image_xscale=1
      else
        image_xscale=-1

      if spikeDrop mod 32=0
      {
        if spikeAmt<12
        {
          var newSpike;
          newSpike=instance_create(x-(8*image_xscale),y-16,oStaticSpike)
          spikeAmt+=1
        }
      }

      if spikeDrop mod 11=0
      {
        if image_index=2 {image_index=3}
        else {image_index=2}
      }
    }

    yVel+=0.2
    if isCollisionBottom(1)
      yVel=0
    if isCollisionLeft(1)
      xVel=runAcc
    if isCollisionRight(1)
      xVel=-runAcc
    if isCollisionSolid()
      y-=2

    moveTo(xVel,yVel)
    if y>room_height+24
    {
      if questType>0
        enemyQuest(questType)
      instance_destroy()
    }
  }
  else if life<=0
  {
    playSound(global.snd_EnemyDieMM,0,1,1)
    tEffect=instance_create(x,y-18,oEffect)
    tEffect.sprite_index=sMMExplosion
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    instance_destroy()
  }
  enemyStepEvent()
}
