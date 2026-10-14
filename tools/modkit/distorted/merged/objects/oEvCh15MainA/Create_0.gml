event_inherited()
enemyCount=-1
fadeColor=c_white
fadeAlpha=0

bombDelay=0 //spsp ns
bombTime=150

if global.gameProgress=3390 and room=rGame6_WhisperWoodsA
{
  fadeAlpha=1
}
else if room=rGame6_HeroPlainsF
{
  indexCheck=string_char_at(global.kiEnergy,3)
  if indexCheck="1" {sceneProgress=10}
}
else if room=rGame6_EarthH or room=rGame6_EarthI
{
  spikeInit=0
}
else if global.gameProgress=3520 and room=rGame6_Hometown
{
  fadeColor=c_black
  fadeAlpha=1
}
else if global.gameProgress=3480 and room=rGame6_JDream
{
  fadeColor=c_black
  fadeAlpha=1
}
else if room=rGame6_FireD
{
  wallCheck=0
}
else if global.gameProgress=3540 and room=rGame6_ESC_Scene
{
  fadeColor=c_black
  fadeAlpha=1
  oPlayer1.visible=0
}
else if global.gameProgress=3540 and room=rGame6_Gate
{
  fadeColor=c_black
  fadeAlpha=1
  charClaire=instance_create(128,288,oMisc)
  charClaire.sprite_index=sClaireIdle; charClaire.image_xscale=-1
  charClaire.image_speed=0.1; charClaire.type=1
}
else if room=rGame6_WindH
{
  bWallSpawn=0
}
else if room=rGame6_WindI
{
  if global.gameProgress=3620
  {
    //musicFade=global.optMusic*100
    musicFade=scrMusicVolume(getReplayGain(605)) //remastered music change: the counter starts at the volume DT_RPGElementsA (605) plays at (scrMusicVolume), not the old formula's, so the fade ends where it was meant to
  }
}
else if room=rGame6_DreamWoodsA
{
  if global.gameProgress=3640
  {
    fadeAlpha=1
  }
}
else if room=rGame6_CoDE
{
  bEnemyCheck=0
}
else if room=rGame6_CoDP
{
  if global.gameProgress<=3820 and global.bossTrack=0
  {
    npcBishonen=instance_create(1152,352,oMisc)
    npcBishonen.sprite_index=sWHB_Idle; npcBishonen.image_xscale=-1
    npcBishonen.image_speed=0; npcBishonen.type=1
  }
}
else if room=rGame6_CoDR
{
  bGridCheck=0
}
else if room=rGame6_CoDS
{
  var tTrap,tDir;
  tDir=0
  for(i=0;i<24;i+=1)
  {
    tTrap=instance_create(800,160,oMovingTrap)
    tTrap.shiftTime=0; tTrap.shiftMax=60; tTrap.moveSpd=3; tTrap.bShowLine=1
    tTrap._direction=tDir
    tDir+=360/24
  }
}
else if room=rGame6_CoDU
{
  lightningTime=0
  circleRad=0
  if global.gameProgress<=3860
  {
    fadeColor=c_black
    fadeAlpha=1
    //musicFade=global.optMusic*100
    musicFade=scrMusicVolume(getReplayGain(604)) //remastered music change: the counter starts at the volume DT_RPGDoomCastle (604) plays at (scrMusicVolume), not the old formula's, so the fade ends where it was meant to
    oHUD.visible=0
  }
}
