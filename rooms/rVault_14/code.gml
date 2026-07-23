locationCheck(40)
if global.gameProgress>=2550 {global.mapTeleport=15}
global.partySplit=1

gameScene=instance_create(0,0,oEvCh10MainA)
instance_create(0,0,oVaultVisualControl)
roomControl=instance_create(0,0,oEvKeyControl)
roomControl.progCheck=2450

if global.gameProgress>=2430 and global.gameProgress<=2450 //Disable Chao
{
  oIdentifier.bCanScan=0; oIdentifier.deactivate=1
}
else if global.gameProgress>=2460 //Remove wall to go back
{
  tile_layer_hide(1000020)
  with (GID(251210)) {instance_destroy()}
}

if global.gameProgress>=2440
{
  colorControl=instance_create(0,0,oColorIndControl)
  colorControl.warnDelay=450

  var tempMplay;
  if global.gameProgress<=2450 {tempMplay=findMusic(1003)}
  else {tempMplay=findMusic(11)}
  playMusic(tempMplay,0,0)
}
