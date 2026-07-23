locationCheck(40)
if global.gameProgress>=2550 {global.mapTeleport=15}

gameScene=instance_create(0,0,oEvCh10MainA)
instance_create(0,0,oVaultVisualControl)

if global.gameProgress>=2170 and global.gameProgress<=2400
{
  oIdentifier.bCanScan=0; oIdentifier.deactivate=1
}
else if global.gameProgress>=2410
{
  tile_layer_hide(1000020)
  for(i=0;i<7;i+=1)
  {
    with (GID(250492+i)) {instance_destroy()}
  }
  with oMisc {instance_destroy()}
}

if global.bossTrack=101 //Encounter: Dragon Knight & Blood Tyrant
{
  var tempMplay;
  tempMplay=findMusic(809)

  var enemyCounter,enemyBarrier;
  enemyBarrier=instance_create(304,112,oEnemyBarrier); enemyBarrier.image_yscale=12
  enemyBarrier=instance_create(880,240,oEnemyBarrier); enemyBarrier.image_yscale=4
  enemyCounter=instance_create(0,0,oEnemyRemain)
  enemyCounter.enemyCount=2
  createEnemy(688,304,oBloodTyrant,2,0,1)
  createEnemy(384,304,oDragonKnight,2,0,1)
  oPlayer1.x=512; oPlayer1.y=304
  storeStatus(1)
}
else
{
  var tempMplay;
  tempMplay=findMusic(11)
}
playMusic(tempMplay,0,0)
