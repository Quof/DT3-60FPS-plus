#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: runAcc
event_inherited()
makeActive()
setCollisionBounds(-10,-5,10,5)
image_speed=0

if global.currentMusic=503
{
  baseColor=make_color_rgb(255,160,160)
  image_blend=baseColor
}
else if global.currentMusic=504
{
  baseColor=make_color_rgb(160,160,255)
  image_blend=baseColor
}

//Enemy base statistics
eName="Ripper"
eLevel=25
maxLife=360
life=maxLife
pointWorth=35
atkPower=7
resType[0]=2
resType[1]=2
resType[3]=1
resType[4]=4
resType[5]=5
stunResist=5
baseItemChance=70
baseDropIndex=85
moneyWorth=5
affiliation=5
hitSound=global.snd_MetEnemyHitA
dieSound=4
dieEffect=4
otherColor=baseColor

initDir=0

jeremyText="Rippers go left and right, only turning when hitting a wall. In all the Metroid games, they were often used as platforms when frozen by the Ice Beam. In Super Metroid, you could use the Grapple Beam on them."
chaoText="These never appeared in Metroid Prime, though there was artwork and ingame data for them. The Gliders in Metroid Prime were similar, even down to using the Grapple Beam on them."
devText="The Beam originally was set to deal half damage to these, but Anomaly convinced me it would be better to have them immune to it."

myGrapplePoint=instance_create(x,y,oStrikeChainPoint)
myGrapplePoint.visible=0

alarm[0]=1
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with myGrapplePoint {instance_destroy()}
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.location=106
{
  baseColor=make_color_rgb(30,200,255)
  image_blend=baseColor
  otherColor=baseColor
}
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
      if x>oPlayer1.x {xVel*=-1}
      initDir=1
    }

    if isCollisionLeft(1) {xVel=runAcc}
    if isCollisionRight(1) {xVel=-runAcc}

    if xVel>0 {image_xscale=1}
    else {image_xscale=-1}

    moveTo(xVel,yVel)
    myGrapplePoint.x=x
    myGrapplePoint.y=y
    if myGrapplePoint.bGrappled=0
    {
      baseColor=otherColor
      bCanDealDamage=true
      if image_blend=c_fuchsia {image_blend=baseColor}
    }
    else
    {
      baseColor=c_fuchsia
      image_blend=baseColor
      bCanDealDamage=false
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
