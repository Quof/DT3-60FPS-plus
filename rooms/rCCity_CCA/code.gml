locationCheck(9)

if global.gameProgress>=990
{
  var newExit;
  newExit=instance_create(352,304,oExit)
  newExit.sprite_index=sWarpGateStand; newExit.bShowArrow=false
  newExit.exitType=0; newExit.newMapX=352; newExit.newMapY=288
  newExit.toRoom=rCCity_CCE
}

gameScene=instance_create(0,0,oEvCh5MainA)

var tempMplay;

if global.gameProgress<=920
  tempMplay=findMusic(1014)
else
  tempMplay=findMusic(3)
playMusic(tempMplay,0,0)
