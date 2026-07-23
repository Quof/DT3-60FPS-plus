locationCheck(58)
global.mapTeleport=0
global.rbSwitchBlueOn=false

gameScene=instance_create(0,0,oEvCh15MainA)
cloudMgr=instance_create(0,0,oEvCh15CloudMgr)

if global.gameProgress>=3810 {greatBird=instance_create(0,0,oGreatBird)}

var tempMplay;
tempMplay=findMusic(601)
playMusic(tempMplay,0,0)
