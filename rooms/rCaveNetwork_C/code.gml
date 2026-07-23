locationCheck(18)

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2
backFollow.backSet=backLabyrinthRuinsA
backFollow.xMoveScale=0.6; backFollow.yMoveScale=1
backFollow.depth=1499999
backFollow.image_xscale=1.8; backFollow.image_yscale=2

roomLighting=instance_create(0,0,oSurfLightF)

var tempMplay;
tempMplay=findMusic(5)
playMusic(tempMplay,0,0)
