locationCheck(29)
global.mapTeleport=9

gameScene=instance_create(0,0,oEvCh8MainB)

if global.gameProgress>=1900 and global.bBossGallery=0
{
  var newExit;
  newExit=instance_create(240,256,oExit)
  newExit.sprite_index=sWarpGateStand
  newExit.bShowArrow=false; newExit.exitType=0
  newExit.newMapX=0; newExit.newMapY=0; newExit.toRoom=rMega4_Map
}

if global.bossTrack=1 //Boss Fight: Bospider
{
  var tempMplay;
  tempMplay=findMusic(810)
  storeStatus(1)
  boss=instance_create(264,-44,oBospider)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(410)
}
playMusic(tempMplay,0,0)
