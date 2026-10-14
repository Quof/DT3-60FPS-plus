if global.gamePaused=false and spicy=0
{
  if bActive=false {makeEnemyActive(1)}
  //start movement in Player's direction (down)
  if bActive=true and y<oPlayer1.y
  {
    if bTargetFound=false
    {
      yVel=seekSpeed
      bTargetFound=true
      seekTime=seekDelay
    }
  }
  if seekTime>0
  {
    seekTime-=1*gDeltaTime
    if isCollisionBottom(1)
    {
      bReturning=true
      yVel=0
    }
    if seekTime=0 and bReturning=false
    {
      bReturning=true
      yVel=0
    }
  }
  if bReturning=false {moveTo(xVel*gDeltaTime,yVel*gDeltaTime)}

  //Return to original position
  if bReturning=true
  {
    y-=(seekSpeed/3)*gDeltaTime
    if y<=ystart
    {
      y=ystart
      yVel=0
      bTargetFound=false
      bReturning=false
      bActive=false
    }
  }
}
else if global.gamePaused=false and spicy=1 //spsp ns, left
{
  if bActive=false {makeEnemyActive(1)}
  //start movement in Player's direction (down)
  if bActive=true and x>oPlayer1.x
  {
    if bTargetFound=false
    {
      xVel=-seekSpeed
      bTargetFound=true
      seekTime=seekDelay
    }
  }
  if seekTime>0
  {
    //seekTime-=1
    seekTime-=1*gDeltaTime //60fps change: per frame (DT3+'s, as the downward crusher's)
    if isCollisionLeft(1)
    {
      bReturning=true
      xVel=0
    }
    if seekTime=0 and bReturning=false
    {
      bReturning=true
      xVel=0
    }
  }
  //if bReturning=false {moveTo(xVel,yVel)}
  if bReturning=false {moveTo(xVel*gDeltaTime,yVel*gDeltaTime)} //60fps change: per frame

  //Return to original position
  if bReturning=true
  {
    //x+=seekSpeed/3
    x+=(seekSpeed/3)*gDeltaTime //60fps change: per frame
    if x>=xstart
    {
      x=xstart
      xVel=0
      bTargetFound=false
      bReturning=false
      bActive=false
    }
  }
}
else if global.gamePaused=false and spicy=2 //spsp ns, right
{
  if bActive=false {makeEnemyActive(1)}
  //start movement in Player's direction (down)
  if bActive=true and x<oPlayer1.x
  {
    if bTargetFound=false
    {
      xVel=seekSpeed
      bTargetFound=true
      seekTime=seekDelay
    }
  }
  if seekTime>0
  {
    //seekTime-=1
    seekTime-=1*gDeltaTime //60fps change: per frame (DT3+'s, as the downward crusher's)
    if isCollisionRight(1)
    {
      bReturning=true
      xVel=0
    }
    if seekTime=0 and bReturning=false
    {
      bReturning=true
      xVel=0
    }
  }
  //if bReturning=false {moveTo(xVel,yVel)}
  if bReturning=false {moveTo(xVel*gDeltaTime,yVel*gDeltaTime)} //60fps change: per frame

  //Return to original position
  if bReturning=true
  {
    //x-=seekSpeed/3
    x-=(seekSpeed/3)*gDeltaTime //60fps change: per frame
    if x<=xstart
    {
      x=xstart
      xVel=0
      bTargetFound=false
      bReturning=false
      bActive=false
    }
  }
}
