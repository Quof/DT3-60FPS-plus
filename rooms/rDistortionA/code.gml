locationCheck(110)
oIdentifier.bCanScan=0; oIdentifier.deactivate=1

backFollow=instance_create(0,0,oBackDistortion)
backFollow.type=0; backFollow.depth=1499999

gameScene=instance_create(0,0,oEvCh21MainA)
sideChat=instance_create(0,0,oEvCh21SideA)

var tempMplay;
tempMplay=findMusic(1026)
playMusic(tempMplay,0,0)
