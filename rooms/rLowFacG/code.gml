locationCheck(69)

if global.gameProgress=4380 {global.gameProgress=4390}
else if global.gameProgress>=4400 and global.bBossGallery=0
{
  with (GID(377769)) {instance_destroy()}
  tile_layer_hide(999999)
}

gameScene=instance_create(0,0,oEvCh18MainA)
mapScene=instance_create(0,0,oEvCh18SideA)

if global.bossTrack=1 //Boss Fight: Blade Bot
{
  var tempMplay;
  tempMplay=findMusic(825)
  var enemyBarrier;
  enemyBarrier=instance_create(368,224,oEnemyBarrier); enemyBarrier.image_yscale=8
  enemyBarrier=instance_create(1024,224,oEnemyBarrier); enemyBarrier.image_yscale=8
  oPlayer1.x=576; oPlayer1.y=352
  storeStatus(1)
  instance_create(0,0,oBBotControl)
}
else
{
  var tempMplay;
  tempMplay=findMusic(22)
}
playMusic(tempMplay,0,0)
