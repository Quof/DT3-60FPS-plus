if global.gamePaused=false
{
  atkTime+=1*gDeltaTime
  if atkTime=atkDelay
  {
    if invincible=0
    instance_create(x,y,oZeldaFloorTile)
    else
        instance_create(x,y,oZeldaFloorTileInvincible)
    instance_destroy()
  }
}
