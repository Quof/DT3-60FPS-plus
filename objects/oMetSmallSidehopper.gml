#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-14,-20,14,-1)
image_speed=0
image_xscale=0.6; image_yscale=0.6

//Enemy base statistics
eName="Small Sidehopper"
eLevel=23
maxLife=230
life=maxLife
pointWorth=32
atkPower=7
resType[0]=2
resType[1]=2
resType[5]=4
stunResist=2
baseItemChance=70
baseDropIndex=85
moneyWorth=5
affiliation=5
hitSound=global.snd_MetEnemyHitA
dieSound=4
dieEffect=4
weight=90

jumpTime=0
jumpCycle=0

jeremyText="These cycle through 2 different hops. One is a low hanging fast hop, the other is a slower high jump. They're not TOO bad. If you wait till they do their high jump, you can just jump over them easily."
chaoText="It's weird that these take 2 missiles in here when in Super Metroid, they only took 1."
devText="These smaller Sidehoppers are just the larger one's sprite scaled down with almost the same AI routine. There is a change to the jump call of the larger one where it checks if the player is in Morph mode. Of course, the larger ones also have a larger HP pool as well. Not a spoiler, you knew the larger variations would show up."
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
    jumpTime+=1
    if jumpTime=18 {image_index=1}
    else if jumpTime=25
    {
      image_index=1
      y-=2
      if checkScreenArea(x,y,48)=1 {playSound(global.snd_MetEnemyMove,0,0.92,42000)}
      if jumpCycle=0 //Low fast jump
      {
        yVel=-4.5
        if x>=oPlayer1.x {xVel=-6}
        else {xVel=6}
        jumpCycle=1
      }
      else if jumpCycle=1 //Hi slow jump
      {
        yVel=-8
        if x>=oPlayer1.x {xVel=-3}
        else {xVel=3}
        jumpCycle=0
      }
    }

    yVel+=0.4
    if isCollisionBottom(1)
    {
      if jumpTime>26 {jumpTime=0}
      xVel=0; yVel=0
      image_index=0
    }
    if isCollisionLeft(1)
      xVel*=-1
    if isCollisionRight(1)
      xVel*=-1
    if isCollisionTop(1)
      yVel=0.1

    moveTo(xVel,yVel)
    if isCollisionSolid() {y-=2}
    if y>room_height+24
    {
      if questType>0 {enemyQuest(questType)}
      instance_destroy()
    }
  }
  enemyStepEvent()
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
