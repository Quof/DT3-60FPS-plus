locationCheck(49)

gameScene=instance_create(0,0,oEvCh13MainA)

oPlayer1.life=oPlayer1.maxLife
global.hudSamus_Missiles[0]=global.hudSamus_Missiles[1]
global.currentBoss="Ridley"
global.bossTrack=3

if global.gameProgress=3010
{
  instance_create(0,0,oCheckpointNotice)
  global.gameProgress=3020
}

var tempMplay;
tempMplay=findMusic(816)
playMusic(tempMplay,0,0)
