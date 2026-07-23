locationCheck(9)
global.partySplit=1
global.bossTrack=102
global.speedMod=1

TD_HUD=instance_create(0,0,oTD_HUD)
TD_Prog=instance_create(0,0,oEvTowerDefense)
TD_Prog.TD_Difficulty=global.bTowerDefense

var tempMplay;
tempMplay=findMusic(1013)
playMusic(tempMplay,0,0)
