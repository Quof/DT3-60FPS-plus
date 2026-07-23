locationCheck(76)
global.mapTeleport=29

if global.gamePttT_Prog<60 {global.gamePttT_Prog=60}

gameScene=instance_create(0,0,oEvPttT)

var tempMplay;
tempMplay=findMusic(1024)
playMusic(tempMplay,0,0)
