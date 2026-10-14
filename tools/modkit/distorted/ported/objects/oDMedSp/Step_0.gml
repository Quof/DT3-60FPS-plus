if global.gamePaused=false
{
  if spawnDirection=0
  {
    //if oPlayer1.x<256
      spawnDirection=1
    //else
      //spawnDirection=2
  }
  if spawnTime>=reSpawnSpeed and oPlayer1.y>2304 and oPlayer1.x<3888
  {
    if spawnDirection=1 //from right
      spawnX=view_xview+view_wview+64
    else //from left
      spawnX=view_xview-64
    ranSpawn=(oPlayer1.y-64)+random(104)
    mHead=instance_create(spawnX,ranSpawn,enemySpawn)
    mHead.bActive=true
    mHead.bobTime=round(random(54))
    spawnTime=0
  }
  else
  {
    if (spawnDirection=1 and oPlayer1.x<room_width-(view_wview[0]/2)) or (spawnDirection=2 and oPlayer1.x>view_wview[0]/2)
      spawnTime+=1*gDeltaTime
  }
}
