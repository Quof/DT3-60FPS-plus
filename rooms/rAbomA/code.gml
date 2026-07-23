locationCheck(76)
global.bCanSave=0
if global.altEndingProg=0 {gameScene=instance_create(0,0,oEvCh21MainA)}
else {gameScene=instance_create(0,0,oEvAltAbomEnding)}

global.bBossGallery=0
global.bossTrack=0
global.currentBoss=""

var tempMplay;
tempMplay=findMusic(202)
playMusic(tempMplay,0,0)
SS_SetSoundFreq(global.msc_OminousHall,11025)
