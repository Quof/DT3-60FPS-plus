#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-13,-50,13,-1)
image_speed=0.075
image_alpha=0.75

//Enemy base statistics
eName="Invisible Man"
eLevel=15
maxLife=600
life=maxLife
pointWorth=16
atkPower=5
resType[1]=5
resType[3]=2
stunResist=7
baseItemChance=55
baseDropIndex=90
moneyWorth=5
affiliation=3
dieEffect=0
runAcc=1

deathAnim=0

jeremyText="Does nothing but seek you out. They're very durable, but if you use the right weapon, you can take them out easy."
chaoText="Eww, partially invisible enemies. This thing can give you some trouble when scanning it too, not sure if you had any problems with that or not."
devText="Believe it or not, I sometimes forget that I placed these in the game and don't see them... I guess they do their job well."
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

    yVel+=0.2
    if isCollisionBottom(1)
      yVel=0
    if isCollisionLeft(1)
      xVel=runAcc
    if isCollisionRight(1)
      xVel=-runAcc
    if isCollisionSolid()
      y-=2
    if xVel>0
      image_xscale=1
    else
      image_xscale=-1
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
