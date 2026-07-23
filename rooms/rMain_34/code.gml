locationCheck(34)
global.mapTeleport=0

backFollowFore=instance_create(0,0,oBackgroundFollow)
backFollowFore.type=2
backFollowFore.backSet=backFarreachesA
backFollowFore.xMoveScale=0.6
backFollowFore.yMoveScale=0.95
backFollowFore.depth=1499999

gameScene=instance_create(0,0,oEvCh9MainA)

ringManager=instance_create(0,0,oCh9RingManager)
ringManager.doorID=(GID(241032))
ringManager.itemIndex=31
ringManager.ringMax=15

if global.gameProgress!=4940
{
  if global.gameProgress>=2040
  {
    var newDoor;
    newDoor=instance_create(1080,1072,oExit)
    newDoor.bShowArrow=true; newDoor.exitType=0
    newDoor.newMapX=240; newDoor.newMapY=304; newDoor.toRoom=rBubbleTowerMain
    with oSignPost {instance_destroy()}
  }
}

if global.gameProgress>=2090 and global.gameProgress<=2620 {bubbleHelp=instance_create(0,0,oEvCh9BubLoveHelp)}
var tempMplay;
tempMplay=findMusic(10)
playMusic(tempMplay,0,0)
