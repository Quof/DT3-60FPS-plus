locationCheck(36)

backFollowFore=instance_create(0,0,oBackgroundFollow)
backFollowFore.type=2
backFollowFore.backSet=backFarreachesA
backFollowFore.xMoveScale=0.6
backFollowFore.yMoveScale=0.95
backFollowFore.depth=1499999

gameScene=instance_create(0,0,oEvCh9MainA)

ringManager=instance_create(0,0,oCh9RingManager)
ringManager.doorID=(GID(244588))
ringManager.itemIndex=35
ringManager.ringMax=28

if global.CHAOS_Invasion=1
{
  instance_create(3856,272,oDragonKnight)
}

if global.bossTrack=101 //Encounter: Dragon Knight
{
  var tempMplay;
  tempMplay=findMusic(809)

  instance_create(0,0,oScreenColorOverlay)
  oScreenColorOverlay.image_blend=c_red
  oScreenColorOverlay.image_alpha=0.2
  var enemyBarrier;
  enemyBarrier=instance_create(3744,16,oEnemyBarrier); enemyBarrier.image_yscale=16
  enemyBarrier=instance_create(4080,80,oEnemyBarrier); enemyBarrier.image_yscale=12
  var enemyCounter;
  enemyCounter=instance_create(0,0,oEnemyRemain)
  enemyCounter.enemyCount=1
  createEnemy(3824,272,oDragonKnight,2,0,1)
  oPlayer1.x=4000; oPlayer1.y=272
  storeStatus(1)
}
else
{
  var tempMplay;
  tempMplay=findMusic(10)
}

playMusic(tempMplay,0,0)
