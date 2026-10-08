locationCheck(88)
global.desertHeat=1500

gameScene=instance_create(0,0,oEvCh19MainA)
mapScene=instance_create(0,0,oEvCh19SideA)

var tempMplay;
tempMplay=findMusic(28)
playMusic(tempMplay,0,0)

//SS_SetSoundFreq(global.msc_Discombobulated,22050)
scrMusicFreq(global.msc_Discombobulated,22050) //remastered music change: scaled to the file's own sample rate (scrMusicFreq)
