locationCheck(105)
global.mapTeleport=5

gameScene=instance_create(0,0,oEvExGates)
instance_create(0,0,oVaultVisualControl)

colorControl=instance_create(0,0,oColorIndControl)
colorControl.warnDelay=60

var tempMplay;
tempMplay=findMusic(11)
playMusic(tempMplay,0,0)
