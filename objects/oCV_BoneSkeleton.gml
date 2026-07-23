#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-6,-36,6,-1)
image_speed=0.15

//Enemy base statistics
eName="Bone Skeleton"
eLevel=14
maxLife=310
life=maxLife
pointWorth=17
atkPower=5
resType[2]=2
resType[3]=1
resType[4]=4
stunResist=3
baseItemChance=60
moneyWorth=5
affiliation=3
dieEffect=0

initDir=0
runAcc=1
walkTime=0
walkChange=round(random(20)+30)

shotTime=15
shotDelay=65

deathAnim=0

jeremyText="Moves about a bit, and will throw a bone at an arc."
chaoText="Skeletons make up a large part of Dracula's army and are a basic enemy type seen in the Castlevania series."
devText="Yep, another recycled enemy from DT1. Hey, I couldn't help it. They worked well and were just sitting there, waiting to be used. You will, however, see a lot more variety in the Castlevania enemies this time around. Keep going, they, along with the bosses, are a lot better than in DT1."
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
    walkTime+=1
    if walkTime>=walkChange
    {
      runAcc*=-1
      xVel=runAcc
      walkTime=0
      walkChange=round(random(20)+30)
    }

    shotTime+=1
    if shotTime=shotDelay-18 //begin throw anim
    {
      xVel=0
      sprite_index=sCV_BoneSkeleton_Throw; image_index=0
    }
    if shotTime=shotDelay //throw bone
    {
      if checkScreenArea(x,y,48)=1 {playSound(global.snd_KnightSwordSwing,0,0.9,40000)}
      var tNewAttack;
      tNewAttack=instance_create(x+(-5*image_xscale),y-37,oBS_Bone)
      tNewAttack.atkPower=atkPower
      tNewAttack.xSpd=5*image_xscale; tNewAttack.ySpd=-5
    }
    if shotTime=shotDelay+5 //end bone throw anim
    {
      xVel=runAcc
      if round(random(10))>=5 {runAcc*=-1}
      sprite_index=sCV_BoneSkeleton_Walk
      shotTime=0
    }

    if x>oPlayer1.x {image_xscale=-1}
    else {image_xscale=1}

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
    deathAnim+=1
    image_speed=0
    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_HardHit1,0,0.9,1)}
      tEffect=instance_create(x+random_range(-5,5),y-1-random(35),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.04
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
