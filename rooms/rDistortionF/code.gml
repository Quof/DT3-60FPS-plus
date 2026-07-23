locationCheck(110)
oIdentifier.bCanScan=0; oIdentifier.deactivate=1
global.finalBossHP=1000

backFollow=instance_create(0,0,oBackDistortion)
backFollow.type=0; backFollow.depth=1499999

gameScene=instance_create(0,0,oEvCh21MainA)
sideChat=instance_create(0,0,oEvCh21SideA)

var tempMplay;
if global.bossTrack=0
{
  instance_create(320,224,oHexor_Main)
  tempMplay=findMusic(1026)
}
else if global.bossTrack=1 //Final Boss Fight: Hexor
{
  with oExit {instance_destroy()}
  oPlayer1.x=160; oPlayer1.y=288
  tempMplay=findMusic(833)
  with oMisc {instance_destroy()}
  instance_create(320,224,oHexor_Main)
  oHexor_Main.activateBoss=1
  storeStatus(1)
}
else if global.bossTrack=1000 //Jeremy vs Hexor
{
  global.activeCharacter=4
  with oExit {instance_destroy()}
  oPlayer1.x=160; oPlayer1.y=288
  tempMplay=findMusic(1025)
  with oMisc {instance_destroy()}
  with oHexor_Main {instance_destroy()}
  instance_create(320,224,oHexor_Final)
  storeStatus(1)
}
playMusic(tempMplay,0,0)
