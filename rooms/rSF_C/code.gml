locationCheck(91)
if global.gameProgress>=4940 {global.mapTeleport=22}
if global.gameProgress<=4840 {global.gameProgress=4850}

gameScene=instance_create(0,0,oEvSF)

instance_create(x,y,oG6DreamWoodEf)

var tempMplay;
tempMplay=findMusic(29)
playMusic(tempMplay,0,0)
