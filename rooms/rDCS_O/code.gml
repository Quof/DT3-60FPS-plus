locationCheck(90)

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2
backFollow.backSet=backDCS_A; backFollow.xMoveScale=0.6; backFollow.yMoveScale=0.92
backFollow.image_xscale=1.65; backFollow.image_yscale=1.65
backFollow.depth=1499999

gameScene=instance_create(0,0,oEvDCS)
mapScene=instance_create(0,0,oEvCh19SideA)

var tempMplay;
tempMplay=findMusic(6)
playMusic(tempMplay,0,0)
