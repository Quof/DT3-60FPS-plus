locationCheck(34)
if global.gameProgress>=2090 {global.mapTeleport=28}

charSwitcher(0)
global.partySplit=1
gameScene=instance_create(0,0,oEvCh9MainA)
roomControl=instance_create(0,0,oEvKeyControl)
roomControl.progCheck=2080

var tempMplay;
tempMplay=findMusic(10)
playMusic(tempMplay,0,0)
