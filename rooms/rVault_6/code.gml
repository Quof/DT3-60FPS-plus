locationCheck(40)
global.partySplit=0
if global.gameProgress>=2550 {global.mapTeleport=15}

if global.gameProgress=2290 {global.gameProgress=2300}

if global.gameProgress<=2300 {tile_layer_hide(1000020)}

gameScene=instance_create(0,0,oEvCh10MainA)
instance_create(0,0,oVaultVisualControl)

if global.gameProgress>=2170 and global.gameProgress<=2400
{
  oIdentifier.bCanScan=0; oIdentifier.deactivate=1
}

var tempMplay;
tempMplay=findMusic(11)
playMusic(tempMplay,0,0)
