locationCheck(49)

gameScene=instance_create(0,0,oEvCh13MainA)

if global.bossTrack=1 //Boss Fight: Kraid
{
  var tempMplay,enemyBarrier;
  tempMplay=findMusic(815)
  enemyBarrier=instance_create(496,128,oEnemyBarrier); enemyBarrier.image_yscale=4
  storeStatus(1)
  oPlayer1.x=336; oPlayer1.y=256
  boss=instance_create(144,160,oKraid)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(502)
}
playMusic(tempMplay,0,0)
