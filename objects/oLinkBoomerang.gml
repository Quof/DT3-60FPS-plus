#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-7,-7,7,7)

damageType="BOOMERANG"
weaponTag=1
atkLv=global.stLink_Boomerang[0]
atkPower=global.stLink_Boomerang[3]
atkPower=weaponDmgMod(0,atkPower)
global.recAtkNum+=1
stunTime=round(25+(global.stLink_Boomerang[3]*3.25))

maxVelocity=12
grabDist=24        //distance to the player before he can grab the boomerang when it is returning

bReturning=false   //whether the boomerang is returning to the player
returnTimeMax=25   //time till the boomerang returns to the player
returnTimer=0      //current time till the boomerang returns the to player

dirInfluenceTime=0 //current time till the player can no longer influence flight direction
//sound_play(snd_BoomerangThrow)
startSoundLoop=0   //time till sound loop start

if oPlayer1.image_xscale=-1
{
  image_xscale=-1
  x-=9
  xVel=-6
}
else
{
  x+=9
  xVel=6
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //rotate boomerang
  if image_xscale=1
    image_angle-=35
  else
    image_angle+=35

  //start sound loop
  if startSoundLoop=14
  {
    //sound_loop(snd_BoomerangFly)
    startSoundLoop=100
  }
  else if startSoundLoop<14
    startSoundLoop+=1

  //fly out from Link
  if bReturning=false
  {
    if image_xscale=1
    {
      if xVel<maxVelocity
        xVel+=0.5
    }
    else
    {
      if xVel>-maxVelocity
        xVel-=0.5
    }

    if oPlayer1.kUp and dirInfluenceTime=0
    {
      dirInfluenceTime=3
      if yVel>-4
        yVel-=1
    }
    else if oPlayer1.kDown and dirInfluenceTime=0
    {
      dirInfluenceTime=3
      if yVel<4
        yVel+=1
    }

    if dirInfluenceTime>0
      dirInfluenceTime-=1
    if returnTimer>=returnTimeMax
    {
      xVel/=4
      yVel/=4
      bReturning=true
    }
    else
      returnTimer+=1

    moveTo(xVel,yVel)
  }
  else
  {
    //return to Link
    if x>oPlayer1.x and xVel>-maxVelocity
      xVel-=1
    else if x<oPlayer1.x and xVel<maxVelocity
      xVel+=1

    if y>oPlayer1.y-26 and yVel>-maxVelocity/1.5
      yVel-=0.5
    else if y<oPlayer1.y-26 and yVel<maxVelocity/1.5
      yVel+=0.5

    tempXvel=xVel
    tempYvel=xVel
    if tempXvel<0
      tempXvel*=-1
    if tempYvel<0
      tempYvel*=-1
    newSpeed=tempXvel+tempYvel
    if newSpeed>maxVelocity
      newSpeed=maxVelocity
    speed=newSpeed
    myDir=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)
    direction=myDir

    //boomerang caught
    myDist=point_distance(x,y,oPlayer1.x,oPlayer1.y-26)
    if myDist<grabDist
    {
      oPlayer1.bBoomerangOut=false
      //sound_stop(snd_BoomerangFly)
      //sound_play(snd_BoomerangCatch)
      instance_destroy()
    }
  }
}
else
  speed=0
