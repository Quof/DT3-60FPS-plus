locationCheck(10)
global.zEncZone=4

gameScene=instance_create(0,0,oEvCh4MainA)
blackTop=instance_create(0,0,oG2_BlackTop)

if global.bossTrack=1 //Boss Fight: Barba
{
  var tempMplay;
  tempMplay=findMusic(802)
  viewFix=instance_create(416,176,oMisc)
  viewFix.type=0
  viewFix.sprite_index=sNull
  view_object[0]=viewFix
  var bossBarr;
  bossBarr=instance_create(240,192,oBossBarrier)
  bossBarr.image_yscale=1.5
  bossBarr=instance_create(576,240,oBossBarrier)
  oPlayer1.x=448; oPlayer1.y=288
  storeStatus(1)
  boss=instance_create(392,room_height,oBarba)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(202)
}
playMusic(tempMplay,0,0)
