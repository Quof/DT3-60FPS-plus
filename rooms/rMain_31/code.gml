locationCheck(31)
if global.gameProgress=2010 {global.gameProgress=2020}

backFollowFore=instance_create(0,0,oBackgroundFollow)
backFollowFore.type=2
backFollowFore.backSet=backFarreachesA
backFollowFore.xMoveScale=0.6
backFollowFore.yMoveScale=0.92
backFollowFore.depth=1499999

gameScene=instance_create(0,0,oEvCh9MainA)

ringManager=instance_create(0,0,oCh9RingManager)
ringManager.doorID=(GID(238510))
ringManager.itemIndex=26
ringManager.ringMax=8

var tempMplay;
tempMplay=findMusic(10)
playMusic(tempMplay,0,0)
