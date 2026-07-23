locationCheck(49)

gameScene=instance_create(0,0,oEvCh13MainA)

if global.gameProgress=3040 {global.gameProgress=3050}

if global.gameProgress<=3060
{
  if global.gameProgress=3060 //In case player quits the play session during this encounter
  {
    global.currentBoss="Ridley"
    global.bossTrack=1
  }
  oPlayer1.life=oPlayer1.maxLife
  global.hudSamus_Missiles[0]=global.hudSamus_Missiles[1]
}


if global.bossTrack=1 //Boss Fight: Ridley Final
{
  oPlayer1.x=272; oPlayer1.y=320
  var tempMplay;
  tempMplay=findMusic(816)
  boss=instance_create(176,224,oRidleyFinal)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(505)
}
playMusic(tempMplay,0,0)
