locationCheck(99)

global.partySplit=1

gameScene=instance_create(0,0,oEvCh20MainA)
mapScene=instance_create(0,0,oEvCh20SideA)
roomControl=instance_create(0,0,oEvKeyControl)
roomControl.progCheck=5230

var tempMplay;
tempMplay=findMusic(1015)
playMusic(tempMplay,0,0)
