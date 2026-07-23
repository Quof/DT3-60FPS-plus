locationCheck(10)
secondaryLocCheck(3,1)
global.zEncZone=3

gameScene=instance_create(0,0,oEvCh4MainA)

var tempMplay;
if global.gameProgress>=840
  tempMplay=findMusic(201)
else
  tempMplay=findMusic(202)
playMusic(tempMplay,0,0)
