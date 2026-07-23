locationCheck(29)
global.mapTeleport=9

gameScene=instance_create(0,0,oEvCh8MainB)

bgFollow=instance_create(0,0,oBackgroundFollow)
bgFollow.type=3; bgFollow.backSet=backMM_SigmaC1
bgFollow.xMoveScale=0.6; bgFollow.yMoveScale=0.85
bgFollow.xAdjust=0; bgFollow.yAdjust=48
bgFollow.image_xscale=1.6; bgFollow.image_yscale=1.6
bgFollow.depth=1499999

var tempMplay;
tempMplay=findMusic(412)
playMusic(tempMplay,0,0)
