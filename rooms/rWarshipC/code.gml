locationCheck(99)
if global.gameProgress=5090 {global.gameProgress=5100}

global.partySplit=1

gameScene=instance_create(0,0,oEvCh20MainA)
mapScene=instance_create(0,0,oEvCh20SideA)
cloudBack=instance_create(0,0,oWarshipCloudBack)
windEffect=instance_create(0,0,oWarshipWindPGen)

var tempMplay;
tempMplay=findMusic(1015)
playMusic(tempMplay,0,0)
