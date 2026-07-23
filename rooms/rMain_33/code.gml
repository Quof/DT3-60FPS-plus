locationCheck(33)

backFollowFore=instance_create(0,0,oBackgroundFollow)
backFollowFore.type=2
backFollowFore.backSet=backFarreachesA
backFollowFore.xMoveScale=0.6
backFollowFore.yMoveScale=0.89
backFollowFore.depth=1499999

gameScene=instance_create(0,0,oEvCh9MainA)

ringManager=instance_create(0,0,oCh9RingManager)
ringManager.doorID=(GID(239887))
ringManager.itemIndex=29
ringManager.ringMax=7

var tempMplay;
tempMplay=findMusic(10)
playMusic(tempMplay,0,0)
