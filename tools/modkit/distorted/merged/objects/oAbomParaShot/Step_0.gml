if global.gamePaused=false
{
  image_angle=_direction
  lifeTime+=1*gDeltaTime
  //if lifeTime>=1 and lifeTime<=35 and gDeltaDoTicks
  if lifeTime>=1 and lifeTime<=35 and frac(lifeTime)=0 //60fps change: trail on this shot's own ticks (35 like 30fps)
  {
    var tEffect,tScale;
    tScale=random(0.17)
    tEffect=instance_create(x+random_range(-8,8),y+random_range(-8,8),oEffect)
    tEffect.sprite_index=sAbom_Tentacle; tEffect.image_speed=0.33; tEffect.image_alpha=0.75
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=15; tEffect.xSpd=random_range(-2,2); tEffect.ySpd=random_range(-2,2)
    tEffect.image_xscale=0.13+tScale; tEffect.image_yscale=0.13+tScale; tEffect.image_angle=random(360)
  }
  //if lifeTime=50
  if lifeTime=49+gDeltaTime //60fps change: aims on the first frame of tick 50, so it moves on every frame of that tick
  {
    _direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
  }

  //if lifeTime>=1 and lifeTime<=35 {speed=4} //spsp ns orig 5.5(?)
  if lifeTime>0 and lifeTime<=35 {_speed=4} //60fps change: covers every frame of ticks 1-35 //spsp ns orig 5.5(?)
  //else if lifeTime>=50
  else if lifeTime>49 //60fps change: covers every frame of tick 50
  {
    //speed=10
    _speed=10 //60fps change
    //if true and lifeTime<=80 and (lifeTime mod 2=0) //spsp ns
    if true and lifeTime<=80 and frac(lifeTime)=0 and (lifeTime mod 2=0) //spsp ns //60fps change: on this shot's own ticks, as at 30fps (it turns a tenth of the way each time)
    {
        tempDir=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
        /*if tempDir>270 {direction=direction*9/10-(360-tempDir)/10}
        else {direction=direction*9/10+tempDir/10}*/
        //(60fps change: _direction for direction, which DT3+'s shot moves by)
        if tempDir=_direction or (tempDir>_direction and tempDir<_direction+180) or (tempDir<_direction and tempDir>_direction-180)
        {
            _direction=_direction*9/10+tempDir/10
        }
        else if _direction<180
        {
            _direction=_direction*9/10+(tempDir-360)/10
        }
        else //direction>=180
        {
            _direction=_direction*9/10+(tempDir+360)/10
        }
        _direction=((_direction mod 360)+360) mod 360 //60fps change (added): the built-in direction kept itself within 0-360, which the comparisons above count on
    }
  }
  //else {speed=0}
  else {_speed=0} //60fps change
}
else {_speed=0}

correctSpeedDirection(self)
