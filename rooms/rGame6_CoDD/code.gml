locationCheck(58)
if global.gameProgress>=3870 {global.mapTeleport=23}
background_hspeed[0]=-1
background_vspeed[0]=0.5

gameScene=instance_create(0,0,oEvCh15MainA)
mapScene=instance_create(0,0,oEvCh15SideA)

var tempMplay;
tempMplay=findMusic(604)
playMusic(tempMplay,0,0)
