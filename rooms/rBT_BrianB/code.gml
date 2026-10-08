locationCheck(34)
global.mapTeleport=0

//SS_SetSoundFreq(global.msc_MarioWorld,22050)
scrMusicFreq(global.msc_MarioWorld,22050) //remastered music change: scaled to the file's own sample rate (scrMusicFreq)
instance_create(0,0,oBTB_Brian)

var tempMplay;
tempMplay=findMusic(101)
playMusic(tempMplay,0,0)
