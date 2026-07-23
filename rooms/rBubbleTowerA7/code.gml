locationCheck(34)
if global.gameProgress>=2090 {global.mapTeleport=28}
global.rbSwitchBlueOn=false

global.partySplit=1
gameScene=instance_create(0,0,oEvCh9MainA)

if global.gameProgress<=2080 or global.bBossGallery=1
{
  with oExit {instance_destroy()}
  boss=instance_create(240,192,oArmyEye)
}

var tempMplay;
if global.bossTrack=0 {tempMplay=findMusic(10)}

if global.bossTrack=1 //Boss Fight: Army Eye
{
  npcBubblin=instance_create(416,96,oMisc)
  npcBubblin.sprite_index=sBubblun_Idle; npcBubblin.image_xscale=-1; npcBubblin.image_speed=0.05; npcBubblin.type=1
  tempMplay=findMusic(813)
  oPlayer1.x=272; oPlayer1.y=320
  storeStatus(1)
  boss.activateBoss=1
}
else
{
  var newExit;
  newExit=instance_create(240,224,oExit)
  newExit.sprite_index=sWarpGateStand
  newExit.bShowArrow=false; newExit.exitType=0
  newExit.newMapX=176; newExit.newMapY=304; newExit.toRoom=rBubbleTowerMain
  tempMplay=findMusic(10)
}
playMusic(tempMplay,0,0)
