locationCheck(10)
global.zEncZone=1

gameScene=instance_create(0,0,oEvCh4MainA)
//sideChat=instance_create(0,0,oEvCh4SideA)
blackTop=instance_create(0,0,oG2_BlackTop)

if global.bossTrack=1 //Boss Fight: Helmethead
{
  var tempMplay;
  tempMplay=findMusic(802)
  viewFix=instance_create(448,176,oMisc)
  viewFix.type=0
  viewFix.sprite_index=sNull
  view_object[0]=viewFix
  instance_create(240,240,oBossBarrier)
  instance_create(640,240,oBossBarrier)
  oPlayer1.x=448; oPlayer1.y=304
  storeStatus(1)
  boss=instance_create(576,304,oHelmetHead)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(204)
}
playMusic(tempMplay,0,0)
