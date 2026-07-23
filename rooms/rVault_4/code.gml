locationCheck(40)
if global.gameProgress>=2550 {global.mapTeleport=15}
global.partySplit=0

gameScene=instance_create(0,0,oEvCh10MainA)
mapScene=instance_create(0,0,oEvCh10SideA)
instance_create(0,0,oVaultVisualControl)

if global.gameProgress>=2170 and global.gameProgress<=2400
{
  oIdentifier.bCanScan=0; oIdentifier.deactivate=1
}

var tempMplay;
tempMplay=findMusic(11)
playMusic(tempMplay,0,0)
