#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-7,-28,7,-1)
image_speed=0.13

//Enemy base statistics
eName="Playful Penguin"
eLevel=30
maxLife=100
life=maxLife
pointWorth=5
atkPower=4
resType[1]=5
resType[2]=1
stunResist=1
baseItemChance=50
baseDropIndex=80

runAcc=1.5
xVel=runAcc
turnTimeA=30
turnTimeB=15
bSpotted=0

jeremyText="All these do is walk back and forth, they really aren't a threat and... they're kinda buggy."
chaoText="Aww, look how cute he... or she looks! Jeremy, I want one! They're so adora... wait... no they aren't. Look at those creepy empty eyes... just... ugh, it's like it's trying to suck out your soul."
devText="Because we haven't had a joke enemy for a long time."
extraInfo="Anyone that hurts these is a horrible person... maybe."
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
    //Turn around if turn timer is 0
    turnTimeA-=1
    if turnTimeA=0
    {
      image_xscale*=-1
      turnTimeA=19
    }
    turnTimeB-=1
    if turnTimeB=0
    {
      xVel*=-1
      turnTimeB=35
    }

    //Check if at cliff edge and turn around
    tDrop=0
    if aiCheckHoriz(1,1,0,8,4)
    {
      if aiCheckVert(0,1,8,8,4)=1
        tDrop=1
    }
    if tDrop=0
    {
      xVel*=-1
      turnTime=25
    }

    yVel+=0.4
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
      if questType>0 {enemyQuest(questType)}
      instance_destroy()
    }
  }
  enemyStepEvent()
}

if bSpotted=0
{
  if checkScreenArea(x,y,2)=1
  {
    global.recBirdsSeen+=1
    bSpotted=1
  }
}
