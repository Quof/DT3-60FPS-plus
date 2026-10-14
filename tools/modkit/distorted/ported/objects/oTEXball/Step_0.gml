if global.gamePaused=false
{
  //if oGame.time mod 4=0 {image_angle=random(360)}
  if oGame.time mod (4/gDeltaTime)=0 {image_angle=random(360)} //60fps change: every 4 ticks (oGame.time counts frames)

  if phase=1
  {
    //fast-=0.1
    fast-=0.1*gDeltaTime //60fps change: per frame
    if fast<0.05 {fast=0; phase+=1}
  }
  else if phase=2
  {
    if timer=0
    {
        //direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
        _direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter()) //60fps change: DT3+'s _direction
        timer+=1
    }
    //fast+=0.3
    fast+=0.3*gDeltaTime //60fps change: per frame
    if fast>=7.1 {fast=7.2; phase+=1; timer=0}
  }
  else if phase=3
  {
    //timer+=1
    timer+=1*gDeltaTime //60fps change: per frame
    if timer>32
    {
        //fast-=0.3
        fast-=0.3*gDeltaTime //60fps change: per frame
        if fast<0.05 {fast=0; phase+=1; timer=0}
    }
  }
  else if phase=4
  {
    if timer=0
    {
        //direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
        _direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter()) //60fps change: DT3+'s _direction
        timer+=1
    }
    //fast+=0.3
    fast+=0.3*gDeltaTime //60fps change: per frame
    if fast>=7.1 {fast=7.2; phase+=1; timer=0}
  }
  else if phase=5
  {
    //timer+=1
    timer+=1*gDeltaTime //60fps change: per frame
    if timer>60
    {
        if y<0 or y>360 or x<180 or x>880 {instance_destroy()}
    }
  }
  //speed=fast
  _speed=fast //60fps change: DT3+'s _speed (correctSpeedDirection moves it, below)
}
//else {speed=0}
else {_speed=0} //60fps change: DT3+'s _speed
correctSpeedDirection(self) //60fps change (added): moves it by _speed/_direction (set by oThunderbirdEX, then here)
