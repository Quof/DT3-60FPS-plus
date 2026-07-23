#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-14,-56,14,-1)
image_speed=0.075

//Enemy base statistics
eName="Desert Titan"
eLevel=22
maxLife=700
life=maxLife
pointWorth=33
atkPower=6
resType[0]=2
resType[2]=4
resType[3]=2
resType[4]=4
resType[5]=2
stunResist=6
baseItemChance=75
moneyWorth=10
dieEffect=0

runAcc=1
rockTime=60
rockDelay=140

deathAnim=0

jeremyText="This is a large hulking mass of possible annoyance. It only tracks you slowly left and right, however it will periodically stop. When it does this, it summons a bunch of rocks from above it, which will all drop. I don't recommend leaving these around at high places."
chaoText="That's not very fair that none of these have to deal with the heat like you do."
devText="The heat/water mechanic in this area was borrowed from another early game I made which featured a large desert. It used an overhead perspective and water wasn't always easy to find."
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
    rockTime+=1
    if rockTime<rockDelay
    {
      if x>oPlayer1.x
      {
        xVel=-runAcc
        image_xscale=-1
      }
      else if x<oPlayer1.x
      {
        xVel=runAcc
        image_xscale=1
      }
    }
    else if rockTime>=rockDelay and rockTime<=rockDelay+500
    {
      xVel=0
      rockTime=1000
    }
    else if rockTime>=1010 and rockTime mod 6=0
    {
      var tNewAttack;
      tNewAttack=instance_create(x+random_range(-96,96),y-120,oGravPassBullet)
      tNewAttack.sprite_index=sDTitanRock; tNewAttack.atkPower=atkPower
      tNewAttack.xVel=0; tNewAttack.yVel=1
    }
    if rockTime>=1050 {rockTime=0}

    yVel+=0.2
    if isCollisionBottom(1)
      yVel=0
    if isCollisionLeft(1)
      xVel=runAcc
    if isCollisionRight(1)
      xVel=-runAcc
    if isCollisionSolid()
      y-=2

    if rockTime<rockDelay
    {
      if xVel>0 {image_xscale=1}
      else {image_xscale=-1}
    }

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
    if deathAnim mod 2=0
    {
      if deathAnim mod 6=0 {playSound(global.snd_HardHit1,0,0.9,1)}
      tEffect=instance_create(x+random_range(-14,14),y-1-random(51),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.04
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
