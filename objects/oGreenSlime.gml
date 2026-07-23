#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-13,-14,13,-1)
image_speed=0.2

//Enemy base statistics
eName="Green Slime"
eLevel=6
maxLife=115
life=maxLife
pointWorth=7
atkPower=3
resType[2]=4
resType[3]=2
baseItemChance=50
baseDropIndex=90
affiliation=2
dieEffect=3

initDir=0
turnTime=0
runAcc=1

jeremyText="It's a slime and... well it's a slime. I mean really, what can I say about it or what strategies could I possibly give you? Uh... don't get hit?"
chaoText="Does every game have to have slimes in it?"
devText="Every game needs a slime enemy... right?"
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0
  {
    if initDir=0
    {
      xVel=runAcc
      if x>oPlayer1.x
        xVel*=-1
      initDir=1
    }
    if xVel>0
      image_xscale=1
    else
      image_xscale=-1

    if x>oPlayer1.x and image_xscale=1
      turnTime+=1
    else if x<oPlayer1.x and image_xscale=-1
      turnTime+=1
    if turnTime>=10
    {
      xVel*=-1
      turnTime=0
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
  enemyStepEvent()
}
