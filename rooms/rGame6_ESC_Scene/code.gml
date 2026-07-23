locationCheck(58)
background_hspeed[0]=-1
background_vspeed[0]=0.5

oIdentifier.bCanScan=0; oIdentifier.deactivate=1

gameScene=instance_create(0,0,oEvCh15MainA)
mapScene=instance_create(0,0,oEvCh15SideA)

var tempMplay;
tempMplay=findMusic(0)
playMusic(tempMplay,0,0)
