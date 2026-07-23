locationCheck(10)
global.zEncZone=4

if global.gameProgress<=795
  global.gameProgress=800

gameScene=instance_create(0,0,oEvCh4MainA)

var tempMplay;
tempMplay=findMusic(205)
playMusic(tempMplay,0,0)
