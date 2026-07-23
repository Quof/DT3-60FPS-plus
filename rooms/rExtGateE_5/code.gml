locationCheck(105)
global.mapTeleport=5

var instrProg;
instrProg=string_char_at(global.eGateProg,5)
if instrProg!="8" and instrProg!="9"
{
  var tNewString;
  tNewString=string_delete(global.eGateProg,5,1)
  tNewString=string_insert("7",tNewString,5)
  global.eGateProg=tNewString
}

gameScene=instance_create(0,0,oEvExGates)
instance_create(0,0,oVaultVisualControl)
background_alpha[0]=0.9

if global.bossTrack=1 //Boss Fight: Shadow Form
{
  var tempMplay,bBarrier,viewFix;
  tempMplay=findMusic(808)
  viewFix=instance_create(328,176,oMisc)
  viewFix.type=0; viewFix.sprite_index=sNull
  view_object[0]=viewFix
  bBarrier=instance_create(144,240,oBossBarrier)
  bBarrier=instance_create(496,208,oBossBarrier); bBarrier.image_yscale=1.5
  oPlayer1.x=272; oPlayer1.y=304
  storeStatus(1)
  boss=instance_create(384,304,oShadowForm)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(11)
}
playMusic(tempMplay,0,0)
