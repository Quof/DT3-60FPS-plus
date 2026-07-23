locationCheck(90)

gameScene=instance_create(0,0,oEvDCS)
mapScene=instance_create(0,0,oEvCh19SideA)
//trapLines=instance_create(0,0,oDCSTHiddenLines)
//Ceiling point: y=256
mapTrapA=instance_create(0,-36,oCh19CeilingTrap); mapTrapA.type=1
mapTrapB=instance_create(0,160,oCh19CeilingTrap); mapTrapB.type=2; mapTrapB.myMaster=mapTrapA.id

var tempMplay;
tempMplay=findMusic(6)
playMusic(tempMplay,0,0)
