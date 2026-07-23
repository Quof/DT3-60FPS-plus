locationCheck(15)

if global.gameProgress=1420 {global.gameProgress=1430}

gameScene=instance_create(0,0,oEvCh6MainA)

if global.bossTrack=1 //Boss Fight: Menace
{
  with oEnemyBase
    instance_destroy()
  var tempMplay,bBarrier;
  tempMplay=findMusic(805)
  bBarrier=instance_create(272,448,oBossBarrier)
  oPlayer1.x=608; oPlayer1.y=384
  storeStatus(1)
  boss=instance_create(848,200,oMenaceMain)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  if global.gameProgress<=1430
    tempMplay=findMusic(202)
  else
    tempMplay=findMusic(306)
}
playMusic(tempMplay,0,0)
