if global.gamePaused=false
{
  if xDist>=400
  {
    xDist-=0.125*gDeltaTime
    yDist-=0.0625*gDeltaTime
  }
  else if xDist>=250 and xDist<=399.999
  {
    xDist-=0.25*gDeltaTime
    yDist-=0.125*gDeltaTime
  }
  else if xDist>=96 and xDist<=249.999
  {
    xDist-=0.5*gDeltaTime
    yDist-=0.25*gDeltaTime
  }
  else if xDist<=95.999
  {
    xDist-=1*gDeltaTime
    yDist-=0.5*gDeltaTime
  }
  direction+=0.33*gDeltaTime
  x=1248+lengthdir_x(xDist,direction)
  y=288+lengthdir_y(yDist,direction)

  if xDist<=12
  {
    oPlayer1.life-=oPlayer1.maxLife
  }

  if resCheck=0 and !instance_exists(oWaspBot) //spsp ns
  {
    resCheck=1
    resType[0]=5
  }
  
  enemyStepEvent()
}
correctSpeedDirection(self)
