locationCheck(9)

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=0
backFollow.backSet=backCCityBackA
backFollow.wSize=480
backFollow.hSize=352

gameScene=instance_create(0,0,oEvCh3MainA)
infiniteDash=instance_create(0,0,oInfiniteDash)

if global.gameProgress<=980
{
  with oLittleBirdStaticA {instance_destroy()}
  backFollowFore=instance_create(0,0,oBackgroundFollow)
  backFollowFore.type=1; backFollowFore.backSet=backCastlevaniaF
  backFollowFore.xScrollSpeed=-0.9; backFollowFore.yScrollSpeed=0.1
  backFollowFore.depth=1400000; backFollowFore.image_alpha=0.8
  backFollowFore=instance_create(0,0,oBackgroundFollow)
  backFollowFore.type=1; backFollowFore.backSet=backCastlevaniaF
  backFollowFore.xScrollSpeed=1.1; backFollowFore.yScrollSpeed=0.2
  backFollowFore.depth=9; backFollowFore.image_alpha=0.35
}

var tempMplay;
if global.gameProgress<=980 {tempMplay=findMusic(1014)}
else {tempMplay=findMusic(2)}
playMusic(tempMplay,0,0)
