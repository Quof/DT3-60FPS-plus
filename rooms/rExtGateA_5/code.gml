locationCheck(101)
global.mapTeleport=1

backFollowFore=instance_create(0,0,oBackgroundFollow)
backFollowFore.type=2
backFollowFore.backSet=backGateA
backFollowFore.xMoveScale=0.3
backFollowFore.yMoveScale=1
backFollowFore.depth=1499999

gameScene=instance_create(0,0,oEvExGates)

var tempMplay;
tempMplay=findMusic(105)
playMusic(tempMplay,0,0)
