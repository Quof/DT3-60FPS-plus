locationCheck(88)

if global.gameProgress=4640 {global.gameProgress=4650}

gameScene=instance_create(0,0,oEvCh19MainA)

//SS_SetSoundFreq(global.msc_Discombobulated,22050)
scrMusicFreq(global.msc_Discombobulated,22050) //remastered music change: scaled to the file's own sample rate (scrMusicFreq)

var tempMplay;
tempMplay=findMusic(28)
playMusic(tempMplay,0,0)
