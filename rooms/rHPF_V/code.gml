locationCheck(59)

gameScene=instance_create(0,0,oEvCh17MainA)
mapScene=instance_create(0,0,oEvCh17SideA)

if global.gameProgress=4110
{
  var tempMplay;
  tempMplay=findMusic(1001)
  enemyBarrier=instance_create(48,224,oEnemyBarrier); enemyBarrier.image_yscale=4
  enemyBarrier=instance_create(368,96,oEnemyBarrier); enemyBarrier.image_yscale=12
  oPlayer1.x=224; oPlayer1.y=288
}
else
{
  var tempMplay;
  tempMplay=findMusic(19)
}

playMusic(tempMplay,0,0)
