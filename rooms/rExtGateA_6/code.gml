locationCheck(101)

var instrProg;
instrProg=string_char_at(global.eGateProg,1)
if instrProg!="8" and instrProg!="9"
{
  var tNewString;
  tNewString=string_delete(global.eGateProg,1,1)
  tNewString=string_insert("7",tNewString,1)
  global.eGateProg=tNewString
}

gameScene=instance_create(0,0,oEvExGates)

if global.bossTrack=1 //Boss Fight: Kamek
{
  var tempMplay,bBarrier,viewFix;
  tempMplay=findMusic(818)
  viewFix=instance_create(272,176,oMisc)
  viewFix.type=0
  viewFix.sprite_index=sNull
  view_object[0]=viewFix
  bBarrier=instance_create(112,192,oBossBarrier)
  bBarrier=instance_create(416,192,oBossBarrier)
  oPlayer1.x=176; oPlayer1.y=288
  storeStatus(1)
  boss=instance_create(368,288,oKamek)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(202)
}
playMusic(tempMplay,0,0)
