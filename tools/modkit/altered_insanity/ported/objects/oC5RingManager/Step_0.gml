if global.gamePaused=false
{
  if bCollectedRings=0
  {
    if resetTime>-1
    {
      resetTime-=1*gDeltaTime
      if resetTime=0
      {
        prevRings=ringColl
        ringColl=0
        oC5Ring.image_index=0
        oC5Ring.spinFrm=0
        oC5Ring.bRunThrough=0
        oC5Ring.image_blend=c_white
        resetTime=-1
        oPlayer1.dashEnergy = 10000
      }
    }

    if ringColl=ringMax
    {
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.image_alpha=0.5; tFlash.fadeSpeed=0.1
      bCollectedRings=1
    }
  }
  else
  {
    with oC5Ring {if(index=other.index) { instance_destroy() } }
    with doorID {instance_destroy()}
    instance_destroy()
  }
}
