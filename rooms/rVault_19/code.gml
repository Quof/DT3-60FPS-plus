locationCheck(40)
if global.gameProgress>=2550 {global.mapTeleport=15}

gameScene=instance_create(0,0,oEvCh10MainA)
instance_create(0,0,oVaultVisualControl)

colorControl=instance_create(0,0,oColorIndControl)
colorControl.warnDelay=300

var tempMplay;
tempMplay=findMusic(11)
playMusic(tempMplay,0,0)
