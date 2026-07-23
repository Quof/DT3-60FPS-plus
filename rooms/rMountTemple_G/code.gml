locationCheck(24)

global.partySplit=1
gameScene=instance_create(0,0,oEvCh7MainA)
fanControl=instance_create(0,0,oEvCh7FanControl)
roomControl=instance_create(0,0,oEvKeyControl)
roomControl.progCheck=1670

var tempMplay;
tempMplay=findMusic(8)
playMusic(tempMplay,0,0)
