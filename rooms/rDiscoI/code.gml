locationCheck(88)

if global.gameProgress=4660 {global.gameProgress=4670}
global.bSoundCanPlay=1

abilSetRemove(0)

gameScene=instance_create(0,0,oEvCh19MainA)

if global.bossTrack=1 //Boss Fight: Defective
{
  var tempMplay;
  tempMplay=findMusic(826)
  var enemyBarrier,boss;
  enemyBarrier=instance_create(576,0,oEnemyBarrier); enemyBarrier.image_yscale=16; enemyBarrier.image_blend=c_dkgray
  enemyBarrier=instance_create(1136,0,oEnemyBarrier); enemyBarrier.image_yscale=16; enemyBarrier.image_blend=c_dkgray
  oPlayer1.x=752; oPlayer1.y=256
  storeStatus(1)
  boss=instance_create(992,128,oDefective)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  if global.gameProgress=4680 or global.gameProgress=4690 {tempMplay=findMusic(0)}
  else {tempMplay=findMusic(28)}
  playMusic(tempMplay,0,0)
  SS_SetSoundFreq(global.msc_Discombobulated,6300)
}
playMusic(tempMplay,0,0)
