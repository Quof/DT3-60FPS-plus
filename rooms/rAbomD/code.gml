locationCheck(76)
global.bCanSave=0

if global.altEndingProg=0 {gameScene=instance_create(0,0,oEvCh21MainA)}
else
{
  with oAbom_ParaBlock {instance_destroy()}
  gameScene=instance_create(0,0,oEvAltAbomEnding)
}

tile_layer_hide(999999)
tile_layer_hide(999998)

var tempMplay;
if global.bossTrack=0
{
  tempMplay=findMusic(202)
  playMusic(tempMplay,0,0)
  SS_SetSoundFreq(global.msc_OminousHall,11025)
}
else if global.bossTrack=1 //Boss Fight: The Executive
{
  var enemyBarrier,viewFix,boss;
  enemyBarrier=instance_create(656,96,oEnemyBarrier); enemyBarrier.image_yscale=10; enemyBarrier.visible=0
  enemyBarrier=instance_create(1056,96,oEnemyBarrier); enemyBarrier.image_yscale=10; enemyBarrier.visible=0
  for(i=0;i<4;i+=1)
  {
    instance_create(664,144+(i*32),oExe_SideFire)
    instance_create(1064,144+(i*32),oExe_SideFire)
  }
  view_xview[0]=864
  viewFix=instance_create(864,176,oMisc)
  viewFix.type=0; viewFix.sprite_index=sNull; view_object[0]=viewFix
  oPlayer1.x=800; oPlayer1.y=312
  tempMplay=findMusic(834)
  boss=instance_create(976,208,oTheExecutive)
  boss.activateBoss=1
  storeStatus(1)
}
playMusic(tempMplay,0,0)
