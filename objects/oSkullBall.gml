#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-7,-7,7,7)
image_speed=0.4

//Enemy base statistics
eName="Skull Ball"
eLevel=6
maxLife=5000
life=maxLife
pointWorth=30
atkPower=5
resType[2]=5
resType[3]=2
resType[4]=5
resType[5]=4
baseItemChance=50
affiliation=2
bFixedAP=1
hitSound=global.snd_EnemyHitZelda
dieSound=3
dieEffect=0

xVel=1.8
yVel=1.8
detectDistX=320
detectDistY=320
bBounced=0
abilityDrain=0
if x>oPlayer1.x {xVel*=-1}
if random(10)>=5 {yVel*=-1}

jeremyText="These fly around the room, bouncing off the walls and side of the screen. They also drain arrows when they hit you... for some reason. Maybe they eat wood?"
chaoText="I always grinded exp off these things, it was so easy to do, why not?"
devText="Deciding the difficulty of these first levels in Gate 2 had some hardships. It's the second major area in the game, but it somewhat had to be treated as the first level... again, due to it being the first time melee combat is introduced in the game. Though platforming and getting a handle on jumping physics already took place in Gate 1, so there was no need to ease into that."
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
  if bActive=true and stunnedTime=0 and life>0
  {
    if isCollisionBottom(1) {yVel*=-1}
    if isCollisionLeft(1) {xVel*=-1}
    if isCollisionRight(1) {xVel*=-1}
    if isCollisionTop(1) {yVel*=-1}

    //Keep inside room
    bBounced=0
    if y<0
    {
      yVel*=-1
      bBounced=1
    }
    if y>room_height
    {
      yVel*=-1
      bBounced=1
    }
    if x<0
    {
      xVel*=-1
      bBounced=1
    }
    if x>room_width
    {
      xVel*=-1
      bBounced=1
    }

    if abilityDrain>0 {abilityDrain-=1}

    //Attempt to stay on screen
    if bBounced=0
    {
      if y<view_yview[0] {yVel*=-1}
      if y>view_yview[0]+view_hview[0] {yVel*=-1}
      if x<view_xview[0] {xVel*=-1}
      if x>view_xview[0]+view_wview[0] {xVel*=-1}
    }
    moveTo(xVel,yVel)
  }
  else if life<=0
  {
    tEfCir=instance_create(x,y,oEfCircleBlast)
    tEfCir.image_alpha=0.75; tEfCir.myRad=4; tEfCir.radScl=3; tEfCir.fadeSpeed=0.08
    var tCheckAchieve;
    tCheckAchieve=string_char_at(global.tokenRecognitions,6)
    if tCheckAchieve="0"
    {
      var tAchievement;
      tAchievement=instance_create(0,0,oAchievementNotice)
      tAchievement.myAchievement="30 AP"; tAchievement.checkNum=6
    }
    instance_destroy()
  }
  enemyStepEvent()
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if abilityDrain=0
{
  if global.gameProgress>=700
  {
    global.hudLink_Arrows[0]-=5
    if global.hudLink_Arrows[0]<0 {global.hudLink_Arrows[0]=0}
  }
  abilityDrain=30
}
event_inherited()
