locationCheck(34)
global.mapTeleport=0
global.rbSwitchBlueOn=false
SS_SetSoundFreq(global.msc_MarioWorld,22050)

global.currentBoss=""; global.bossTrack=0
global.partySplit=0
abilSetRemove(0)

if global.BTB_ZephSecret=0 //If player finds the secret morph ball room in NZZ's third room
{
  tile_layer_hide(1000010)
}

if global.bossGalleryTime[64]=99999 //If player beats WEX
{
  tile_layer_hide(1000020)
}

var tempMplay;
tempMplay=findMusic(10)
playMusic(tempMplay,0,0)
