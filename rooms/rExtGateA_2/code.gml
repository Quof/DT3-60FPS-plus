locationCheck(101)
global.mapTeleport=1

backFollowFore=instance_create(0,0,oBackgroundFollow)
backFollowFore.type=2
backFollowFore.backSet=backMarioA
backFollowFore.xMoveScale=0.6
backFollowFore.yMoveScale=1
backFollowFore.depth=1499999

gameScene=instance_create(0,0,oEvExGates)

var tempMplay;
tempMplay=findMusic(101)
playMusic(tempMplay,0,0)
