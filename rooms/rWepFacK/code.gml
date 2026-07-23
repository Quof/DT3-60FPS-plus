locationCheck(69)

gameScene=instance_create(0,0,oEvCh18MainA)
mapScene=instance_create(0,0,oEvCh18SideA)

if global.bossTrack=1 //Boss Fight: Brain Machine
{
  viewFix=instance_create(288,176,oMisc)
  viewFix.type=0
  viewFix.sprite_index=sNull
  view_object[0]=viewFix
  var tempMplay;
  tempMplay=findMusic(825)
  var enemyBarrier;
  enemyBarrier=instance_create(512,224,oEnemyBarrier); enemyBarrier.image_yscale=4
  oPlayer1.x=416; oPlayer1.y=288
  storeStatus(1)
  boss=instance_create(288,160,oBrainMachine)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(16)
}
playMusic(tempMplay,0,0)
