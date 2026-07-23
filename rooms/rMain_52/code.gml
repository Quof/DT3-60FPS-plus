locationCheck(52)

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2
backFollow.backSet=backBurningStretchA
backFollow.xMoveScale=0.6
backFollow.yMoveScale=0.92
backFollow.depth=1499999

gameScene=instance_create(0,0,oEvCh14MainA)

var tempMplay;
tempMplay=findMusic(14)
playMusic(tempMplay,0,0)
