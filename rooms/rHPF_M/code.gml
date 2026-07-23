locationCheck(59)

gameScene=instance_create(0,0,oEvCh17MainA)
mapScene=instance_create(0,0,oEvCh17SideA)

if global.gameProgress>=4030
{
  tile_layer_hide(1000002)
  with (GID(357361)) {instance_destroy()}
}

var tempMplay;
tempMplay=findMusic(19)
playMusic(tempMplay,0,0)
