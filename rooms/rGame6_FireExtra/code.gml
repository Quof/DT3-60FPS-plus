locationCheck(58)
global.partySplit=1
if global.gameProgress>=3545 {global.mapTeleport=18}

gameScene=instance_create(0,0,oEvCh15MainA)
mapScene=instance_create(0,0,oEvCh15SideA)
roomControl=instance_create(0,0,oEvKeyControl)
roomControl.progCheck=10000

var tempMplay;
tempMplay=findMusic(605)
playMusic(tempMplay,0,0)
