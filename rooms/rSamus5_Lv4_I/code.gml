locationCheck(49)

if global.gameProgress=2940 {global.gameProgress=2950}

gameScene=instance_create(0,0,oEvCh13MainA)
metroidControl=instance_create(0,0,oEvCh13MetroidControl)

var tempMplay;
tempMplay=findMusic(505)
playMusic(tempMplay,0,0)
