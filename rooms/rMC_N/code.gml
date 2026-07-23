locationCheck(93)
global.partySplit=0

if global.optShowDamage>1 {global.optShowDamage-=2}

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2
backFollow.backSet=backMagicalCastleA
backFollow.xMoveScale=0.6
backFollow.yMoveScale=1
backFollow.depth=1499999

gameScene=instance_create(0,0,oEvCh19MainA)

if global.gameProgress<=5010 or global.bBossGallery=1
{
  roomCamera=instance_create(0,0,oRm_MC_Camera); roomCamera.progress=0
  enemyBarrier=instance_create(48,400,oEnemyBarrier); enemyBarrier.image_yscale=4
}
else
{
  with (GID(426628)) {instance_destroy()}
  tile_layer_hide(999990)
  tColl=instance_create(64,464,oInvisibleSolid); tColl.image_xscale=32
}

if global.gameProgress>=5030 and global.bBossGallery=0 {tile_layer_hide(999988)}

if global.bossTrack=1 //Boss Fight: Decimator 10000
{
  tile_layer_hide(999989)
  var tempMplay;
  tempMplay=findMusic(828)
  var enemyBarrier;
  enemyBarrier=instance_create(48,96,oEnemyBarrier); enemyBarrier.image_yscale=4
  enemyBarrier=instance_create(48,400,oEnemyBarrier); enemyBarrier.image_yscale=4
  oPlayer1.x=304; oPlayer1.y=320
  storeStatus(1)
  boss=instance_create(-16,208,oDecimator)
  boss.activateBoss=1
}
else if global.bossTrack=2 //Boss Fight: Decimator 20000 - Before John
{
  with oZeldaBreakPot {instance_destroy()}
  roomCamera.progress=1
  tColl=instance_create(64,464,oInvisibleSolid); tColl.image_xscale=32
  with (GID(426628)) {instance_destroy()}
  tile_layer_hide(999990)
  var tempMplay;
  tempMplay=findMusic(828)
  var enemyBarrier;
  enemyBarrier=instance_create(48,96,oEnemyBarrier); enemyBarrier.image_yscale=4
  enemyBarrier=instance_create(48,400,oEnemyBarrier); enemyBarrier.image_yscale=4
  oPlayer1.x=432; oPlayer1.y=240
  storeStatus(1)
  boss=instance_create(960,224,oDecimatorV2)
  boss.activateBoss=1; boss.prefight=0
}
else if global.bossTrack=3 //Boss Fight: Decimator 20000
{
  with oZeldaBreakPot {instance_destroy()}
  roomCamera.progress=3
  tColl=instance_create(64,464,oInvisibleSolid); tColl.image_xscale=32
  with (GID(426628)) {instance_destroy()}
  tile_layer_hide(999990)
  var tempMplay;
  tempMplay=findMusic(828)
  var enemyBarrier;
  enemyBarrier=instance_create(48,96,oEnemyBarrier); enemyBarrier.image_yscale=4
  enemyBarrier=instance_create(48,400,oEnemyBarrier); enemyBarrier.image_yscale=4
  oPlayer1.x=832; oPlayer1.y=320
  storeStatus(1)
  boss=instance_create(960,224,oDecimatorV2)
  boss.activateBoss=1; boss.prefight=1
}
else
{
  if global.gameProgress<=5010 {tile_layer_hide(999989)}
  var tempMplay;
  if global.gameProgress<=5010 {tempMplay=findMusic(0)}
  else {tempMplay=findMusic(602)}
}
playMusic(tempMplay,0,0)
