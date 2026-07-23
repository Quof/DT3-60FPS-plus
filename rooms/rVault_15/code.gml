locationCheck(40)
if global.gameProgress>=2550 {global.mapTeleport=15}
global.partySplit=0

gameScene=instance_create(0,0,oEvCh10MainA)
mapScene=instance_create(0,0,oEvCh10SideA)
instance_create(0,0,oVaultVisualControl)

var tempMplay;
if global.gameProgress<=2450 {tempMplay=findMusic(1003)}
else {tempMplay=findMusic(11)}
playMusic(tempMplay,0,0)
