locationCheck(57)

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2
backFollow.backSet=backNeoGrimeB
backFollow.xMoveScale=0.6
backFollow.yMoveScale=0.92
backFollow.depth=1499999
backFollow.image_xscale=2
backFollow.image_yscale=2

gameScene=instance_create(0,0,oEvCh14MainA)
global.rbSwitchBlueOn=false

var tempMplay;
tempMplay=findMusic(15)
playMusic(tempMplay,0,0)
