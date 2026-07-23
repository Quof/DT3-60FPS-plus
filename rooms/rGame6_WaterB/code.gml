locationCheck(58)

gameScene=instance_create(0,0,oEvCh15MainA)
mapScene=instance_create(0,0,oEvCh15SideA)

var tempMplay;
if global.bossTrack=0 {tempMplay=findMusic(605)}
else if global.bossTrack=1 //Boss Fight: High Heels Girl
{
  viewFix=instance_create(320,176,oMisc)
  viewFix.type=0
  viewFix.sprite_index=sNull
  view_object[0]=viewFix
  tempMplay=findMusic(819)
  oPlayer1.x=256; oPlayer1.y=288
  var boss,enemyBarrier;
  boss=instance_create(384,288,oPT_HighHeelsGirl)
  boss.activateBoss=1
  enemyBarrier=instance_create(144,128,oEnemyBarrier); enemyBarrier.image_yscale=10
  enemyBarrier=instance_create(480,128,oEnemyBarrier); enemyBarrier.image_yscale=10
}

playMusic(tempMplay,0,0)
