locationCheck(57)

gameScene=instance_create(0,0,oEvCh14MainA)
mapScene=instance_create(0,0,oEvCh14SideA)

var tempMplay;
tempMplay=findMusic(16)
playMusic(tempMplay,0,0)

if global.gameProgress<=3190 {stopAllMusic()}
