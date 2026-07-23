locationCheck(90)

gameScene=instance_create(0,0,oEvDCS)
mapScene=instance_create(0,0,oEvCh19SideA)

mapTrapA=instance_create(0,-36,oCh19CeilingTrap); mapTrapA.type=1

var tempMplay;
tempMplay=findMusic(6)
playMusic(tempMplay,0,0)
