if global.gameProgress=240
  global.gameProgress=250

gameScene=instance_create(0,0,oEvCh2MainA)
sideChat=instance_create(0,0,oEvCh2SideA)

var tempMplay;
tempMplay=findMusic(102)
playMusic(tempMplay,0,0)
