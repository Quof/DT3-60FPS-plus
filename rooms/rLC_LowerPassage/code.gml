locationCheck(70)

global.gamePaused=false
global.canPause=0

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2
backFollow.backSet=backLavaCave
backFollow.xMoveScale=0.6
backFollow.yMoveScale=0.6
backFollow.depth=1499999

gameScene=instance_create(0,0,oEvCh18MainA)
mapScene=instance_create(0,0,oEvCh18SideA)
buggyScene=instance_create(0,0,oEvBuggyEvents)

var tempMplay;
tempMplay=findMusic(0)
playMusic(tempMplay,0,0)
