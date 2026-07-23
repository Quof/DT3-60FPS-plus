locationCheck(29)
global.mapTeleport=9

if global.gameProgress=1800 {global.gameProgress=1810}

bgFollow=instance_create(0,0,oBackgroundFollow)
bgFollow.type=2
bgFollow.backSet=backMM_IntroA
bgFollow.xMoveScale=0.6
bgFollow.yMoveScale=0.6
bgFollow.depth=1499999

gameScene=instance_create(0,0,oEvCh8MainA)

var tempMplay;
tempMplay=findMusic(401)
playMusic(tempMplay,0,0)
