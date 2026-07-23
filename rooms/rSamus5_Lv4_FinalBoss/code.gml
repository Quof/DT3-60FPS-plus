locationCheck(49)

gameScene=instance_create(0,0,oEvCh13MainA)

tile_layer_hide(8)

if global.bossTrack>=1 //Boss Fight: Ridley 1
{
  var tempMplay,enemyBarrier;
  tempMplay=findMusic(816)
  storeStatus(1)
  var enemyBarrier;
  enemyBarrier=instance_create(288,64,oEnemyBarrier); enemyBarrier.image_yscale=4; enemyBarrier.image_angle=90
  oPlayer1.x=432; oPlayer1.y=336
  if global.bossTrack=1
  {
    boss=instance_create(496,208,oRidley)
    boss.activateBoss=1
  }
  else if global.bossTrack=2 //Ridley 2
  {
    with (GID(295914)) {instance_destroy()}
    with (GID(295915)) {instance_destroy()}
    tile_layer_delete(11)
    with (GID(295787)) {instance_destroy()}
    tile_layer_delete(9)
    boss=instance_create(544,room_height+48,oRidleyLast)
    boss.activateBoss=1
  }
}
else
{
  var tempMplay;
  tempMplay=findMusic(505)
}
playMusic(tempMplay,0,0)
