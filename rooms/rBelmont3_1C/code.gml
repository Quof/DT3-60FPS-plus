locationCheck(15)

gameScene=instance_create(0,0,oEvCh6MainA)
blackTop=instance_create(0,0,oG2_BlackTop)

if global.bossTrack=1 //Boss Fight: Large Vampire Bat
{
  with oEnemyBase {instance_destroy()}
  var tempMplay,bBarrier;
  tempMplay=findMusic(824)
  viewFix=instance_create(1808,176,oMisc)
  viewFix.type=0
  viewFix.sprite_index=sNull
  view_object[0]=viewFix
  bBarrier=instance_create(1552,0,oBossBarrier)
  bBarrier.image_yscale=5.5
  bBarrier=instance_create(1984,176,oBossBarrier)
  oPlayer1.x=1808; oPlayer1.y=304
  storeStatus(1)
  boss=instance_create(1876,144,oLargeVampireBat)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(301)
}
playMusic(tempMplay,0,0)
