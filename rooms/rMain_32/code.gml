locationCheck(32)
global.challengeRoom=0

backFollowFore=instance_create(0,0,oBackgroundFollow)
backFollowFore.type=2
backFollowFore.backSet=backFarreachesA
backFollowFore.xMoveScale=0.6
backFollowFore.yMoveScale=0.95
backFollowFore.depth=1499999

gameScene=instance_create(0,0,oEvCh9MainA)

ringManager=instance_create(0,0,oCh9RingManager)
ringManager.doorID=(GID(239204))
ringManager.itemIndex=28
ringManager.ringMax=29

var tempMplay;
tempMplay=findMusic(10)
playMusic(tempMplay,0,0)
