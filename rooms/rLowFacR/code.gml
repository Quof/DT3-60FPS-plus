locationCheck(69)

bgFollow=instance_create(0,0,oBackgroundFollow)
bgFollow.type=2
bgFollow.backSet=backMM_IntroA
bgFollow.xMoveScale=0.6
bgFollow.yMoveScale=0.6
bgFollow.depth=1499999

gameScene=instance_create(0,0,oEvCh18MainA)
mapScene=instance_create(0,0,oEvCh18SideA)

if global.bossTrack=1 //Boss Fight: Advanced Combat Apparatus
{
  var tempMplay;
  tempMplay=findMusic(825)
  var enemyBarrier,boss;
  enemyBarrier=instance_create(976,384,oEnemyBarrier); enemyBarrier.image_yscale=4
  oPlayer1.x=576; oPlayer1.y=736
  storeStatus(1)
  boss=instance_create(816,544,oCACA_Main)
  boss.activateBoss=1
}
else
{
  SS_SetSoundVol(global.msc_WeaponFacility,global.optMusic*100)
  var tempMplay;
  tempMplay=findMusic(22)
}
playMusic(tempMplay,0,0)
