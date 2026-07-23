#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-10,-22,10,-1)
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
eName="Cacatac"
eLevel=25
maxLife=300
life=maxLife
pointWorth=37
atkPower=8
resType[0]=2
resType[1]=2
resType[2]=4
resType[4]=4
stunResist=5
baseItemChance=75
baseDropIndex=80
moneyWorth=10
affiliation=5
hitSound=global.snd_MetEnemyHitA
dieSound=4
dieEffect=4

runAcc=0.5
spikeTime=0

jeremyText="This takes a few steps, then stops to fire needles in 5 directions around it. They did the same in Super Metroid, but these have been sped up."
chaoText="In Super Metroid, these are first encountered in Brinstar, but other variations/palette swaps can be found in Norfair and Maridia. There weren't any differences between them though."
devText="Gate 5 was the hardest of the Gate levels to make. There were a lot of complications that I didn't anticipate that came up. It took some time, but everything came together in the end. Was definitely a learning experience. The Gate simply wasn't planned out well enough."
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
    spikeTime+=1
    if spikeTime=1 //Walk to player
    {
      image_speed=0.16
      if x>=oPlayer1.x {xVel=-runAcc}
      else {xVel=runAcc}
    }
    else if spikeTime=40 //Stop and get ready to fire spikes
    {
      sprite_index=sMetCacatacGrow
      image_speed=0; image_index=0
      xVel=0
    }
    else if spikeTime=45 {image_index=1}
    else if spikeTime=50 {image_index=2}
    else if spikeTime=55 //Fire spikes
    {
      sprite_index=sMetCacatacWalk
      image_index=0
      var tNewAttack,tDir;
      tDir=0
      for(i=0;i<5;i+=1)
      {
        tNewAttack=instance_create(x,y-12,oNormalBullet)
        tNewAttack.sprite_index=sCacatacNeedle; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=6
        tNewAttack.direction=tDir; tNewAttack.image_blend=baseColor
        tDir+=45
      }
      spikeTime=0
    }

    yVel+=0.3
    if isCollisionBottom(1)
      yVel=0
    if isCollisionLeft(1)
      xVel=runAcc
    if isCollisionRight(1)
      xVel=-runAcc
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
