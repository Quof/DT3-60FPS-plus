if global.gameProgress=350
  global.gameProgress=360

gameScene=instance_create(0,0,oEvCh2MainA)
sideChat=instance_create(0,0,oEvCh2SideA)

var tempMplay;
tempMplay=findMusic(102)
playMusic(tempMplay,0,0)
tile_layer_delete(1100000)
