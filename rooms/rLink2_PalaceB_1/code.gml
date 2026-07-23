locationCheck(10)
global.zEncZone=2

if global.gameProgress<=710 {global.gameProgress=720}

gameScene=instance_create(0,0,oEvCh4MainA)
//sideChat=instance_create(0,0,oEvCh4SideA)
blackTop=instance_create(0,0,oG2_BlackTop)

var tempMplay;
tempMplay=findMusic(204)
playMusic(tempMplay,0,0)
