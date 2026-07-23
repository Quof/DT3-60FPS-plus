locationCheck(10)

if global.gameProgress=810 {global.gameProgress=815}

gameScene=instance_create(0,0,oEvCh4MainA)
//sideChat=instance_create(0,0,oEvCh4SideA)
blackTop=instance_create(0,0,oG2_BlackTop)

var tempMplay;
tempMplay=findMusic(205)
playMusic(tempMplay,0,0)
