locationCheck(76)
global.desertHeat=1500

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2
backFollow.backSet=backMeadeland1
backFollow.xMoveScale=0.6
backFollow.yMoveScale=1
backFollow.depth=1499999

var tempMplay;
tempMplay=findMusic(0)
playMusic(tempMplay,0,0)
