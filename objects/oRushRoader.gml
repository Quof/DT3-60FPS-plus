#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-22,-22,22,-1)
image_speed=0.3

//Enemy base statistics
eName="Rush Roader"
eLevel=17
maxLife=175
life=maxLife
pointWorth=20
atkPower=5
resType[0]=2
resType[1]=2
resType[2]=4
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
turnTime=0
runAcc=4

jeremyText="Nothing special here, but they do have a decent ramming speed."
chaoText="Hey... it's using slopes! I don't remember entities other than you guys being able to use them properly. I guess the Virus has started to modify low level behaviors like that now."
devText="This is the first enemy coded in the DT series to interact with slopes properly. After realizing I had code for handling going up and down slopes with the player object, I simply made a sub-class for enemy objects to use. I'd have allowed them to use the same code the player object did, but the code wasn't very modular. It was still mostly a copy/paste job, and now I only need to attach the slope script to an enemy for them to interact with that."

maxSlope=5
maxDownSlope=4
y-=1
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
      xVel=runAcc
      if x>oPlayer1.x
        xVel*=-1
      initDir=1
    }

    if turnTime<=30
    {
      if x>oPlayer1.x and image_xscale=1
        turnTime+=1
      else if x<oPlayer1.x and image_xscale=-1
        turnTime+=1

      if !isCollisionBottom(1) and turnTime=31 {turnTime=29}
    }
    else
    {
      turnTime+=1
      if turnTime=32 {sprite_index=sRushRoaderTurn}
      else if turnTime>=41
      {
        sprite_index=sRushRoaderRide
        xVel*=-1
        turnTime=0
      }
    }

    if !isCollisionBottom(1)
      yVel+=0.2
    if isCollisionSolid()
      y-=2

    if xVel>0
      image_xscale=1
    else
      image_xscale=-1

    enemySlopeMovement()

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
    tEffect=instance_create(x,y-12,oEffect)
    tEffect.sprite_index=sMMExplosion
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    instance_destroy()
  }
  enemyStepEvent()
}
