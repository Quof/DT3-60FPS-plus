locationCheck(9)
global.bTowerDefense=0
global.partySplit=0
global.bossTrack=0
global.rbSwitchBlueOn=false

if global.gameProgress<5500 {tile_layer_hide(1000001)}

if global.gameProgress=540 {global.gameProgress=550}
else if global.gameProgress>=990
{
  with oEnemyBase {instance_destroy()}
  var myChicken;
  myChicken=instance_create(880,288,oZChicken); myChicken.type=0
  myChicken=instance_create(1568,288,oZChicken); myChicken.type=0
}

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

instance_create(0,0,oBkgCityEntry)
instance_create(0,0,oBkgCityEField)

if global.gameProgress<=3870 {gameScene=instance_create(0,0,oEvCh3MainA)}
else {gameScene=instance_create(0,0,oEvCh16MainA)}
infiniteDash=instance_create(0,0,oInfiniteDash)

//Change from Defender set if player was in that when leaving the TD segment
if global.activeAbility[0]=4 {global.activeAbility[0]=1}
if global.activeAbility[1]=4 {global.activeAbility[1]=1}

if global.gameProgress<=980
{
  with oLittleBirdStaticA {instance_destroy()}
  with oBlackCrowTown {instance_destroy()}
  backFollowFore=instance_create(0,0,oBackgroundFollow)
  backFollowFore.type=1; backFollowFore.backSet=backCastlevaniaF
  backFollowFore.xScrollSpeed=-0.9; backFollowFore.yScrollSpeed=0.1
  backFollowFore.depth=1400000; backFollowFore.image_alpha=0.8
  backFollowFore=instance_create(0,0,oBackgroundFollow)
  backFollowFore.type=1; backFollowFore.backSet=backCastlevaniaF
  backFollowFore.xScrollSpeed=1.1; backFollowFore.yScrollSpeed=0.2
  backFollowFore.depth=9; backFollowFore.image_alpha=0.5
}

var tempMplay;
if global.gameProgress<=980 {tempMplay=findMusic(1014)}
else {tempMplay=findMusic(2)}
playMusic(tempMplay,0,0)
