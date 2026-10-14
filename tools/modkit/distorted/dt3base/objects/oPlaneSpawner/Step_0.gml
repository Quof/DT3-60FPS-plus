if global.gamePaused=false
{
  spawnTime+=1*gDeltaTime
  if spawnTime>=spawnDelay
  {
    if spawnProg=0 {spawnX=view_xview-64; spawnProg=1} //from left
    else {spawnX=view_xview+view_wview+64; spawnProg=0} //from right

    spawnY=48+random(32)
    plane=instance_create(spawnX,spawnY,enemySpawn)
    plane.bActive=1
    spawnTime=0
  }
}
