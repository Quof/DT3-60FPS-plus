locationCheck(28)

if global.gameProgress=1720 {with oEnemyBase {instance_destroy()}}
gameScene=instance_create(0,0,oEvCh7MainA)

for(i=0;i<10;i+=1)
{
  backGStatic=instance_create(255+(i*256),117,oBackgroundStatic)
  backGStatic.backSet=backBegoniaF
  backGStatic.image_angle=180
}

for(i=0;i<10;i+=1)
{
  backGStatic=instance_create(255+(i*256),520,oBackgroundStatic)
  backGStatic.backSet=backBegoniaF
  backGStatic.image_angle=180
}

if global.bossTrack=101 //Encounter: Virus & Twin Wasps
{
  var tempMplay;
  tempMplay=findMusic(809)
  var newEnemy,newBarrier;
  newEnemy=instance_create(432,192,oWaspBot) newEnemy.bActive=1; newEnemy.yDist=128
  newEnemy=instance_create(2288,656,oWaspBot) newEnemy.bActive=1; newEnemy.yDist=-128
  instance_create(2288,656,oMalevolentVirus)
  newBarrier=instance_create(2432,704,oBossBarrier)
  with (GID(213291)) {instance_destroy()}
  oPlayer1.x=1408
  oPlayer1.y=288
  storeStatus(1)
}
else
{
  var tempMplay;
  tempMplay=findMusic(7)
}
playMusic(tempMplay,0,0)
