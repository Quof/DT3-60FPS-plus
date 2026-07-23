locationCheck(29)
global.mapTeleport=9

gameScene=instance_create(0,0,oEvCh8MainA)

var gameProgCheck;
gameProgCheck=string_char_at(global.gameGate4Prog,1)
if gameProgCheck="9" and global.bBossGallery=0
{
  var newExit;
  newExit=instance_create(432,272,oExit)
  newExit.sprite_index=sWarpGateStand
  newExit.bShowArrow=false; newExit.exitType=0
  newExit.newMapX=0; newExit.newMapY=0; newExit.toRoom=rMega4_Map
}

if global.bossTrack=1 //Boss Fight: Storm Eagle
{
  var tempMplay;
  tempMplay=findMusic(810)
  oPlayer1.x=432; oPlayer1.y=272
  storeStatus(1)
  boss=instance_create(576,272,oStormEagle)
  boss.activateBoss=1; boss.image_xscale=-1
}
else
{
  var tempMplay;
  tempMplay=findMusic(0)
}
playMusic(tempMplay,0,0)
