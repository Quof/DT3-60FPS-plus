locationCheck(49)

gameScene=instance_create(0,0,oEvCh13MainA)
metroidControl=instance_create(0,0,oEvCh13MetroidControl)

if global.gameProgress>=3070
{
  var newExit;
  newExit=instance_create(352,272,oExit)
  newExit.sprite_index=sWarpGateStand
  newExit.bShowArrow=false
  newExit.exitType=0
  newExit.newMapX=144
  newExit.newMapY=320
  newExit.toRoom=rSamus5_Lv4_A
}

var tempMplay;
tempMplay=findMusic(505)
playMusic(tempMplay,0,0)
