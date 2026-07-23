locationCheck(106)
global.mapTeleport=6

var instrProg;
instrProg=string_char_at(global.eGateProg,6)
if instrProg!="8" and instrProg!="9"
{
  var tNewString;
  tNewString=string_delete(global.eGateProg,6,1)
  tNewString=string_insert("7",tNewString,6)
  global.eGateProg=tNewString
}

oPlayer1.initialJumpAcc=-9.4; oPlayer1.jumpTimeTotal=35
oPlayer1.runAcc=0.8; oPlayer1.frictionRunningX=0.9
global.hasShoes[2]=2; global.hasShoes[3]=2

gameScene=instance_create(0,0,oEvExGates)
gravControl=instance_create(0,0,oGateF_GravControl)
sceneParticles=instance_create(0,0,oGateF_IceParticles)

if global.bossTrack=1 //Boss Fight: Nightmare
{
  with oHealingPost {instance_destroy()}
  with (GID(344050)) {instance_destroy()}
  var tempMplay,bBarrier;
  tempMplay=findMusic(817)
  bBarrier=instance_create(48,368,oBossBarrier)
  bBarrier=instance_create(480,368,oBossBarrier)
  oPlayer1.x=160; oPlayer1.y=432
  storeStatus(1)
  boss=instance_create(320,336,oMetNightmare)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(501)
}
playMusic(tempMplay,0,0)
