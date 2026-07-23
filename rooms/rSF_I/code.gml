locationCheck(91)
if global.gameProgress>=4940 {global.mapTeleport=22}

gameScene=instance_create(0,0,oEvSF)
roomControl=instance_create(0,0,oEvKeyControl)
roomControl.progCheck=4940

instance_create(x,y,oG6DreamWoodEf)

var tempMplay;
tempMplay=findMusic(29)
playMusic(tempMplay,0,0)
