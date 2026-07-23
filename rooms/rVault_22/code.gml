locationCheck(40)
if global.gameProgress>=2550 {global.mapTeleport=15}
global.partySplit=0

gameScene=instance_create(0,0,oEvCh10MainA)
instance_create(0,0,oVaultVisualControl)

if global.bossTrack=101
{
  oPlayer1.x=512; oPlayer1.y=272
}

var tempMplay;
tempMplay=findMusic(11)
playMusic(tempMplay,0,0)
