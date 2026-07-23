locationCheck(29)
global.mapTeleport=9

gameScene=instance_create(0,0,oEvCh8MainA)

desertBack=instance_create(0,0,oCh8Back)
desertBack.type=0; desertBack.yStart=336; desertBack.backColor=make_color_rgb(184,160,88)

var tempMplay;
tempMplay=findMusic(408)
playMusic(tempMplay,0,0)
