if global.gamePaused=false
{
  spawnTime+=1*gDeltaTime
  if spawnTime>=spawnDelay
  {
    spawnX=oPlayer1.x+oPlayer1.image_xscale*240
    plane=instance_create(spawnX,spawnY,enemySpawn)
    plane.bActive=1
    spawnTime=0
  }
}
