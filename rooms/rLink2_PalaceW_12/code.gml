locationCheck(10)
secondaryLocCheck(3,12)

gameScene=instance_create(0,0,oEvCh4MainA)

if global.bossTrack=1 //Boss Fight: Aqua Serpent
{
  var tempMplay;
  tempMplay=findMusic(803)
  viewFix=instance_create(432,176,oMisc)
  viewFix.type=0
  viewFix.sprite_index=sNull
  view_object[0]=viewFix
  var bossBarr;
  bossBarr=instance_create(176,112,oBossBarrier)
  bossBarr.image_yscale=2
  bossBarr=instance_create(672,176,oBossBarrier)
  oPlayer1.x=432; oPlayer1.y=272
  storeStatus(1)
  boss=instance_create(608,400,oAquaSerpent)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(201)
}
playMusic(tempMplay,0,0)
