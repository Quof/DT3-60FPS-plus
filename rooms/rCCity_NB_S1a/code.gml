locationCheck(9)

if global.gameProgress=1030 {global.gameProgress=1040}
global.partySplit=1

gameScene=instance_create(0,0,oEvCh5MainA)
roomControl=instance_create(0,0,oEvKeyControl)
roomControl.progCheck=1060

var tempMplay;
tempMplay=findMusic(3)
playMusic(tempMplay,0,0)
