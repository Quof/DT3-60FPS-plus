locationCheck(10)
global.zEncZone=4

gameScene=instance_create(0,0,oEvCh4MainA)
//sideChat=instance_create(0,0,oEvCh4SideA)
blackTop=instance_create(0,0,oG2_BlackTop)

if global.bossTrack=1 //Boss Fight: Thunderbird
{
  var tempMplay;
  tempMplay=findMusic(802)
  viewFix=instance_create(544,176,oMisc)
  viewFix.type=0
  viewFix.sprite_index=sNull
  view_object[0]=viewFix
  var bossBarr;
  bossBarr=instance_create(288,0,oBossBarrier)
  bossBarr.image_yscale=5.5
  bossBarr=instance_create(784,0,oBossBarrier)
  bossBarr.image_yscale=5.5
  oPlayer1.x=544; oPlayer1.y=256
  storeStatus(1)
  boss=instance_create(832,192,oThunderbird)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(205)
}
playMusic(tempMplay,0,0)
