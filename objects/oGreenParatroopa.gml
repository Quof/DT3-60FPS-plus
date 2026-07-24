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
eName="Green Paratroopa"
eLevel=2
maxLife=120
life=maxLife
pointWorth=4
atkPower=2
resType[2]=4
resType[3]=1
resType[4]=5
baseItemChance=50
affiliation=1
initDir=0
weight=100
runAcc=1.2
jeremyText="Bounce bounce bounce. That's all these do."
if global.gameProgress<=6
  jeremyText+=" Until you get your jumping ability, you're gonna have to run under them or wait till they drop off a cliff."
else
  jeremyText+=" Under most circumstances they won't be a problem."
chaoText="Hey Claire, rememeber all the plushies I have of these? They nearly filled an entire side of my room when lined up."
devText="I almost put in the shell bumping mechanic that most 2D Mario games use. And while it would've been a great mechanic for puzzles and general chaos, it fell outside of what I was trying to do. I thought it again after Gate 1 was finished, but by that point, I'd need to go back and redesign the entire zone to include some real use of the shells."
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
    if initDir=false
    {
      xVel=runAcc
      if x>oPlayer1.x
        xVel*=-1
      initDir=true
    }
    yVel+=0.3*gDeltaTime
    if isCollisionBottom(1)
      yVel=-6
    if isCollisionLeft(1)
      xVel*=-1
    if isCollisionRight(1)
      xVel*=-1
    if isCollisionTop(1)
      yVel=0.1

    if xVel>runAcc
      xVel=runAcc
    if xVel<-runAcc
      xVel=-runAcc
    if xVel>0
      image_xscale=1
    else
      image_xscale=-1
    moveTo(xVel*gDeltaTime,yVel*gDeltaTime)
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
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
