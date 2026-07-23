#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-7,-14,7,-1)
image_speed=0.15

//Enemy base statistics
eName="Monster Crab"
eLevel=13
maxLife=220
life=maxLife
pointWorth=16
atkPower=4
resType[2]=4
resType[4]=2
stunResist=1
baseItemChance=55
baseDropIndex=90
dieEffect=0
initDir=0
runAcc=3
turnTime=30+irandom(30)

deathAnim=0
yDeath=0

jeremyText="These have somewhat erratic movement. At times, it will change direction without warning, I advise keeping your distance. They also know when they're on the edge of a cliff and will turn around."
chaoText="This doesn't look all that threatening with its goofy smile. Claire, you're probably better suited to handle these guys."
devText="Chapter 7 is the first time the game will push the player to swap in the right character for various situations. It does need to be kept somewhat simple though, since it's the first time the game requires it. I wanted to ease the player into this game's concepts at a steadier pace."
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

    //Turn around if turn timer is 0
    turnTime-=1
    if turnTime=0
    {
      xVel*=-1
      turnTime=30+irandom(30)
    }

    //Check if at cliff edge and turn around
    tDrop=0
    if aiCheckHoriz(1,1,0,8,4)
    {
      if aiCheckVert(0,1,8,8,4)=1
      {
        tDrop=1
      }
    }
    if tDrop=0
    {
      xVel*=-1
      turnTime=45+irandom(45)
    }

    yVel+=0.2
    if isCollisionBottom(1)
      yVel=0
    if isCollisionLeft(1)
      xVel*=-1
    if isCollisionRight(1)
      xVel*=-1
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
    if deathAnim=1
    {
      sprite_index=sWB_Crab_Die
      yDeath=-6
    }
    else if deathAnim>=2
    {
      y+=yDeath
      if yDeath<12 {yDeath+=0.3}
      if y>room_height+24 {instance_destroy()}
    }
  }
  enemyStepEvent()
}
