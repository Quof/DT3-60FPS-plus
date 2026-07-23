locationCheck(78)
global.mapTeleport=0

gameScene=instance_create(0,0,oEvCh9MainA)
instance_create(0,0,oCh5_LeafSpawner)

if global.gameProgress>=4790
{
  instance_create(0,0,oEvSpiderBotFalls)
}

var tempMplay;
tempMplay=findMusic(4)
playMusic(tempMplay,0,0)
