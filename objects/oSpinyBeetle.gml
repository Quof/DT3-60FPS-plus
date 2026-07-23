#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-7,-7,7,7)
image_speed=0.2

//Enemy base statistics
eName="Spiny Beetle"
eLevel=4
maxLife=160
life=maxLife
pointWorth=6
atkPower=3
resType[2]=4
resType[3]=1
resType[4]=5
resType[5]=4
baseItemChance=50
pickupDropMod=50
moneyWorth=0
affiliation=1
bGenEnemy=1

initDir=0
runAcc=1*gDeltaTime

jeremyText="Just an annoyance. Unless you have Star Power, you can't fight it. Just avoid these the best you can."
chaoText="Aww, Spinys are cute too! I bet they're just misunderstood. They probably don't want to hurt Mario, they're just percieved that way and are unfairly thrown everywhere by Lakitus."
devText="From a technical standpoint, these things don't even have any code attached to them for Mario stomping.#Hey, not all of these comments are going to be interesting!"
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
    if sprite_index=sSpinyBeetleBall
    {
      if xVel>0
        image_angle-=8*gDeltaTime
      else
        image_angle+=8*gDeltaTime
    }
    else
    {
      if initDir=0
      {
        setCollisionBounds(-8,-14,8,-1)
        xVel=runAcc
        if x>oPlayer1.x
          xVel*=-1
        initDir=1
      }
    }

    yVel+=0.2*gDeltaTime*gDeltaTime
    if isCollisionBottom(1)
    {
      yVel=0
      if sprite_index=sSpinyBeetleBall
      {
        y-=2
        yVel=-1.5
        setCollisionBounds(-8,-14,8,-1)
        sprite_index=sSpinyBeetleWalk
        image_angle=0
        xVel=runAcc
        initDir=1
        if x>oPlayer1.x
          xVel*=-1
      }
    }
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
      instance_destroy()
  }

  if bActive=false and initDir=1
    instance_destroy()
  enemyStepEvent()
}
