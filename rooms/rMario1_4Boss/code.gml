if global.gameProgress=220 {global.gameProgress=230}

gameScene=instance_create(0,0,oEvCh2MainA)
sideChat=instance_create(0,0,oEvCh2SideA)

if global.bossTrack=1 //Boss Fight: Bowser
{
  var tempMplay,viewFix;
  tempMplay=findMusic(801)
  viewFix=instance_create(720,176,oMisc)
  viewFix.type=0
  viewFix.sprite_index=sNull
  view_object[0]=viewFix
  instance_create(560,192,oBossBarrier)
  instance_create(864,192,oBossBarrier)
  oPlayer1.x=720; oPlayer1.y=272
  boss=instance_create(816,272,oBowser)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(102)
}
playMusic(tempMplay,0,0)
SS_SetSoundFreq(global.msc_BowserFight,22050)
