if global.gamePaused=false
{
  //rotate boomerang
  if image_xscale=1
    image_angle-=35*gDeltaTime
  else
    image_angle+=35*gDeltaTime

  //start sound loop
  if startSoundLoop=14
  {
    //sound_loop(snd_BoomerangFly)
    startSoundLoop=100
  }
  else if startSoundLoop<14
    startSoundLoop+=1*gDeltaTime

  //fly out from Link
  if bReturning=false
  {
    if image_xscale=1
    {
      if xVel<maxVelocity
        xVel+=0.5*gDeltaTime
    }
    else
    {
      if xVel>-maxVelocity
        xVel-=0.5*gDeltaTime
    }

    if oPlayer1.kUp and dirInfluenceTime=0
    {
      dirInfluenceTime=3
      if yVel>-4
        yVel-=1 //one nudge every 3 ticks (dirInfluenceTime), so not scaled
    }
    else if oPlayer1.kDown and dirInfluenceTime=0
    {
      dirInfluenceTime=3
      if yVel<4
        yVel+=1
    }

    if dirInfluenceTime>0
      dirInfluenceTime-=1*gDeltaTime
    if returnTimer>=returnTimeMax
    {
      xVel/=4
      yVel/=4
      bReturning=true
    }
    else
      returnTimer+=1*gDeltaTime

    moveTo(xVel*gDeltaTime,yVel*gDeltaTime)
  }
  else
  {
    //return to Link
    if x>oPlayer1.x and xVel>-maxVelocity
      xVel-=1*gDeltaTime
    else if x<oPlayer1.x and xVel<maxVelocity
      xVel+=1*gDeltaTime

    if y>oPlayer1.y-26 and yVel>-maxVelocity/1.5
      yVel-=0.5*gDeltaTime
    else if y<oPlayer1.y-26 and yVel<maxVelocity/1.5
      yVel+=0.5*gDeltaTime

    tempXvel=xVel
    tempYvel=xVel
    if tempXvel<0
      tempXvel*=-1
    if tempYvel<0
      tempYvel*=-1
    newSpeed=tempXvel+tempYvel
    if newSpeed>maxVelocity
      newSpeed=maxVelocity
    _speed=newSpeed
    myDir=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)
    _direction=myDir

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
  _speed=0
correctSpeedDirection(self)
