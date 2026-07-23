locationCheck(58)
global.mapTeleport=17

gameScene=instance_create(0,0,oEvCh15MainA)

var tempMplay;
if global.bossTrack=0 {tempMplay=findMusic(605)}
else if global.bossTrack=1 //Boss Fight: Stone Golem
{
  tempMplay=findMusic(813)
  oPlayer1.x=352; oPlayer1.y=288
  var boss,enemyBarrier;
  boss=instance_create(512,288,oPT_StoneGolem)
  boss.activateBoss=1
  enemyBarrier=instance_create(176,224,oEnemyBarrier); enemyBarrier.image_yscale=4
  enemyBarrier=instance_create(640,224,oEnemyBarrier); enemyBarrier.image_yscale=4
}

playMusic(tempMplay,0,0)
