#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-14,-14,14,-1)
image_speed=0.15

//Enemy base statistics
eName="Monster Scorpion"
eLevel=14
maxLife=400
life=maxLife
pointWorth=23
atkPower=5
resType[0]=2
resType[2]=4
resType[3]=2
stunResist=4
baseItemChance=65
baseDropIndex=95
moneyWorth=5
dieEffect=0
initDir=0
runAcc=2
turnTime=60
scuttleBallTime=0

deathAnim=0
yDeath=0

jeremyText="This is an oddity, as it scuttles along, it kicks up what appears to be dirty balls. If you stay close to it for too long, it'll turn around and try to kick those at you."
chaoText="For being a disgusting scorpion, it's kind of cute. Luckily you've got that Holy Water, Claire. Makes quick work of them."
devText="The idea behind the enemies and their placement in this chapter was set up to encourage the player to swap in the character that's better suited for the situation. If you're having trouble with an obstacle, swap your character and see if the other is more suited for the task."
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
      if x<oPlayer1.x
        xVel*=-1
      initDir=1
    }

    //Turn around if turn timer is 0 and player is close enough
    if point_distance(x,0,oPlayer1.x,0)<128
    {
      if (x>oPlayer1.x and image_xscale=-1) or (x<oPlayer1.x and image_xscale=1)
      {
        turnTime-=1
        if turnTime=0
        {
          xVel*=-1
          turnTime=60
        }
      }
    }

    //Check if at cliff edge and turn around
    tDrop=0
    if aiCheckHoriz(1,1,0,8,4)
    {
      if aiCheckVert(0,1,8,14,4)=1
      {
        tDrop=1
      }
    }
    if tDrop=0
    {
      xVel*=-1
      if turnTime<30 {turnTime=30}
    }

    //Kick up sand balls
    scuttleBallTime+=1
    if scuttleBallTime mod 9=0
    {
      var tNewAttack;
      tNewAttack=instance_create(x-(12*image_xscale),y-8,oGravityBullet)
      tNewAttack.sprite_index=sScorpionBall
      if image_xscale=-1 {tNewAttack.image_xscale=-1}
      tNewAttack.atkPower=atkPower
      tNewAttack.xVel=(1.5+random(1.5))*(image_xscale*-1)
      tNewAttack.yVel=-1.5-random(1.5)
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
      sprite_index=sWB_Scorpion_Die
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
