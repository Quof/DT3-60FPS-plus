#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-7,-7,7,7)

if global.currentMusic=504
{
  baseColor=make_color_rgb(160,160,255)
  image_blend=baseColor
}

//Enemy base statistics
eName="Multiviola"
eLevel=24
maxLife=160
life=maxLife
pointWorth=31
atkPower=8
damageType="ELEMENTAL"
resType[0]=2
resType[1]=2
resType[2]=4
resType[5]=4
stunResist=3
baseItemChance=70
baseDropIndex=90
moneyWorth=5
affiliation=5
hitSound=global.snd_MetEnemyHitA
dieSound=4
dieEffect=4

xVel=2
yVel=2
detectDistX=320
detectDistY=320
bBounced=0
if x>oPlayer1.x
  xVel*=-1
if random(10)>=5
  yVel*=-1

jeremyText="It's a simple fireball-like creature that bounces around rooms at varying speeds. Nothing fancy, and it won't bounce off the side of the screen like the Skullballs do."
chaoText="These variants of the Viola were found in Norfair and the lower regions of it in Ridley's lair."
devText="The Sidehopper was one of the reasons that I didn't want the dash going through enemies. Mostly, it would have trivialized nearly all encounters unless the enemies were changed to account for the player being completely invincible during the dash. This concept of enemies breaking through the dash will come back later on."

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("spdUp")
{
  xVel*=spdUp
  yVel*=spdUp
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
    if isCollisionBottom(1)
      yVel*=-1
    if isCollisionLeft(1)
      xVel*=-1
    if isCollisionRight(1)
      xVel*=-1
    if isCollisionTop(1)
      yVel*=-1

    moveTo(xVel,yVel)
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
