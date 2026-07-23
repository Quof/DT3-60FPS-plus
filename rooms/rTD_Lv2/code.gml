locationCheck(9)
global.partySplit=1
global.bossTrack=102
global.speedMod=1

backGrad=instance_create(0,0,oCh7GradientBack)
backGrad.type=1
backGrad.colorTop=make_color_rgb(118,225,0)
backGrad.yStart=480

gameScene=instance_create(0,0,oEvCh16MainA)
TD_HUD=instance_create(0,0,oTD_HUD)
TD_Prog=instance_create(0,0,oEvTowerDefense)
TD_Prog.TD_Difficulty=global.bTowerDefense

var tempMplay;
tempMplay=findMusic(1013)
playMusic(tempMplay,0,0)
