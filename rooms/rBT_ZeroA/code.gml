locationCheck(34)
global.mapTeleport=41
global.rbSwitchBlueOn=false

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=1; backFollow.backSet=backBTB_ZeroA
backFollow.xScrollSpeed=1 backFollow.depth=1499999

var tempMplay;
tempMplay=findMusic(31)
playMusic(tempMplay,0,0)
