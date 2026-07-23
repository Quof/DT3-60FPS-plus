locationCheck(99)

backFollowFore=instance_create(0,0,oBackgroundFollow)
backFollowFore.type=2
backFollowFore.backSet=backFarreachesA
backFollowFore.xMoveScale=0.6
backFollowFore.yMoveScale=0.92
backFollowFore.depth=1499999

gameScene=instance_create(0,0,oEvTheEnd)

var tempMplay;
tempMplay=findMusic(0)
playMusic(tempMplay,0,0)
