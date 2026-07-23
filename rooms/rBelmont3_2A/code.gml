locationCheck(15)

if global.gameProgress=1190
  global.gameProgress=1200

gameScene=instance_create(0,0,oEvCh6MainA)
//sideChat=instance_create(0,0,oEvCh4SideA)
blackTop=instance_create(0,0,oG2_BlackTop)

var tempMplay;
tempMplay=findMusic(302)
playMusic(tempMplay,0,0)
