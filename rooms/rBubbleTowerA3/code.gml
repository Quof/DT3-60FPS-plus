locationCheck(34)
if global.gameProgress>=2090 {global.mapTeleport=28}

charSwitcher(0)
global.partySplit=1
gameScene=instance_create(0,0,oEvCh9MainA)

var tempMplay;
tempMplay=findMusic(10)
playMusic(tempMplay,0,0)
