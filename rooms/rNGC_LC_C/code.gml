locationCheck(57)

gameScene=instance_create(0,0,oEvCh14MainA)
mapScene=instance_create(0,0,oEvCh14SideA)

var tempMplay;
if global.gameProgress>=3240
{
  tempMplay=findMusic(1004)
  rmLight=instance_create(0,0,oSurfLightC)
  oIdentifier.bCanScan=0; oIdentifier.deactivate=1
}
else {tempMplay=findMusic(16)}
playMusic(tempMplay,0,0)
