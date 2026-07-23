locationCheck(104)
global.mapTeleport=4

var instrProg;
instrProg=string_char_at(global.eGateProg,4)
if instrProg!="8" and instrProg!="9"
{
  var tNewString;
  tNewString=string_delete(global.eGateProg,4,1)
  tNewString=string_insert("7",tNewString,4)
  global.eGateProg=tNewString
}

gameScene=instance_create(0,0,oEvExGates)

if global.bossTrack=1 //Boss Fight: Elpizo
{
  var tempMplay,bBarrier;
  tempMplay=findMusic(812)
  bBarrier=instance_create(112,320,oBossBarrier)
  bBarrier=instance_create(768,96,oBossBarrier)
  oPlayer1.x=352; oPlayer1.y=416
  storeStatus(1)
  boss=instance_create(448,416,oElpizo)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(904)
}
playMusic(tempMplay,0,0)
