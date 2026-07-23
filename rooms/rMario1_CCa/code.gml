if global.gameProgress<480
  global.canCharSwap=2
if global.gameProgress=430
  global.gameProgress=440

gameScene=instance_create(0,0,oEvCh2MainA)
sideChat=instance_create(0,0,oEvCh2SideA)

var tempMplay;
tempMplay=findMusic(103)
playMusic(tempMplay,0,0)
