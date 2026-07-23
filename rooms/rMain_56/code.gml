locationCheck(56)

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2
backFollow.backSet=backBurningStretchA
backFollow.xMoveScale=0.6
backFollow.yMoveScale=0.92
backFollow.depth=1499999

gameScene=instance_create(0,0,oEvCh14MainA)

if global.gameProgress<=3350
{
  tile_layer_hide(999999)
  with (GID(316282)) {instance_destroy()}
  with (GID(316283)) {instance_destroy()}
  with (GID(316284)) {instance_destroy()}
  with (GID(316285)) {instance_destroy()}
  with (GID(316286)) {instance_destroy()}
  with (GID(316343)) {instance_destroy()}
}

var tempMplay;
tempMplay=findMusic(14)
playMusic(tempMplay,0,0)
