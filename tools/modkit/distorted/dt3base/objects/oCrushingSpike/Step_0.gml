if global.gamePaused=false
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
