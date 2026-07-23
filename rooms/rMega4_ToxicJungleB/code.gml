locationCheck(29)
global.mapTeleport=9

gameScene=instance_create(0,0,oEvCh8MainA)

jungleBack=instance_create(0,0,oCh8Back)
jungleBack.type=1; jungleBack.yStart=64; jungleBack.yEnd=304
jungleBack.colorJungleTop=make_color_rgb(232,120,80); jungleBack.colorJungleBottom=make_color_rgb(240,168,40)

var tempMplay;
tempMplay=findMusic(409)
playMusic(tempMplay,0,0)
