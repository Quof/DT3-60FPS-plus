locationCheck(47)

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2
backFollow.backSet=backBarrensA
backFollow.xMoveScale=0.6
backFollow.yMoveScale=0.92
backFollow.depth=1499999
backFollow.image_xscale=2.8
backFollow.image_yscale=2.8

gameScene=instance_create(0,0,oEvCh12MainA)
heatTrack=instance_create(0,0,oDesertHeat)

if global.CHAOS_Invasion=1 and global.bBossGallery=0
{
  instance_create(2320,352,oDragonKnight)
}

var tempMplay;
if global.bossTrack=0 {tempMplay=findMusic(13)}
else if global.bossTrack=1 //Boss Fight: Vault Demon
{
  tempMplay=findMusic(813)
  var tCamera,enemyBarrier,boss;
  tCamera=instance_create(2208,304,oGameCamera); tCamera.type=0
  oPlayer1.x=2128; oPlayer1.y=352
  enemyBarrier=instance_create(1952,0,oEnemyBarrier); enemyBarrier.image_yscale=32
  enemyBarrier=instance_create(2448,0,oEnemyBarrier); enemyBarrier.image_yscale=32
  boss=instance_create(2288,288,oVaultDemon)
  boss.activateBoss=1
  storeStatus(1)
}
playMusic(tempMplay,0,0)
