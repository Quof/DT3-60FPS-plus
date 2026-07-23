locationCheck(90)

gameScene=instance_create(0,0,oEvDCS)
mapScene=instance_create(0,0,oEvCh19SideA)

var tempMplay;
tempMplay=findMusic(6)
playMusic(tempMplay,0,0)

if global.bossTrack=1 //Boss Fight: Shadow Eura
{
  var tempMplay,viewFix,enemyBarrier,boss,myRock;
  tempMplay=findMusic(827)
  viewFix=instance_create(352,176,oMisc)
  viewFix.type=0
  viewFix.sprite_index=sNull
  view_object[0]=viewFix
  enemyBarrier=instance_create(144,224,oEnemyBarrier); enemyBarrier.image_yscale=4
  enemyBarrier=instance_create(544,224,oEnemyBarrier); enemyBarrier.image_yscale=4
  oPlayer1.x=352; oPlayer1.y=288
  storeStatus(1)
  boss=instance_create(352,76,oShadowEura)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(6)
}
playMusic(tempMplay,0,0)
