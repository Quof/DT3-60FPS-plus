locationCheck(76)
global.bCanSave=1
global.bCanUseEsc=1

abilSetRemove(0)
if global.activeCharacter=3 {charSwitcher(1)}

if global.gameProgress=5540 {global.gameProgress=5550}

gameScene=instance_create(0,0,oEvCh21MainA)

var tempMplay;
tempMplay=findMusic(202)
playMusic(tempMplay,0,0)
SS_SetSoundFreq(global.msc_OminousHall,11025)
