locationCheck(57)

gameScene=instance_create(0,0,oEvCh14MainA)
//rmLight=instance_create(0,0,oSurfLightB)
if global.gameProgress<=3260 {oIdentifier.bCanScan=0; oIdentifier.deactivate=1}

var tempMplay;
tempMplay=findMusic(16)
playMusic(tempMplay,0,0)
