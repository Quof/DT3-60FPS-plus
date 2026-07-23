locationCheck(58)
if global.gameProgress>=3870 {global.mapTeleport=23}

gameScene=instance_create(0,0,oEvCh15MainA)
mapScene=instance_create(0,0,oEvCh15SideA)
backDraw=instance_create(0,0,oG6_CastleBack)
backDraw.yStartDraw=416

var tempMplay;
if global.bossTrack=0 {tempMplay=findMusic(604)}
else if global.bossTrack=1 //Boss Fight: The Chosen One
{
  oEvCh15MainA.fadeColor=c_black
  oEvCh15MainA.fadeAlpha=0.3
  tempMplay=findMusic(819)
  oPlayer1.x=1056; oPlayer1.y=352
  var boss,enemyBarrier;
  boss=instance_create(992,224,oPT_TOTO)
  boss.activateBoss=1
  enemyBarrier=instance_create(448,-48,oEnemyBarrier); enemyBarrier.image_yscale=38
  enemyBarrier=instance_create(1648,-48,oEnemyBarrier); enemyBarrier.image_yscale=38
}

playMusic(tempMplay,0,0)
