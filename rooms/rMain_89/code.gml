locationCheck(89)
global.mapTeleport=0

if global.gameProgress>=4720
{
  tile_layer_hide(999995)
  with (GID(402474)) {instance_destroy()}
}

backFollowFore=instance_create(0,0,oBackgroundFollow)
backFollowFore.type=2
backFollowFore.backSet=backFarreachesA
backFollowFore.xMoveScale=0.6
backFollowFore.yMoveScale=0.92
backFollowFore.depth=1499999

gameScene=instance_create(0,0,oEvCh9MainA)

ringManager=instance_create(0,0,oCh9RingManager)
ringManager.doorID=(GID(402467))
ringManager.itemIndex=74
ringManager.ringMax=31

var tempMplay;
tempMplay=findMusic(10)
playMusic(tempMplay,0,0)
