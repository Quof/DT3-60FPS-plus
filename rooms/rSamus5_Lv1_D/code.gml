locationCheck(49)

gameScene=instance_create(0,0,oEvCh13MainA)

if global.gameProgress>=2700 or global.bossTrack=101
{
  if global.gameProgress>=2700 {with oRidDoorBeacon {instance_destroy()}}
  with (GID(267739)) {instance_destroy()}
  tile_layer_hide(8)
}

if global.bossTrack=101 or global.gameProgress=2700 //Encounter: Ridley and Door Beacons
{
  var tempMplay;
  tempMplay=findMusic(816)
  boss=instance_create(480,128,oRidleyFirst)
  boss.activateBoss=1
  with oRidDoorBeacon {bActive=1}
  oPlayer1.x=336; oPlayer1.y=256
  storeStatus(1)
}
else
{
  var tempMplay;
  tempMplay=findMusic(502)
}
playMusic(tempMplay,0,0)
