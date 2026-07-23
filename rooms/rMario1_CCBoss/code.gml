if global.gameProgress=490 {global.gameProgress=500}

oMarioLava.depth=1000010
gameScene=instance_create(0,0,oEvCh2MainA)
sideChat=instance_create(0,0,oEvCh2SideA)

if global.gameProgress=500
  global.canCharSwap=2
else if global.gameProgress>=510 and global.bBossGallery=0
{
  var tHeartContainer;
  tHeartContainer=instance_create(464,264,oHeartContainer)
  tHeartContainer.objectNum=1
  var newExit;
  newExit=instance_create(608,272,oExit)
  newExit.sprite_index=sWarpGateStand; newExit.bShowArrow=false
  newExit.exitType=0; newExit.newMapX=48; newExit.newMapY=192; newExit.toRoom=rMario1_1
}

if global.bossTrack=1 //Boss Fight: Cackletta
{
  var tempMplay,viewFix;
  tempMplay=findMusic(801)
  global.canCharSwap=1
  charSwitcher(1)
  viewFix=instance_create(464,176,oMisc)
  viewFix.type=0; viewFix.sprite_index=sNull
  view_object[0]=viewFix
  instance_create(272,208,oBossBarrier)
  oPlayer1.x=400; oPlayer1.y=272
  boss=instance_create(464,176,oCackletta)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(103)
}

playMusic(tempMplay,0,0)
SS_SetSoundFreq(global.msc_BowserFight,21550)
