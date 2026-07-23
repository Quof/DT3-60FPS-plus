locationCheck(34)
global.mapTeleport=0

if global.BTB_ZephSecret=0 {global.BTB_ZephSecret=1}

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2; backFollow.backSet=backMeadeland1
backFollow.xMoveScale=0.6; backFollow.yMoveScale=1; backFollow.depth=1499999

global.partySplit=0

var tempMplay;
tempMplay=findMusic(2)
playMusic(tempMplay,0,0)
