locationCheck(29)
global.mapTeleport=9

if global.gameProgress=1820 {global.gameProgress=1830}

bgFollow=instance_create(0,0,oBackgroundFollow)
bgFollow.type=2; bgFollow.backSet=backMM_IntroA
bgFollow.xMoveScale=0.6; bgFollow.yMoveScale=0.6
bgFollow.depth=1499999

if global.gameProgress>=1840 and global.bBossGallery=0
{
  var newExit;
  newExit=instance_create(336,240,oExit)
  newExit.sprite_index=sWarpGateStand
  newExit.bShowArrow=false; newExit.exitType=0
  newExit.newMapX=1856; newExit.newMapY=240; newExit.toRoom=rMega4_Map
}

gameScene=instance_create(0,0,oEvCh8MainA)

if global.bossTrack=1 //Boss Fight: Maoh the Giant
{
  var tempMplay,bBarrier;
  tempMplay=findMusic(810)
  bBarrier=instance_create(80,176,oBossBarrier)
  oPlayer1.x=336; oPlayer1.y=240
  storeStatus(1)
  boss=instance_create(336,176,oMaohTheGiant)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(401)
}
playMusic(tempMplay,0,0)
