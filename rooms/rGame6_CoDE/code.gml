locationCheck(58)
if global.gameProgress>=3870 {global.mapTeleport=23}

gameScene=instance_create(0,0,oEvCh15MainA)
mapScene=instance_create(0,0,oEvCh15SideA)
backDraw=instance_create(0,0,oG6_CastleBack)
backDraw.yStartDraw=288

var tempMplay;
tempMplay=findMusic(604)
playMusic(tempMplay,0,0)
