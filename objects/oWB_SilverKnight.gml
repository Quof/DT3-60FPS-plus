#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-13,-38,13,-1)
image_speed=0.15

//Enemy base statistics
eName="Silver Knight"
eLevel=15
maxLife=450
life=maxLife
pointWorth=25
atkPower=5
resType[0]=2
resType[2]=2
resType[5]=2
stunResist=4
baseItemChance=75
baseDropIndex=90
moneyWorth=5
dieEffect=0
initDir=0
runAcc=2
turnTime=45
shotTime=50
shotDelay=80

deathAnim=0
yDeath=0

jeremyText="Nothing new overall. Slow tracking, a projectile sword wave, and a back dash if you're too close during the sword swing. The thing to note, however, is the shield. It will block SHOT and PIERCE type weapons, which is a shame since it has a bit of NORMAL defense. But you know how some armored enemies can be right?"
chaoText="There sure are a lot of shielding enemies lately. This better not become a thing."
devText="A lot of levels in DT3 are parallels of levels in DT1. In a way, (I know I've mentioned this before) DT3 is what I wanted DT1 to be, but didn't have the skill to do. Begonia Temple is somewhat a throwback to Dusty Ruins."

myShield=instance_create(x,y,oWB_SKnightShield)
myShield.image_xscale=1.3
myShield.image_yscale=0.45
myShield.ownerID=id
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

    //Turn around if turn timer is 0 and player is close enough
    if point_distance(x,0,oPlayer1.x,0)<128
    {
      if (x<oPlayer1.x and image_xscale=-1) or (x>oPlayer1.x and image_xscale=1)
      {
        turnTime-=1
        if turnTime=0
        {
          xVel*=-1
          turnTime=45
        }
      }
    }

    //Check if at cliff edge and turn around
    tDrop=0
    if aiCheckHoriz(1,1,0,8,4)
    {
      if aiCheckVert(0,1,8,8,4)=1
        tDrop=1
    }
    if tDrop=0
    {
      xVel*=-1
      turnTime=45+irandom(45)
    }

    //---------- Swing sword (wave) ----------
    shotTime+=1
    if shotTime>=shotDelay
    {
      if shotTime=shotDelay //Change anim and step back if too close to player
      {
        if point_distance(x,0,oPlayer1.x,0)<224 and ((x>oPlayer1.x and image_xscale=-1) or (x<oPlayer1.x and image_xscale=1))
        {
          xVel=0
          sprite_index=sWB_SilverKnight_Swing
          image_speed=0
          image_index=0
          myShield.bShielding=0
          if findTargetX<96 //Player is close
          {
            var tDash;
            tDash=1
            if aiCheckHoriz(1,3,-16,-4,4)=1
              tDash=0

            if tDash=1 //Dash back if able to
            {
              if image_xscale=1
                xVel=-5
              else
                xVel=5
            }
          }
        }
        else {shotTime=shotDelay-5}
      }
      else if shotTime=shotDelay+20 //Fire shot
      {
        image_index=1
        var tNewAttack;
        tNewAttack=instance_create(x+(12*image_xscale),y-18,oPassBullet)
        tNewAttack.sprite_index=sSilverKnightSwordWave
        tNewAttack.atkPower=atkPower
        tNewAttack.bulletSpeed=7
        tNewAttack.decayTime=-100
        if image_xscale=-1
          tNewAttack.direction=180
      }
      else if shotTime=shotDelay+30 //End attack
      {
        xVel=runAcc
        if x>oPlayer1.x
          xVel*=-1
        sprite_index=sWB_SilverKnight_Walk
        image_speed=0.15
        myShield.bShielding=1
        turnTime=50
        shotTime=0
      }
    }

    //Shield Control
    myShield.x=x+18*image_xscale
    myShield.y=y-18

    yVel+=0.2
    if isCollisionBottom(1)
      yVel=0
    if isCollisionLeft(1)
      xVel*=-1
    if isCollisionRight(1)
      xVel*=-1
    if isCollisionSolid()
      y-=2

    if shotTime<shotDelay //Check direction
    {
      if xVel>0
        image_xscale=1
      else
        image_xscale=-1
    }
    else //Slow down back-dash
    {
      if shotTime>=shotDelay+1
      {
        if xVel>0
          xVel-=0.4
        else if xVel<0
          xVel+=0.4
      }
    }

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
      with myShield {instance_destroy()}
      sprite_index=sWB_SilverKnight_Die
      yDeath=-6
    }
    else if deathAnim>=2
    {
      if oGame.time mod 3=0 {image_xscale*=-1}
      y+=yDeath
      if yDeath<12 {yDeath+=0.3}
      if y>room_height+24 {instance_destroy()}
    }
  }
  enemyStepEvent()
}
