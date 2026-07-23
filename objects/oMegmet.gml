#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-7,-14,7,-1)

//Enemy base statistics
eName="Megmet"
eLevel=7
maxLife=120
life=maxLife
pointWorth=9
atkPower=4
resType[1]=2
resType[4]=5
baseItemChance=50
affiliation=2
hitSound=global.snd_EnemyHitZelda
dieSound=3
dieEffect=3

initDir=0
weight=100
runAcc=1.5
highBounce=0
jeremyText="It bounces low twice, and then high on the third. Simple pattern, it's a little fast."
chaoText="I always tried to avoid these, they were so hard to hit."
devText="I always gave these the nickname of 'Hopping Death.' I sucked at Zelda 2 way back, but when I played it more recently, (around 2008) I was able to get through it without ever using a continue. Things like this enemy presented zero difficulty. I always liked to see how fast I could run through areas, and had the timing down really well to jump and stab low for these things."
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

    yVel+=0.6
    if isCollisionBottom(1)
    {
      highBounce+=1
      if highBounce>=3
      {
        yVel=-10
        highBounce=0
      }
      else
        yVel=-6.25

      if x>oPlayer1.x and image_xscale=1
        xVel*=-1
      else if x<oPlayer1.x and image_xscale=-1
        xVel*=-1
    }
    if isCollisionLeft(1)
      xVel=runAcc
    if isCollisionRight(1)
      xVel=-runAcc
    if isCollisionTop(1)
      yVel=0.5

    if xVel>0
      image_xscale=1
    else
      image_xscale=-1

    moveTo(xVel,yVel)
    if isCollisionSolid()
      y-=2

    if y>room_height+24
    {
      if questType>0
        enemyQuest(questType)
      instance_destroy()
    }
  }
  enemyStepEvent()
}
