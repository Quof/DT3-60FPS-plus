event_inherited()
if global.gamePaused=false
{
  //if place_meeting(x,y,oNightmareEffect) {speed=bulletSpeed/2}
  //  else {speed=bulletSpeed}
  if place_meeting(x,y,oNightmareEffect) {_speed=bulletSpeed/2} //60fps change: DT3+'s own motion (_speed, correctSpeedDirection)
    else {_speed=bulletSpeed} //60fps change
  //if global.optWeaponTrail=1 {instance_create(x,y,oEfWeaponTrail)}
  if global.optWeaponTrail=1 and gDeltaDoTicks {instance_create(x,y,oEfWeaponTrail)} //60fps change: once per 30fps tick
  if arcType=1
  {
      if arcTime>0
      {
        //arcTime-=1
        arcTime-=1*gDeltaTime //60fps change
        if arcTime>3
        {
          if image_xscale>0
            //direction-=1
            _direction-=1*gDeltaTime //60fps change
          else
            //direction+=1
            _direction+=1*gDeltaTime //60fps change
        }
        else
        {
          if image_xscale>0
            //direction-=35
            _direction-=35*gDeltaTime //60fps change
          else
            //direction+=35
            _direction+=35*gDeltaTime //60fps change
        }
      }
  }
  if arcType=2
  {
      if arcTime>0
      {
        //arcTime-=1
        arcTime-=1*gDeltaTime //60fps change
        if arcTime>8
        {
          if image_xscale>0
            //direction-=3
            _direction-=3*gDeltaTime //60fps change
          else
            //direction+=3
            _direction+=3*gDeltaTime //60fps change
        }
        else
        {
          if image_xscale>0
            //direction-=10
            _direction-=10*gDeltaTime //60fps change
          else
            //direction+=10
            _direction+=10*gDeltaTime //60fps change
        }
      }
  }
  if arcType=3
  {
      if arcTime>0
      {
        //arcTime-=1
        arcTime-=1*gDeltaTime //60fps change
        if arcTime>3
        {
          if image_xscale>0
            //direction-=5
            _direction-=5*gDeltaTime //60fps change
          else
            //direction+=5
            _direction+=5*gDeltaTime //60fps change
        }
        else
        {
          if image_xscale>0
            //direction-=5
            _direction-=5*gDeltaTime //60fps change
          else
            //direction+=5
            _direction+=5*gDeltaTime //60fps change
        }
      }
  }
  if image_xscale>0
    //image_angle-=20
    image_angle-=20*gDeltaTime //60fps change
  else
    //image_angle+=20
    image_angle+=20*gDeltaTime //60fps change

  if isCollisionLeft(1)
    instance_destroy()
  if isCollisionRight(1)
    instance_destroy()
  if isCollisionBottom(1)
    instance_destroy()
  if isCollisionTop(1)
    instance_destroy()
  //lifeTime-=1
  lifeTime-=1*gDeltaTime //60fps change
  if lifeTime=0
    instance_destroy()
}
else
  //speed=0
  _speed=0 //60fps change
correctSpeedDirection(self) //60fps change (added): as DT3+'s version
