locationCheck(40)
if global.gameProgress>=2550 {global.mapTeleport=15}

gameScene=instance_create(0,0,oEvCh10MainA)
mapScene=instance_create(0,0,oEvCh10SideA)
instance_create(0,0,oVaultVisualControl)

colorControl=instance_create(0,0,oColorIndControl)
colorControl.warnDelay=310

if global.gameProgress>=2170 and global.gameProgress<=2400
{
  oIdentifier.bCanScan=0; oIdentifier.deactivate=1
}

var tempMplay;
tempMplay=findMusic(11)
playMusic(tempMplay,0,0)
