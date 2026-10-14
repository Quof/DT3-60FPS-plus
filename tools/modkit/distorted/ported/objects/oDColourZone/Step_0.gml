if global.gamePaused=false
{
  if zoneType=1 and collision_rectangle(x,y,x+image_xscale,y+image_yscale,oPlayer1,0,1)
  {
    if instance_exists(oColorIndControl)
    {
      oColorIndControl.bColorActive[zoneColor-1]=1
      if zoneColor=oColorIndControl.currentColor
        oColorIndControl.bWillDamagePlayer=2
    }

    if flashTime=0
    {
      if innerAlpha=0.5
        innerAlpha=0.6
      else
        innerAlpha=0.5
      flashTime=3
    }
    else
      //flashTime-=1
      flashTime-=1*gDeltaTime //60fps change: per frame, as DT3+'s oColorZone
  }
  else if zoneType=0 and collision_circle(x,y,zoneRadius,oPlayer1,0,1)
  {
    if instance_exists(oColorIndControl)
    {
      oColorIndControl.bColorActive[zoneColor-1]=1
      if zoneColor=oColorIndControl.currentColor
        oColorIndControl.bWillDamagePlayer=2
    }

    if flashTime=0
    {
      if innerAlpha=0.5
        innerAlpha=0.6
      else
        innerAlpha=0.5
      flashTime=3
    }
    else
      //flashTime-=1
      flashTime-=1*gDeltaTime //60fps change: per frame, as DT3+'s oColorZone
  }
  else
  {
    flashTime=0
    innerAlpha=0.5
  }

  if moveSpd>0
  {
    //speed=moveSpd
    //moveTime+=1
    //if moveTime>=moveDelay
    //{
    //  moveTime=0
    //  direction+=180
    //}
    //60fps change: as DT3+'s oColorZone: _speed/_direction (moved below), turning on 30fps ticks
    _speed=moveSpd
    if gDeltaDoTicks != 0
    {
      moveTime+=1
      if moveTime>=moveDelay
      {
        moveTime=0
        _direction+=180
      }
    }
  }
  /*if bFollow=1 and instance_exists(idFollow)
  {
    x=idFollow.x
    y=idFollow.y
  }*/
}
//else {speed=0}
else {_speed=0} //60fps change: DT3+'s _speed

//60fps change (added): moved as DT3+'s oColorZone moves (correctSpeedDirection at 30fps; above it, in the same per-tick
//pattern as the moving solids, so zones riding along with moving platforms stay locked to them)
if gDeltaTime==1 {correctSpeedDirection(self)}
else if global.gamePaused=false
{
  if !variable_local_exists("zcFrames") {zcLeftX=0; zcLeftY=0; zcFrames=0}
  if gDeltaDoTicks != 0
  {
    zcLeftX=cos(degtorad(_direction))*_speed
    zcLeftY=-sin(degtorad(_direction))*_speed
    if approximatelyZero(zcLeftX) {zcLeftX=0}
    if approximatelyZero(zcLeftY) {zcLeftY=0}
    zcFrames=round(1/gDeltaTime)
  }
  if zcFrames>0
  {
    var tStepX,tStepY;
    tStepX=sign(zcLeftX)*min(abs(zcLeftX),ceil(abs(zcLeftX)/zcFrames))
    tStepY=sign(zcLeftY)*min(abs(zcLeftY),ceil(abs(zcLeftY)/zcFrames))
    x+=tStepX
    y+=tStepY
    zcLeftX-=tStepX
    zcLeftY-=tStepY
    zcFrames-=1
  }
}
