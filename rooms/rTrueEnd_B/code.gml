oIdentifier.bCanScan=0; oIdentifier.deactivate=1
tile_layer_hide(1100000)

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=0; backFollow.backSet=backCCityBackA
backFollow.wSize=480; backFollow.hSize=352
backFollowFore=instance_create(0,0,oBackgroundFollow)
backFollowFore.type=2; backFollowFore.backSet=backCCityBackB
backFollowFore.xMoveScale=0.5; backFollowFore.yMoveScale=1
backFollowFore.depth=1499998; backFollowFore.image_xscale=1.22; backFollowFore.image_yscale=1.22
backFollowFore=instance_create(0,0,oBackgroundFollow)
backFollowFore.type=3; backFollowFore.backSet=backCCityBackB
backFollowFore.xMoveScale=0.7; backFollowFore.yMoveScale=1
backFollowFore.xAdjust=160; backFollowFore.yAdjust=-32
backFollowFore.depth=1499999; backFollowFore.image_blend=c_ltgray
backFollowFore.image_xscale=1.33; backFollowFore.image_yscale=1.33

gameScene=instance_create(0,0,oTrueEndSeq)

var tempMplay;
tempMplay=findMusic(0)
playMusic(tempMplay,0,0)
