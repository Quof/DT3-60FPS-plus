locationCheck(34)
global.mapTeleport=0
global.rbSwitchBlueOn=false
//SS_SetSoundFreq(global.msc_MarioWorld,22050)
scrMusicFreq(global.msc_MarioWorld,22050) //remastered music change: scaled to the file's own sample rate (scrMusicFreq)

global.currentBoss=""; global.bossTrack=0
global.partySplit=0
abilSetRemove(0)

if global.BTB_ZephSecret=0 //If player finds the secret morph ball room in NZZ's third room
{
  tile_layer_hide(1000010)
}

//if global.bossGalleryTime[64]=99999 //If player beats WEX
if global.bossGalleryTime[64]=99999 and global.bossGalleryHitsN[64]=99999 //If player beats WEX //normalized gallery change: a win with the gallery lever on counts too
{
  tile_layer_hide(1000020)
}

var tempMplay;
tempMplay=findMusic(10)
playMusic(tempMplay,0,0)
