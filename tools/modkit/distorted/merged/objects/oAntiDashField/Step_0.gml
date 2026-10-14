if global.gamePaused=false
{
  if zoneType=0 //Square
  {
    if collision_rectangle(x,y,x+zoneWidth,y+zoneHeight,oPlayer1,0,1)
    {
      oPlayer1.dashEnergy=0
      if room=rDoubleSplit {oPlayer1.dashEnergy=1500}   //spsp DDLC
      if flashTime=0
      {
        if innerAlpha=0.3
          innerAlpha=0.25
        else
          innerAlpha=0.3
        flashTime=3
      }
      else
        flashTime-=1*gDeltaTime
    }
    else
    {
      flashTime=0
      innerAlpha=0.3
    }
  }
  else if zoneType=1 //Circle
  {
    if collision_circle(x,y,zoneRadius,oPlayer1,0,1)
    {
      oPlayer1.dashEnergy=0
      if flashTime=0
      {
        if innerAlpha=0.3
          innerAlpha=0.25
        else
          innerAlpha=0.3
        flashTime=3
      }
      else
        flashTime-=1*gDeltaTime
    }
    else
    {
      flashTime=0
      innerAlpha=0.3
    }
  }
}
