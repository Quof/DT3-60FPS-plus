if global.gameProgress=480
  global.gameProgress=490

gameScene=instance_create(0,0,oEvCh2MainA)
sideChat=instance_create(0,0,oEvCh2SideA)

var tempMplay;
tempMplay=findMusic(103)
playMusic(tempMplay,0,0)
