locationCheck(24)

gameScene=instance_create(0,0,oEvCh7MainA)

if global.bossTrack=0 and global.gameProgress=1680
{
  boss=instance_create(288,192,oEnmity)
  var tempMplay;
  tempMplay=findMusic(8)
}

if global.bossTrack=1 //Boss Fight: Enmity
{
  var tempMplay,bBarrier;
  tempMplay=findMusic(809)
  oPlayer1.x=288; oPlayer1.y=320
  storeStatus(1)
  boss=instance_create(288,192,oEnmity)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(8)
}
playMusic(tempMplay,0,0)
