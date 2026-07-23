locationCheck(9)

if global.gameProgress=560 {global.gameProgress=570}
else if global.gameProgress=990 {global.gameProgress=1000}
else if global.gameProgress=1520 {global.gameProgress=1530}
else if global.gameProgress=1990 {global.gameProgress=2000}
else if global.gameProgress=2550 {global.gameProgress=2560}

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=0
backFollow.backSet=backCCityBackA
backFollow.wSize=480
backFollow.hSize=352

if global.gameProgress<=990 {gameScene=instance_create(0,0,oEvCh3MainA)}
else if global.gameProgress>=1000 and global.gameProgress<=1520 {gameScene=instance_create(0,0,oEvCh5MainA)}
else if global.gameProgress>=1530 and global.gameProgress<=1990 {gameScene=instance_create(0,0,oEvCh7MainA)}
else if global.gameProgress>=2000 and global.gameProgress<=2540 {gameScene=instance_create(0,0,oEvCh9MainA)}
else if global.gameProgress>=2550 and global.gameProgress<=3860 {gameScene=instance_create(0,0,oEvCh11MainA)}
else if global.gameProgress>=3870 and global.gameProgress<=10000 {gameScene=instance_create(0,0,oEvCh16MainA)}
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
