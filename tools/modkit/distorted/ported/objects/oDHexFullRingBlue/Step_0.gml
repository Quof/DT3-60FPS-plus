if global.gamePaused=false
{
  //image_angle+=spinSpd
  //speed=moveSpd
  //changeTime+=1
  image_angle+=spinSpd*gDeltaTime //60fps change: per frame
  _speed=moveSpd //60fps change: DT3+'s _speed (correctSpeedDirection moves it, below), as DT3+'s oHexCircle
  changeTime+=1*gDeltaTime //60fps change: per frame
  if changeTime>=changeDelay
  {
    //direction+=180
    _direction+=180 //60fps change: DT3+'s _direction
    changeTime=0
  }
  else if global.location=110 and room!=rDistFinal_Round3
  {
    //distortionTime+=1
    distortionTime+=1*gDeltaTime //60fps change: per frame
    if distortionTime>=15
    {
        sc=random(1)+0.7
        image_xscale=sc
        image_yscale=sc
        distortionTime=0
    }
    x=oPlayer1.x
    y=oPlayer1.y-16
  }
  if rockBounce=1
  {
    //rockTime+=1
    rockTime+=1*gDeltaTime //60fps change: per frame
    //if rockTime=1
    if rockTime<=1 //60fps change: tick 1 (all of its frames), set up on its first
    {
        if rockTime=gDeltaTime //60fps change (added)
        {
        //direction=90
        _direction=90 //60fps change: DT3+'s _direction
        rockFix=y
        rockY=-10
        } //60fps change (added)
    }
    //else if rockTime>=2 and rockTime<=21 {rockY+=1}
    else if rockTime>1 and rockTime<=21 {rockY+=1*gDeltaTime} //60fps change: per frame, over ticks 2-21
    else {y=rockFix; rockY=0; rockBounce=0; rockTime=0}
  }
  //if room=rPttT_07 {y+=rockY}
  if room=rPttT_07 {y+=rockY*gDeltaTime} //60fps change: per frame
}
//else {speed=0}
else {_speed=0} //60fps change: DT3+'s _speed
correctSpeedDirection(self) //60fps change (added): moves it by _speed/_direction, as DT3+'s oHexCircle
