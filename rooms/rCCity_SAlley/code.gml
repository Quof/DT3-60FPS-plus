locationCheck(41)
global.challengeRoom=0

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=0; backFollow.backSet=backCCityBackA
backFollow.wSize=480; backFollow.hSize=352
backFollowFore=instance_create(0,0,oBackgroundFollow)
backFollowFore.type=2; backFollowFore.backSet=backCCityBackB
backFollowFore.xMoveScale=0.6; backFollowFore.yMoveScale=1
backFollowFore.depth=1499998; backFollowFore.image_xscale=1.22; backFollowFore.image_yscale=1.22
backFollowFore=instance_create(0,0,oBackgroundFollow)
backFollowFore.type=3; backFollowFore.backSet=backCCityBackB
backFollowFore.xMoveScale=0.5; backFollowFore.yMoveScale=1
backFollowFore.xAdjust=160; backFollowFore.yAdjust=-32; backFollowFore.depth=1499999
backFollowFore.image_xscale=1.33; backFollowFore.image_yscale=1.33; backFollowFore.image_blend=c_ltgray

gameScene=instance_create(0,0,oEvCh11MainA)
infiniteDash=instance_create(0,0,oInfiniteDash)

if global.gameProgress<=3070
{
  with oLittleBirdStaticA {instance_destroy()}
}

var tempMplay;
tempMplay=findMusic(2)
playMusic(tempMplay,0,0)
