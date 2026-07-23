locationCheck(59)

if global.gameProgress>=4130 and global.gameProgress<=4180 {global.gameProgress=4190}

gameScene=instance_create(0,0,oEvCh17MainA)
mapScene=instance_create(0,0,oEvCh17SideA)

var tempMplay;
tempMplay=findMusic(19)
playMusic(tempMplay,0,0)
