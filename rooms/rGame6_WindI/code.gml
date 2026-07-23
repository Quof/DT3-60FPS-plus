locationCheck(58)
global.mapTeleport=0

gameScene=instance_create(0,0,oEvCh15MainA)

var tempMplay;
if global.bossTrack=0 {tempMplay=findMusic(605)}
else if global.bossTrack=1 //Boss Fight: The Unforgotten
{
  tempMplay=findMusic(819)
  oPlayer1.x=368; oPlayer1.y=208
  var viewFix,boss,enemyBarrier;
  viewFix=instance_create(368,208,oMisc)
  viewFix.type=0
  viewFix.sprite_index=sNull
  view_object[0]=viewFix
  boss=instance_create(560,130,oPT_Unforgotten)
  boss.activateBoss=1
  enemyBarrier=instance_create(112,224,oEnemyBarrier); enemyBarrier.image_yscale=4
  enemyBarrier=instance_create(608,224,oEnemyBarrier); enemyBarrier.image_yscale=4
}

playMusic(tempMplay,0,0)
