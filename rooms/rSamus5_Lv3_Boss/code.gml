locationCheck(49)

gameScene=instance_create(0,0,oEvCh13MainA)

if global.bossTrack=1 //Boss Fight: King Worm
{
  var tempMplay,enemyBarrier;
  tempMplay=findMusic(815)
  enemyBarrier=instance_create(32,208,oEnemyBarrier); enemyBarrier.image_yscale=4
  storeStatus(1)
  oPlayer1.x=240; oPlayer1.y=272
  boss=instance_create(240,128,oKingWorm)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(504)
}
playMusic(tempMplay,0,0)
