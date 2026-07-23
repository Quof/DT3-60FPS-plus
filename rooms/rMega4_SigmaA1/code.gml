locationCheck(29)
global.mapTeleport=9

gameScene=instance_create(0,0,oEvCh8MainB)

sigmaBack=instance_create(0,0,oCh8Back)
sigmaBack.type=0; sigmaBack.yStart=560; sigmaBack.backColor=make_color_rgb(24,0,48)

var tempMplay;
tempMplay=findMusic(410)
playMusic(tempMplay,0,0)
