locationCheck(59)
if global.gameProgress=3940 {global.gameProgress=3950}
else if global.gameProgress=3960 {global.gameProgress=3965}

gameScene=instance_create(0,0,oEvCh17MainA)

if global.bossTrack=1 //Boss Fight: Antipathy
{
  viewFix=instance_create(480,176,oMisc)
  viewFix.type=0
  viewFix.sprite_index=sNull
  view_object[0]=viewFix
  var tempMplay;
  tempMplay=findMusic(813)
  var enemyBarrier;
  enemyBarrier=instance_create(304,112,oSolidVirusBlock); enemyBarrier.image_yscale=10
  enemyBarrier=instance_create(640,112,oSolidVirusBlock); enemyBarrier.image_yscale=10
  oPlayer1.x=480; oPlayer1.y=272
  storeStatus(1)
  with oNPC_GeneralA {instance_destroy()}
  boss=instance_create(384,272,oAntiAlpha)
  boss.activateBoss=1
  boss=instance_create(576,272,oAntiBeta)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(19)
}
playMusic(tempMplay,0,0)
