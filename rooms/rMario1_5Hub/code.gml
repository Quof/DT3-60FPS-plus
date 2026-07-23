if global.gameProgress=280
  global.gameProgress=290

gameScene=instance_create(0,0,oEvCh2MainA)
sideChat=instance_create(0,0,oEvCh2SideA)

var tempMplay;
tempMplay=findMusic(101)
playMusic(tempMplay,0,0)
