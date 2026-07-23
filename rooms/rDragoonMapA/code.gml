locationCheck(94)
global.mapTeleport=0
global.bShooter=1
global.bossTrack=110

gameScene=instance_create(0,0,oEvShooter)
oPlayer1.life=oPlayer1.maxLife

var tempMplay;
tempMplay=findMusic(1018)
playMusic(tempMplay,0,0)
