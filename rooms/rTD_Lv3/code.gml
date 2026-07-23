locationCheck(9)
global.partySplit=1
global.bossTrack=102
global.speedMod=1

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2
backFollow.backSet=backLabyrinthRuinsA
backFollow.xMoveScale=0.6; backFollow.yMoveScale=1
backFollow.depth=1499999
backFollow.image_xscale=1.8; backFollow.image_yscale=2

TD_HUD=instance_create(0,0,oTD_HUD)
TD_Prog=instance_create(0,0,oEvTowerDefense)
TD_Prog.TD_Difficulty=global.bTowerDefense

var tempMplay;
tempMplay=findMusic(1013)
playMusic(tempMplay,0,0)
