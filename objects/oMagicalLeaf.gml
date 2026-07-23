#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-8,-2,8,-1)
image_speed=0
detectDistX=168

//Enemy base statistics
eName="Magical Leaf"
eLevel=11
maxLife=310
life=maxLife
pointWorth=12
atkPower=4
resType[1]=1
resType[2]=5
resType[3]=2
resType[4]=5
stunResist=2
baseItemChance=70
baseDropIndex=85
initDir=0
turnTime=0
runAcc=1.5

spinProg=0
spinTime=60
spinDelay=110

jeremyText="This tries to be sneaky and hide in the grass, only coming up when you get close enough. Luckily, it isn't very smart. When you see it lift itself by spinning fast, it's about to project itself toward you, though only horizontally. Can still be a nuisance in some areas."
chaoText="This is from 'The Magical Quest starring Mickey Mouse'. I liked the treetops and castle levels the most."
devText="Slaix (a DT tester (and a really awesome guy)) really wanted DT to use tiles from Mickey's Magical Quest. The Magical Hills area is part of that request. It may somewhat be a spoiler, but more tiles from that game are used in a later part of DT3."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(1)
  if bActive=true and stunnedTime=0
  {
    if initDir=0 //detected
    {
      image_speed=0.2
      detectDistX=264
      initDir=1
    }
    else if initDir=1 //coming out of ground
    {
      if image_index>=1.6
      {
        sprite_index=sMagicalLeafWalk
        image_index=0
        if x>oCharacter.x
        {
          image_xscale=-1
          xVel=-runAcc
        }
        else
        {
          image_xscale=1
          xVel=runAcc
        }
        initDir=2
      }
    }
    else if initDir=2 //normal behavior
    {
      if xVel>0
        image_xscale=1
      else
        image_xscale=-1

      if x>oPlayer1.x and image_xscale=1
        turnTime+=1
      else if x<oPlayer1.x and image_xscale=-1
        turnTime+=1
      if turnTime>=20
      {
        xVel*=-1
        turnTime=0
      }

      spinTime+=1
      if spinProg=0 //start spin
      {
        if spinTime>=spinDelay and findTargetX<224
        {
          sprite_index=sMagicalLeafSpin
          image_speed=0.5
          xVel=0
          y-=2
          yVel=-1.5
          spinTime=0
          spinProg=1
        }
      }
      else if spinProg=1 //start movement
      {
        if spinTime>=20
        {
          image_speed=0.2
          if x<oPlayer1.x
            xVel=runAcc*4
          else
            xVel=-runAcc*4
          yVel=0

          if xVel>0
            image_xscale=1
          else
            image_xscale=-1
          spinTime=0
          spinProg=0
          initDir=3
        }
      }
    }

    if sprite_index=sMagicalLeafSpin //spin
    {
      spinTime+=1
      if spinTime>=35
      {
        if xVel>0
          xVel=runAcc
        else
          xVel=-runAcc
        sprite_index=sMagicalLeafWalk
        image_index=0
        spinTime=0
        initDir=2
      }
    }

    if sprite_index!=sMagicalLeafSpin
      yVel+=0.2

    if isCollisionBottom(1)
      yVel=0
    if isCollisionLeft(1)
    {
      xVel=runAcc
      if initDir=3
      {
        sprite_index=sMagicalLeafWalk
        spinTime=0
        initDir=2
      }
    }
    if isCollisionRight(1)
    {
      xVel=-runAcc
      if initDir=3
      {
        sprite_index=sMagicalLeafWalk
        spinTime=0
        initDir=2
      }
    }
    moveTo(xVel,yVel)
    if isCollisionSolid()
      y-=2

    if y>room_height+30
      instance_destroy()
  }
  enemyStepEvent()
}
