locationCheck(58)

if global.gameProgress=3740 {global.gameProgress=3750}
global.canCharSwap=2

gameScene=instance_create(0,0,oEvCh15MainA)
dreamScene=instance_create(0,0,oEvCh15Dream)

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2
backFollow.backSet=backDreamWoods
backFollow.xMoveScale=0.6; backFollow.yMoveScale=1
backFollow.depth=1499999
backFollow.image_xscale=1.88; backFollow.image_yscale=1.88

instance_create(x,y,oG6DreamWoodEf)

var tempMplay;
tempMplay=findMusic(606)
playMusic(tempMplay,0,0)
