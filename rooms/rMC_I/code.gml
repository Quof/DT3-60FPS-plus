locationCheck(93)
if global.gameProgress=4970 {global.gameProgress=4980}

gameScene=instance_create(0,0,oEvCh19MainA)
roomLighting=instance_create(0,0,oSurfLightE)

var tempMplay;
tempMplay=findMusic(30)
playMusic(tempMplay,0,0)
