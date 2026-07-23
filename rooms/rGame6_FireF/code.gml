locationCheck(58)
if global.gameProgress>=3545 {global.mapTeleport=18}

gameScene=instance_create(0,0,oEvCh15MainA)
mapScene=instance_create(0,0,oEvCh15SideA)

if global.gameProgress<=3540 {oIdentifier.bCanScan=0; oIdentifier.deactivate=1}

var tempMplay;
tempMplay=findMusic(605)
playMusic(tempMplay,0,0)
