locationCheck(58)
if global.gameProgress>=3545 {global.mapTeleport=18}

if global.gameProgress=3502 {global.gameProgress=3503}

gameScene=instance_create(0,0,oEvCh15MainA)
mapScene=instance_create(0,0,oEvCh15SideA)

if global.gameProgress<=3540 {oIdentifier.bCanScan=0; oIdentifier.deactivate=1}

var tempMplay;
if global.bossTrack=0 {tempMplay=findMusic(605)}
else if global.bossTrack=1 //Boss Fight: The Flame Elemental
{
  viewFix=instance_create(712,176,oMisc)
  viewFix.type=0
  viewFix.sprite_index=sNull
  view_object[0]=viewFix
  tempMplay=findMusic(819)
  oPlayer1.x=712; oPlayer1.y=304
  var boss,enemyBarrier;
  boss=instance_create(712,-48,oPT_FlameElemental)
  boss.activateBoss=1
  enemyBarrier=instance_create(560,112,oEnemyBarrier); enemyBarrier.image_yscale=12
  enemyBarrier=instance_create(848,80,oEnemyBarrier); enemyBarrier.image_yscale=14
}

playMusic(tempMplay,0,0)
