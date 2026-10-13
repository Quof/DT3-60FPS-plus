event_inherited()
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
        xVel=maxVelocity
    }
    else
    {
      if xVel>-maxVelocity
        xVel=-maxVelocity
    }

    if oPlayer1.kUp and dirInfluenceTime=0
    {
      dirInfluenceTime=3
      if yVel>-8
        yVel-=2 //one nudge every 3 ticks (dirInfluenceTime), so not scaled
    }
    else if oPlayer1.kDown and dirInfluenceTime=0
    {
      dirInfluenceTime=3
      if yVel<8
        yVel+=2
    }

    if dirInfluenceTime>0
      dirInfluenceTime-=1*gDeltaTime
    if returnTimer>=returnTimeMax
    {
      xVel/=4
      yVel/=4
      bReturning=true
      for (i = 0; i < maxAtkId; i+=1)
      {
        atkIdTime[i]=1
      }
      weaponRehitTime=1
      //alarm[0]=2
      alarm[0]=round(2/gDeltaTime) //60fps change
    }
    else
      returnTimer+=1*gDeltaTime
    if place_meeting(x,y,oNightmareEffect)
      {
        //moveTo(xVel/2, yVel/2)
        moveTo(xVel/2*gDeltaTime, yVel/2*gDeltaTime) //60fps change
      }
      //else {moveTo(xVel,yVel) }
      else {moveTo(xVel*gDeltaTime,yVel*gDeltaTime) } //60fps change
  }
  else if bMissed=false
  {
    //return to Link
    if x>oPlayer1.x and xVel>-maxVelocity
      xVel= -maxVelocity
    else if x<oPlayer1.x and xVel<maxVelocity
      xVel = maxVelocity

    if y>oPlayer1.y- 24 and yVel>-maxVelocity/1.5
      yVel= -maxVelocity/1.5
    else if y<oPlayer1.y- 24 and yVel<maxVelocity/1.5
      yVel= maxVelocity/1.5

    tempXvel=xVel
    tempYvel=xVel
    if tempXvel<0
      tempXvel*=-1
    if tempYvel<0
      tempYvel*=-1
    newSpeed=tempXvel+tempYvel
    if newSpeed>maxVelocity
      newSpeed=maxVelocity

    if place_meeting(x,y,oNightmareEffect)
      {
        //speed=newSpeed/2
        _speed=newSpeed/2 //60fps change: DT3+'s own motion (_speed)
      }
      //else { speed=newSpeed}
      else { _speed=newSpeed} //60fps change
    myDir=point_direction(x,y,oPlayer1.x,oPlayer1.y- 24)
    _direction=myDir

    //boomerang missed
    myDist=point_distance(x,y,oPlayer1.x,oPlayer1.y- 24)
    if myDist<grabDist
    {
      bMissed=true
      //sound_stop(snd_BoomerangFly)
      //sound_play(snd_BoomerangCatch)
    }
  }
  else
  {
    if missFlyDuration = 0
    {
      oPlayer1.bBoomerangOut=false
      oPlayer1.boomerLevel=0
      instance_destroy()
    }
    //missFlyDuration-=1
    missFlyDuration-=1*gDeltaTime //60fps change
  }

  if oPlayer1.kActBPressed and bReturning = true and bCanCatch = true
  {
    myDist=point_distance(x,y,oPlayer1.x,oPlayer1.y- 24)
    if myDist<grabDist //CAUGHT
    {
        //Re-enable air dash
        if oPlayer1.canAirDash=0 {oHUD.airDashScl=3}
          oPlayer1.canAirDash=1

          //Re-enable double jump
        if oPlayer1.doubleJumpCheck=0 {oHUD.doubleJumpScl=2}
          oPlayer1.doubleJumpCheck=1

        oPlayer1.bBoomerangOut=false
        instance_destroy()
        if oPlayer1.boomerLevel < 100
        {
            oPlayer1.boomerLevel+=1
            oPlayer1.boomerTimer=90
        }
        playSound(global.snd_WepChargeComplete,0,1,min(30000+oPlayer1.boomerLevel*1000,40000))
        if oPlayer1.boomerLevel=15
        {
          var tCheckAchieve;
          tCheckAchieve=string_char_at(global.tokenRecognitionsSetTwo,14)
          if tCheckAchieve="0"
          {
            var tAchievement;
            tAchievement=instance_create(0,0,oAchievementNoticeSS)
            tAchievement.myAchievement="League of Jerry"; tAchievement.checkNum=14
          }
        }
    }
    else
    {
        bCanCatch = false
        image_blend=c_gray
    }
  }
}
else
  _speed=0
correctSpeedDirection(self)
