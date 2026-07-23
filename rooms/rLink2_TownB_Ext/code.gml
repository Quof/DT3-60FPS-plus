locationCheck(10)
global.zEncZone=3

if global.gameProgress=650
  global.gameProgress=660

gameScene=instance_create(0,0,oEvCh4MainA)
//sideChat=instance_create(0,0,oEvCh4SideA)

var tempMplay;
tempMplay=findMusic(206)
playMusic(tempMplay,0,0)
