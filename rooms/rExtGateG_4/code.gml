locationCheck(107)
global.mapTeleport=7

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2
backFollow.backSet=backG6ForgottenIsles
backFollow.xMoveScale=0.6; backFollow.yMoveScale=1
backFollow.depth=1499999
backFollow.image_xscale=2; backFollow.image_yscale=2
backDraw=instance_create(0,0,oG6_CastleBack)
backDraw.yStartDraw=207

gameScene=instance_create(0,0,oEvExGates)

var tempMplay;
tempMplay=findMusic(905)
playMusic(tempMplay,0,0)
