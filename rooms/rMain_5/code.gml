locationCheck(5)
global.challengeRoom=0

if global.gameProgress=70 {global.gameProgress=80}

if global.gameProgress<=90 {tile_layer_hide(999998)}

if global.gameProgress>=520
{
  with (GID(119322))
    instance_destroy()
  if global.CHAOS_Invasion=0 {instance_create(1360,928,oFireBro)}
}

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2
backFollow.backSet=backMeadeland1
backFollow.xMoveScale=0.6
backFollow.yMoveScale=1
backFollow.depth=1499999

gameScene=instance_create(0,0,oEvCh1MainA)
sideChat=instance_create(0,0,oEvCh1SideA)

var tempMplay;
tempMplay=findMusic(1)
playMusic(tempMplay,0,0)
