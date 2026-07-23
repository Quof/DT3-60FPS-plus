locationCheck(84)
stopLoopingSounds()

gameScene=instance_create(0,0,oEvCh19MainA)
mapScene=instance_create(0,0,oEvCh19SideA)

if global.gameProgress<=4930
{
  with (GID(420521)) {instance_destroy()}
  tile_layer_hide(999990)
}

var tempMplay;
if global.gameProgress<=4940
{
  if global.gameProgress=4940
  {
    with oEnemyBase {instance_destroy()}
    tempMplay=findMusic(0)
  }
  else tempMplay=findMusic(24)
}
else
{
  instance_create(0,0,oHighlandChanges)
  tempMplay=findMusic(25)
}
playMusic(tempMplay,0,0)
