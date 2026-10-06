#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-5,-6,5,-1)
image_speed=0

//Enemy base statistics
eName="Myu"
eLevel=5
maxLife=80
life=maxLife
pointWorth=5
atkPower=3
resType[1]=2
resType[5]=5
baseItemChance=50
pickupDropMod=20
moneyWorth=0
affiliation=2
hitSound=global.snd_EnemyHitZelda
dieSound=3
dieEffect=3

runAcc=1.1
moveWait=15+irandom(30)
moveTime=0
jumpWait=10+irandom(80)
jumpTime=0

jeremyText="These are slow moving and sometimes make a short hop. They are a bit more jumpy here than the original. You still won't have as much trouble with these as you would in the original game since you can hit the ground with relative ease."
chaoText="Eww, I didn't like these things. They always got in the way and were so annoying."
devText="The difficulty these things had was their size and that none of Link's attacks worked on them. (Other than the downward stab.) Jerry's wide swing mitigates that completely, though their little hop does periodically create a small problem. Due to their hitbox being very small and Jerry's feet not being included in his, he can usually run right over them without taking damage."
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
    //move
    moveTime+=1*gDeltaTime
    if moveTime>=moveWait and jumpTime<jumpWait and yVel=0
    {
      image_index=1
      //y-=4*gDeltaTime
      y-=4 //60fps change: a one-off lift at the start of the hop, not a per-frame move; scaled, it only lifted 1px at 120fps, so the ground check ended the small hop right away
      yVel=-0.2
      if x>oCharacter.x
        xVel=-2
      else
        xVel=2
      moveWait=15+irandom(30)
      moveTime=0
    }
    //jump
    jumpTime+=1*gDeltaTime
    if jumpTime=jumpWait and yVel=0
    {
      image_index=1
      //y-=4*gDeltaTime
      y-=4 //60fps change: one-off lift (see above)
      yVel=-3
      if x>oCharacter.x
        xVel=-2
      else
        xVel=2
    }

    yVel=scrGravAcc(yVel,0.2,1)
    if isCollisionBottom(1)
    {
      image_index=0
      xVel=0
      yVel=0
      if jumpTime>=jumpWait
      {
        jumpWait=60+irandom(100)
        jumpTime=0
      }
    }
    if isCollisionLeft(1)
      xVel=runAcc
    if isCollisionRight(1)
      xVel=-runAcc
    moveTo(xVel*gDeltaTime,yVel*gDeltaTime)
    if isCollisionSolid()
      y-=1
    if y>room_height+30
      instance_destroy()
  }
  enemyStepEvent()
}
