locationCheck(40)
global.mapTeleport=14
global.bCanSave=0

gameScene=instance_create(0,0,oEvCh10MainA)
instance_create(0,0,oVaultVisualControl)
vaultMap=instance_create(0,0,oEvCh10VaultRoomMap)

var tempMplay;
tempMplay=findMusic(11)
playMusic(tempMplay,0,0)
