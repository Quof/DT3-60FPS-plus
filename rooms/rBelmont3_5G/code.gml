locationCheck(15)

if global.gameProgress=1380
  global.gameProgress=1390

gameScene=instance_create(0,0,oEvCh6MainA)
blackTop=instance_create(0,0,oG2_BlackTop)

var tempMplay;
tempMplay=findMusic(305)
playMusic(tempMplay,0,0)
