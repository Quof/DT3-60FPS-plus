locationCheck(99)

if global.gameProgress=5160 {global.gameProgress=5170}

global.partySplit=0

gameScene=instance_create(0,0,oEvCh20MainA)
mapScene=instance_create(0,0,oEvCh20SideA)

var tempMplay;
tempMplay=findMusic(1015)
playMusic(tempMplay,0,0)
