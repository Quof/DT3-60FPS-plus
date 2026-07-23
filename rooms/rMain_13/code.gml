locationCheck(13)

if global.gameProgress=1110
  global.gameProgress=1120

gameScene=instance_create(0,0,oEvCh5MainA)
instance_create(0,0,oCh5_LeafSpawner)

var tempMplay;
tempMplay=findMusic(4)
playMusic(tempMplay,0,0)
