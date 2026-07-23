locationCheck(76)
global.bCanSave=0
if global.altEndingProg=0 {gameScene=instance_create(0,0,oEvCh21MainA)}
else {gameScene=instance_create(0,0,oEvAltAbomEnding)}

var tempMplay;
tempMplay=findMusic(202)
playMusic(tempMplay,0,0)
SS_SetSoundFreq(global.msc_OminousHall,11025)
