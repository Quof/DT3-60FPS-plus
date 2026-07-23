locationCheck(49)

gameScene=instance_create(0,0,oEvCh13MainA)
heatBack=instance_create(0,0,oLowerNorfairForeground)
rmLight=instance_create(0,0,oFireFleaRmLight)

if global.bossTrack=1 //Boss Fight: Arachnus
{
  var tempMplay,enemyBarrier;
  tempMplay=findMusic(815)
  enemyBarrier=instance_create(80,192,oEnemyBarrier); enemyBarrier.image_yscale=4
  storeStatus(1)
  oPlayer1.x=144; oPlayer1.y=256
  boss=instance_create(336,256,oArachnus)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(503)
}
playMusic(tempMplay,0,0)
