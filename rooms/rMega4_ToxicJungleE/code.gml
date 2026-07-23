locationCheck(29)
global.mapTeleport=9

gameScene=instance_create(0,0,oEvCh8MainA)

bgFollow=instance_create(0,0,oBackgroundFollow)
bgFollow.type=2; bgFollow.backSet=backMM_ToxicJungleA
bgFollow.xMoveScale=0.6; bgFollow.yMoveScale=1
bgFollow.image_xscale=1.875; bgFollow.image_yscale=1.6; bgFollow.depth=1499999

var gameProgCheck;
gameProgCheck=string_char_at(global.gameGate4Prog,3)
if gameProgCheck="9" and global.bBossGallery=0
{
  var newExit;
  newExit=instance_create(240,288,oExit)
  newExit.sprite_index=sWarpGateStand
  newExit.bShowArrow=false; newExit.exitType=0
  newExit.newMapX=0; newExit.newMapY=0; newExit.toRoom=rMega4_Map
}

if global.bossTrack=1 //Boss Fight: Gravity Beetle
{
  var tempMplay;
  tempMplay=findMusic(810)
  storeStatus(1)
  boss=instance_create(336,288,oGravityBeetle)
  boss.activateBoss=1; boss.image_xscale=-1
}
else
{
  var tempMplay;
  tempMplay=findMusic(0)
}
playMusic(tempMplay,0,0)
