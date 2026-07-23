if global.gameProgress=400
  global.gameProgress=401

gameScene=instance_create(0,0,oEvCh2MainA)
sideChat=instance_create(0,0,oEvCh2SideA)

var tempMplay;
tempMplay=findMusic(101)
playMusic(tempMplay,0,0)
