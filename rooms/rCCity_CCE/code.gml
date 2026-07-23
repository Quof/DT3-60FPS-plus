locationCheck(9)

if global.gameProgress=970 {global.gameProgress=980}
else if global.gameProgress>=990 and global.bBossGallery=0
{
  var newExit;
  newExit=instance_create(352,288,oExit)
  newExit.sprite_index=sWarpGateStand; newExit.bShowArrow=false
  newExit.exitType=0; newExit.newMapX=352; newExit.newMapY=304
  newExit.toRoom=rCCity_CCA
}

gameScene=instance_create(0,0,oEvCh5MainA)
compScr=instance_create(0,0,oCh5CC_CompScr)

if global.bossTrack=1 //Boss Fight: Control Virus
{
  viewFix=instance_create(336,176,oMisc)
  viewFix.type=0
  viewFix.sprite_index=sNull
  view_object[0]=viewFix
  var tempMplay;
  tempMplay=findMusic(813)
  var bossBarr;
  bossBarr=instance_create(112,144,oBossBarrier)
  bossBarr.image_yscale=2.25
  oPlayer1.x=224; oPlayer1.y=288
  storeStatus(1)
  boss=instance_create(528,272,oControlVirus)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(3)
}
playMusic(tempMplay,0,0)
