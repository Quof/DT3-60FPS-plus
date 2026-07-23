if global.gameProgress=470
{
  global.canCharSwap=2
  global.gameProgress=480
}

gameScene=instance_create(0,0,oEvCh2MainA)
sideChat=instance_create(0,0,oEvCh2SideA)

var tempMplay;
tempMplay=findMusic(103)
playMusic(tempMplay,0,0)
tile_layer_delete(1100000)
