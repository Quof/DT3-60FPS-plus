if global.gameProgress=370
  global.gameProgress=380

gameScene=instance_create(0,0,oEvCh2MainA)
sideChat=instance_create(0,0,oEvCh2SideA)

var tempMplay;
tempMplay=findMusic(102)
playMusic(tempMplay,0,0)
