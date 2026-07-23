locationCheck(1)

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2; backFollow.backSet=backMeadeland1
backFollow.xMoveScale=0.6; backFollow.yMoveScale=1; backFollow.depth=1499999

gameScene=instance_create(0,0,oEvCh1MainA)

indexCheck=string_char_at(global.gameOptShortcuts,2)
if indexCheck="1"
{
  tile_layer_hide(999990)
  with (GID(470408)) {instance_destroy()}
}

if global.gameProgress=2
{
  storeStatus(1)
  instance_create(224,2048,oBustMoveMachine)
}
else if global.gameProgress>=10
{
  var tempMplay;
  tempMplay=findMusic(1)
  playMusic(tempMplay,0,0)
}
