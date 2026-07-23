locationCheck(58)
global.mapTeleport=17

gameScene=instance_create(0,0,oEvCh15MainA)
mapScene=instance_create(0,0,oEvCh15SideA)

if global.gameProgress>=3480 //Spawn warp gate after Earth Temple is complete
{
  var newExit;
  newExit=instance_create(400,288,oExit)
  newExit.sprite_index=sWarpGateStand
  newExit.bShowArrow=false; newExit.exitType=0
  newExit.newMapX=2656; newExit.newMapY=320; newExit.toRoom=rGame6_EarthF
}

var tempMplay;
tempMplay=findMusic(605)
playMusic(tempMplay,0,0)
