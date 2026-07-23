locationCheck(59)

gameScene=instance_create(0,0,oEvCh17MainA)
mapScene=instance_create(0,0,oEvCh17SideA)

if global.bossTrack=0
{
  if global.gameProgress=4090
  {
    npcSera=instance_create(416,224,oNPC_Sera)
    npcSera.image_xscale=-1
  }
}

if global.bossTrack=101
{
  if global.gameProgress=4090 //Encounter: Defend Sera
  {
    var tempMplay;
    tempMplay=findMusic(813)
    var enemyBarrier;
    enemyBarrier=instance_create(80,192,oSolidVirusBlock); enemyBarrier.image_yscale=6
    enemyBarrier=instance_create(640,192,oSolidVirusBlock); enemyBarrier.image_yscale=6
    oPlayer1.x=320; oPlayer1.y=288
    storeStatus(1)
    boss=instance_create(416,224,oNPC_Sera)
    boss.image_xscale=-1
    playMusic(tempMplay,0,0)
  }
  else if global.gameProgress=4120 //Encounter: Malignant Ooze
  {
    var tempMplay;
    tempMplay=findMusic(809)
    var enemyBarrier;
    enemyBarrier=instance_create(80,192,oEnemyBarrier); enemyBarrier.image_yscale=6
    enemyBarrier=instance_create(640,192,oEnemyBarrier); enemyBarrier.image_yscale=6
    oPlayer1.x=480; oPlayer1.y=288
    storeStatus(1)
    boss=instance_create(368,288,oMalignantOoze)
    playMusic(tempMplay,0,0)
  }
}
else if global.bossTrack=1 //Boss Fight: Sera
{
  var tempMplay;
  tempMplay=findMusic(821)
  var enemyBarrier;
  enemyBarrier=instance_create(80,192,oSolidVirusBlock); enemyBarrier.image_yscale=6
  enemyBarrier=instance_create(640,192,oSolidVirusBlock); enemyBarrier.image_yscale=6
  oPlayer1.x=320; oPlayer1.y=288
  storeStatus(1)
  boss=instance_create(416,224,oSera)
  boss.activateBoss=1
  playMusic(tempMplay,0,0)
}
else
{
  if global.gameProgress!=4090
  {
    var tempMplay;
    tempMplay=findMusic(19)
    playMusic(tempMplay,0,0)
  }
  else {stopAllMusic(); global.currentMusic=0}
}
