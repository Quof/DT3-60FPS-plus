locationCheck(29)
global.mapTeleport=9

if global.gameProgress=1975 {global.gameProgress=1980}

if global.gameProgress>=1990 and global.bBossGallery=0
{
  var tHeartContainer;
  tHeartContainer=instance_create(240,280,oHeartContainer)
  tHeartContainer.objectNum=4
  var newExit;
  newExit=instance_create(352,288,oExit)
  newExit.sprite_index=sWarpGateStand
  newExit.bShowArrow=false; newExit.exitType=0
  newExit.newMapX=0; newExit.newMapY=0; newExit.toRoom=rMega4_Map
}

gameScene=instance_create(0,0,oEvCh8MainB)

bgFollow=instance_create(0,0,oBackgroundFollow)
bgFollow.type=3; bgFollow.backSet=backMM_SigmaC1
bgFollow.xMoveScale=0.6; bgFollow.yMoveScale=1
bgFollow.xAdjust=0; bgFollow.yAdjust=40
bgFollow.image_xscale=1.6; bgFollow.image_yscale=1.6
bgFollow.depth=1499999

if global.bossTrack=1 //Boss Fight: Sigma
{
  var tempMplay;
  tempMplay=findMusic(412)
  boss=instance_create(352,288,oSigmaA)
  boss.activateBoss=1
}
else if global.bossTrack=3 //Boss Fight: Sigma Epsilon
{
  var tempMplay;
  tempMplay=findMusic(812)
  boss=instance_create(358,208,oSigmaB)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(412)
}
playMusic(tempMplay,0,0)
