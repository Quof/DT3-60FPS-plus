locationCheck(9)

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

gameScene=instance_create(0,0,oEvCh3MainA)
infiniteDash=instance_create(0,0,oInfiniteDash)

if global.gameProgress<=2560 {tile_layer_hide(999990)}

if global.gameProgress<=980
{
  with oLittleBirdStaticA {instance_destroy()}
  backFollowFore=instance_create(0,0,oBackgroundFollow)
  backFollowFore.type=1; backFollowFore.backSet=backCastlevaniaF
  backFollowFore.xScrollSpeed=-0.9; backFollowFore.yScrollSpeed=0.1
  backFollowFore.depth=1400000; backFollowFore.image_alpha=0.8
  backFollowFore=instance_create(0,0,oBackgroundFollow)
  backFollowFore.type=1; backFollowFore.backSet=backCastlevaniaF
  backFollowFore.xScrollSpeed=1.1; backFollowFore.yScrollSpeed=0.5
  backFollowFore.depth=9; backFollowFore.image_alpha=0.25
}

var tempMplay;
if global.gameProgress<=980 {tempMplay=findMusic(1014)}
else {tempMplay=findMusic(2)}
playMusic(tempMplay,0,0)
