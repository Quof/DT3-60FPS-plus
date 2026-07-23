locationCheck(85)

gameScene=instance_create(0,0,oEvCh19MainA)
mapScene=instance_create(0,0,oEvCh19SideA)
levelStuff=instance_create(0,0,oEvTS_Events)

var tempMplay;
if global.gameProgress>=4560 {tempMplay=findMusic(26)}
else {tempMplay=findMusic(0)}
playMusic(tempMplay,0,0)
