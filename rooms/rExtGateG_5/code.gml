locationCheck(107)
global.mapTeleport=7
global.partySplit=0

var instrProg;
instrProg=string_char_at(global.eGateProg,7)
if instrProg!="8" and instrProg!="9"
{
  var tNewString;
  tNewString=string_delete(global.eGateProg,7,1)
  tNewString=string_insert("7",tNewString,7)
  global.eGateProg=tNewString
}

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2
backFollow.backSet=backG6ForgottenIsles
backFollow.xMoveScale=0.6; backFollow.yMoveScale=1
backFollow.depth=1499999
backFollow.image_xscale=2; backFollow.image_yscale=2
backDraw=instance_create(0,0,oG6_CastleBack)
backDraw.yStartDraw=207

gameScene=instance_create(0,0,oEvExGates)

//global.bossTrack=1
if global.bossTrack=1 //Boss Fight: Sephiroth
{
  var tempMplay,bBarrier,viewFix;
  viewFix=instance_create(384,176,oMisc)
  viewFix.type=0
  viewFix.sprite_index=sNull
  view_object[0]=viewFix
  tempMplay=findMusic(820)
  bBarrier=instance_create(160,-32,oBossBarrier); bBarrier.image_yscale=18
  bBarrier=instance_create(592,-32,oBossBarrier); bBarrier.image_yscale=18
  oPlayer1.x=320; oPlayer1.y=288
  storeStatus(1)
  boss=instance_create(480,288,oSephiroth)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(905)
}
playMusic(tempMplay,0,0)
