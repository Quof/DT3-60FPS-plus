locationCheck(29)
global.mapTeleport=9

gameScene=instance_create(0,0,oEvCh8MainB)

if global.gameProgress>=1950 and global.bBossGallery=0
{
  var newExit;
  newExit=instance_create(240,288,oExit)
  newExit.sprite_index=sWarpGateStand
  newExit.bShowArrow=false; newExit.exitType=0
  newExit.newMapX=0; newExit.newMapY=0; newExit.toRoom=rMega4_Map
}

if global.bossTrack=1 //Boss Fight: Byte
{
  var tempMplay,bBarrier;
  tempMplay=findMusic(810)
  bBarrier=instance_create(48,224,oBossBarrier)
  oPlayer1.x=240; oPlayer1.y=288
  boss=instance_create(380,288,oMMBit)
  boss.activateBoss=1
  boss=instance_create(100,288,oMMByte)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(411)
}
playMusic(tempMplay,0,0)
