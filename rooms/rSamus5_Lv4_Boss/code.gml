locationCheck(49)

gameScene=instance_create(0,0,oEvCh13MainA)

if global.gameProgress>=2970 and global.bBossGallery=0 //Turrets and Ring Gens stay destroyed after Mother Brain fight
{
  with oMB_RinkaGen {instance_destroy()}
  with oMB_Turret {instance_destroy()}
}

if global.gameProgress<=2960 and global.bossTrack=0
{
  boss=instance_create(79,172,oMotherBrain)
}
if global.bossTrack=1 //Boss Fight: Mother Brain
{
  viewFix=instance_create(240,176,oMisc)
  viewFix.type=0
  viewFix.sprite_index=sNull
  view_object[0]=viewFix
  var tempMplay,enemyBarrier;
  tempMplay=findMusic(505)
  enemyBarrier=instance_create(48,160,oEnemyBarrier); enemyBarrier.image_yscale=4
  enemyBarrier=instance_create(384,80,oEnemyBarrier); enemyBarrier.image_yscale=4
  storeStatus(1)
  oPlayer1.x=248; oPlayer1.y=240
  boss=instance_create(79,172,oMotherBrain)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(505)
}
playMusic(tempMplay,0,0)
