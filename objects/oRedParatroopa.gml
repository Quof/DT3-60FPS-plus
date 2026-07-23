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
runAcc=1.5*gDeltaTime
xVel=runAcc
xRemainder=0 //QWH
yRemainder=0

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
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0
  {
    dirChange+=1
    if dirChange>=60/gDeltaTime
    {
      if xVel>0
        xVel-=runAcc/30*gDeltaTime
      else
        xVel+=runAcc/30*gDeltaTime
      if dirChange>=87/gDeltaTime
      {
        if xVel>0
          xVel=-runAcc
        else
          xVel=runAcc
        dirChange=0
      }
    }
    if isCollisionLeftEdit(1)
      xVel*=-1
    if isCollisionRightEdit(1)
      xVel*=-1

    if xVel>0
      image_xscale=1
    else
      image_xscale=-1

    xRemainder+=xVel
    xMove=round(xRemainder)
    xRemainder-=xMove

    yRemainder+=yVel
    yMove=round(yRemainder)
    yRemainder-=yMove

    moveTo(xMove,yMove)

    if isCollisionSolid()
      y-=2
  }
  enemyStepEvent()
}
