if global.gamePaused=false
{
  if bCanSpawn=1
  {
    spawnTime+=1*gDeltaTime
    if spawnTime>=spawnFreq
    {
      var newSpawn;
      newSpawn=instance_create(x,y,enemyType)
      newSpawn.siegeLv=enemyLevel
      if object_is_ancestor(enemyType,oTD_Ground) {newSpawn.image_xscale=myDir}
      //else if object_is_ancestor(enemyType,oTD_Flyer) {newSpawn.direction=myDir}
      else if object_is_ancestor(enemyType,oTD_Flyer) {newSpawn._direction=myDir} //60fps change: flyers move with _direction now, so every flyer started out going right
      spawnTime=0
      spawnNum+=1
      if spawnNum>=spawnMax {instance_destroy()}
    }
  }
}
