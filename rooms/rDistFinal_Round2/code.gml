locationCheck(110)
oIdentifier.bCanScan=0; oIdentifier.deactivate=1
global.activeCharacter=4

oPlayer1.x=128; oPlayer1.y=288

backFollow=instance_create(0,0,oBackDistortion)
backFollow.type=0; backFollow.depth=1499999

gameScene=instance_create(0,0,oEvCh21MainA)
sideChat=instance_create(0,0,oEvCh21SideA)

var tempMplay;
tempMplay=findMusic(1025)
playMusic(tempMplay,0,0)
