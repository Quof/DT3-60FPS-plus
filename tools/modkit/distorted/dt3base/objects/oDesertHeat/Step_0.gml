if global.gamePaused=false
{
  with oPlayer1
  {
    if isCollisionWaterBottom(-12)
    {
      if global.desertHeat<1500 {global.desertHeat+=60*gDeltaTime}
      else {global.desertHeat=1500}
    }
    else
    {
      global.desertHeat-=1*gDeltaTime
      if global.desertHeat<=0
      {
        oPlayer1.life-=oPlayer1.maxLife
      }
    }
  }
}
