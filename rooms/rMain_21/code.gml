locationCheck(21)

gameScene=instance_create(0,0,oEvCh7MainA)

backGrad=instance_create(0,0,oCh7GradientBack)
backGrad.type=1
backGrad.colorTop=make_color_rgb(118,225,0)
backGrad.yStart=322

if global.bossTrack=101 //Encounter: Blood Tyrant
{
  var tempMplay;
  tempMplay=findMusic(809)

  instance_create(0,0,oScreenColorOverlay)
  oScreenColorOverlay.image_blend=c_red
  oScreenColorOverlay.image_alpha=0.2
  var enemyBarrier;
  enemyBarrier=instance_create(1136,0,oEnemyBarrier); enemyBarrier.image_yscale=16
  enemyBarrier=instance_create(1536,0,oEnemyBarrier); enemyBarrier.image_yscale=16
  var enemyCounter;
  enemyCounter=instance_create(0,0,oEnemyRemain)
  enemyCounter.enemyCount=1
  createEnemy(1232,288,oBloodTyrant,2,0,1)
  oPlayer1.x=1456; oPlayer1.y=288
  storeStatus(1)
}
else
{
  var tempMplay;
  tempMplay=findMusic(7)
}
playMusic(tempMplay,0,0)
