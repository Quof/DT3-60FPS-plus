locationCheck(58)
if global.gameProgress>=3870 {global.mapTeleport=23}
background_hspeed[0]=-1
background_vspeed[0]=0.5

if global.gameProgress=3850 {global.gameProgress=3851}

gameScene=instance_create(0,0,oEvCh15MainA)
mapScene=instance_create(0,0,oEvCh15SideA)
backGrid=instance_create(0,0,oG6_CastleBGrid)

var tempMplay;
tempMplay=findMusic(604)
playMusic(tempMplay,0,0)
