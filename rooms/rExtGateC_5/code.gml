locationCheck(103)
global.hasShoes[2]=2

var instrProg;
instrProg=string_char_at(global.eGateProg,3)
if instrProg!="8" and instrProg!="9"
{
  var tNewString;
  tNewString=string_delete(global.eGateProg,3,1)
  tNewString=string_insert("7",tNewString,3)
  global.eGateProg=tNewString
}

gameScene=instance_create(0,0,oEvExGates)

if global.bossTrack=1 //Boss Fight: Blackmoor
{
  var tempMplay,bBarrier,viewFix;
  tempMplay=findMusic(806)
  viewFix=instance_create(544,176,oMisc)
  viewFix.type=0
  viewFix.sprite_index=sNull
  view_object[0]=viewFix
  bBarrier=instance_create(336,240,oBossBarrier)
  bBarrier=instance_create(736,240,oBossBarrier)
  oPlayer1.x=400; oPlayer1.y=304
  storeStatus(1)
  boss=instance_create(576,256,oBlackmoorMain)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(202)
}
playMusic(tempMplay,0,0)
