if global.gamePaused=false
{
  image_angle-=22.5*gDeltaTime
  atkTime+=1*gDeltaTime
  if atkProg=0 //Rise
  {
    if atkTime=30 {atkTime=0; atkProg+=1}
  }
  else if atkProg=1 //Wait
  {
    colorOther-=5*gDeltaTime
    image_blend=make_color_rgb(255,colorOther,colorOther)
    if atkTime=30
    {
      //direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
      _direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
      bCanDealDamage=1
      atkTime=0; atkProg+=1
    }
  }
  else if atkProg=2 //Attack and collision check
  {
    //speed=6
    _speed=6
  }
  enemyStepEvent()
}
else {_speed=0}
correctSpeedDirection(self)
