locationCheck(102)

var instrProg;
instrProg=string_char_at(global.eGateProg,2)
if instrProg!="8" and instrProg!="9"
{
  var tNewString;
  tNewString=string_delete(global.eGateProg,2,1)
  tNewString=string_insert("7",tNewString,2)
  global.eGateProg=tNewString
}

gameScene=instance_create(0,0,oEvExGates)

if global.bossTrack=1 //Boss Fight: Final Nightmare
{
  var tempMplay,bBarrier,viewFix;
  tempMplay=findMusic(808)
  viewFix=instance_create(560,176,oMisc)
  viewFix.type=0
  viewFix.sprite_index=sNull
  view_object[0]=viewFix
  bBarrier=instance_create(368,224,oBossBarrier)
  bBarrier=instance_create(736,224,oBossBarrier)
  oPlayer1.x=560; oPlayer1.y=288
  storeStatus(1)
  boss=instance_create(560,160,oFinalNightmare)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(202)
}
playMusic(tempMplay,0,0)
