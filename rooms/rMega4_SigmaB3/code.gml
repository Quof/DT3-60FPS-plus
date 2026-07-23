locationCheck(29)
global.mapTeleport=9

gameScene=instance_create(0,0,oEvCh8MainB)

if global.gameProgress>=1920
{
  var newExit;
  newExit=instance_create(464,256,oExit)
  newExit.bShowArrow=true; newExit.exitType=1
  newExit.newMapX=48; newExit.newMapY=3008; newExit.toRoom=rMega4_SigmaB4
  tile_layer_hide(999999)
  with (GID(231410)) {instance_destroy()}
}

if global.bossTrack=1 //Boss Fight: Bit
{
  var tempMplay,bBarrier;
  tempMplay=findMusic(810)
  bBarrier=instance_create(48,224,oBossBarrier)
  oPlayer1.x=128; oPlayer1.y=288
  storeStatus(1)
  boss=instance_create(384,288,oMMBit)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(411)
}
playMusic(tempMplay,0,0)
