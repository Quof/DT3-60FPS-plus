if global.gamePaused=false
{
  //image_angle+=spinSpd
  //speed=moveSpd
  image_angle+=spinSpd*gDeltaTime //60fps change: per frame
  _speed=moveSpd //60fps change: DT3+'s _speed (correctSpeedDirection moves it, below), as DT3+'s oHexCircle
  if room=rMC_M //spsp ns lol
  {
    if variable_local_exists("spinAcc")
      //spinSpd+=spinAcc
      spinSpd+=spinAcc*gDeltaTime //60fps change: per frame
    if variable_local_exists("spinBound")
      if spinSpd>=spinBound {spinSpd-=spinBound}
  }
  //changeTime+=1
  changeTime+=1*gDeltaTime //60fps change: per frame
  if changeTime>=changeDelay
  {
    //direction+=180
    _direction+=180 //60fps change: DT3+'s _direction
    changeTime=0
  }
  if room=rCh21_WarshipSkies
  {
    //image_xscale*=0.995
    //image_yscale*=0.995
    image_xscale*=power(0.995,gDeltaTime) //60fps change: the same shrink per 30fps tick
    image_yscale*=power(0.995,gDeltaTime) //60fps change
    if image_xscale<0.15 {instance_destroy()}
  }
  else if room=rDragoonMapA
  {
    //image_xscale-=0.007
    //image_yscale-=0.007
    image_xscale-=0.007*gDeltaTime //60fps change: per frame
    image_yscale-=0.007*gDeltaTime //60fps change: per frame
    if image_xscale<0.2 {instance_destroy()}
    //else if image_xscale=0.268
    else if image_xscale<=0.268 and image_xscale+0.007*gDeltaTime>0.268 //60fps change: the frame it shrinks past 0.268 (the steps don't land on it exactly)
    {
        var tEffect;
        tEffect=instance_create(oDragoonShip.x,oDragoonShip.y,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.9
        tEffect.image_xscale=2; tEffect.image_yscale=2
    }
  }
  else if room=rWarshipQ
  {
    if sizeCheck=1
    {
        //image_xscale+=0.01
        //image_yscale+=0.01
        image_xscale+=0.01*gDeltaTime //60fps change: per frame
        image_yscale+=0.01*gDeltaTime //60fps change: per frame
        if image_xscale>=2.75 {sizeCheck=0}
    }
    else
    {
        //image_xscale-=0.01
        //image_yscale-=0.01
        image_xscale-=0.01*gDeltaTime //60fps change: per frame
        image_yscale-=0.01*gDeltaTime //60fps change: per frame
        if image_xscale<=0.2 {sizeCheck=1}
    }
  }
  else if room=rHexPlat43
  {
    x=oPlayer1.x; y=oPlayer1.y-144
  }
  else if room=rRedRide
  {
    if x<oPlayer1.x {x=oPlayer1.x}
  }
}
//else {speed=0}
else {_speed=0} //60fps change: DT3+'s _speed
correctSpeedDirection(self) //60fps change (added): moves it by _speed/_direction, as DT3+'s oHexCircle
