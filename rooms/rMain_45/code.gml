locationCheck(45)
global.mapTeleport=16

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2
backFollow.backSet=backBarrensA
backFollow.xMoveScale=0.6
backFollow.yMoveScale=0.92
backFollow.depth=1499999
backFollow.image_xscale=2.8
backFollow.image_yscale=2.8

gameScene=instance_create(0,0,oEvCh12MainA)
heatTrack=instance_create(0,0,oDesertHeat)

var tRanEnemy;
tRanEnemy=irandom_range(1,3)
if tRanEnemy=1
{
  instance_create(160,160,oStealthBug)
  instance_create(208,448,oStealthBug)
}
else if tRanEnemy=2
{
  instance_create(528,192,oStealthBug)
  instance_create(896,192,oStealthBug)
}
else if tRanEnemy=3
{
  instance_create(32,96,oStealthBug)
  instance_create(576,432,oStealthBug)
}

var tempMplay;
tempMplay=findMusic(13)
playMusic(tempMplay,0,0)
