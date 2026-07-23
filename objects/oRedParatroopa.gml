#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-7,-22,7,-1)
image_speed=0.2

//Enemy base statistics
eName="Red Paratroopa"
eLevel=3
maxLife=150
life=maxLife
pointWorth=5
atkPower=2
resType[2]=4
resType[3]=1
resType[4]=5
baseItemChance=50
affiliation=1
weight=100
dirChange=0
runAcc=1.5
xVel=runAcc
if x>oPlayer1.x
  xVel*=-1
jeremyText="These red koopas only patrol left and right... What? That's all there is to say about them."
if global.gameProgress<=50
  jeremyText=jeremyText +string(" At this time, there's nothing to add.")
chaoText="I have a lot of plushies of these too. Oh, I have sooo many koopa plushies!"
devText="I know it might be seen as lazy to reuse enemies that were in the first game, but... hey I'm one guy coding this entire game. That's my excuse! :P Plus a flying enemy that stays in one general area is incredibly useful."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false && gDeltaDoTicks != 0
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0
  {
    dirChange+=1
    if dirChange>=60
    {
      if xVel>0
        xVel-=runAcc/30
      else
        xVel+=runAcc/30
      if dirChange>=87
      {
        if xVel>0
          xVel=-runAcc
        else
          xVel=runAcc
        dirChange=0
      }
    }
    if isCollisionLeft(1)
      xVel*=-1
    if isCollisionRight(1)
      xVel*=-1

    if xVel>0
      image_xscale=1
    else
      image_xscale=-1
    moveTo(xVel,yVel)
    if isCollisionSolid()
      y-=2
  }
  enemyStepEvent()
}
