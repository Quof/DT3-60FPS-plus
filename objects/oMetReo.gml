#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-14,-13,14,13)
image_speed=0.2

//Enemy base statistics
eName="Reo"
eLevel=23
maxLife=180
life=maxLife
pointWorth=33
atkPower=8
resType[0]=2
resType[1]=2
resType[4]=4
stunResist=2
baseItemChance=65
baseDropIndex=90
moneyWorth=5
affiliation=5
hitSound=global.snd_MetEnemyHitA
dieSound=4
dieEffect=4
weight=150

jumpTime=0

jeremyText="This functions similar to the original Metroid appearance with some slight modifications. It's basically a reverse Sidehopper that jumps more often... No really, just look at its movement pattern!"
chaoText="'These creatures have sharp claws and can withstand several hits.'#Just something I found in the Super Metroid manual. They have the same function as Gerutas from Norfair, though I don't know if we'll see any Gerutas here."
devText="I had actually forgotten to put these in the levels until Slit08 reminded me about them. They were coded, just never placed until about half way through the Gate's development. There were quite a lot of things that were fixed up around that point in the Gate's development."

alarm[0]=1
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
    jumpTime+=1
    if jumpTime=15
    {
      image_speed=0.5
      y+=2
      yVel=10
      if x>=oPlayer1.x {xVel=-4}
      else {xVel=4}
    }

    yVel-=0.4
    if isCollisionBottom(1)
    {
      yVel=-0.1
    }
    if isCollisionLeft(1)
      xVel*=-1
    if isCollisionRight(1)
      xVel*=-1
    if isCollisionTop(1)
    {
      if jumpTime>17 {jumpTime=0}
      image_speed=0.2
      xVel=0; yVel=0
    }

    moveTo(xVel,yVel)
    if isCollisionSolid() {y+=2}
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
