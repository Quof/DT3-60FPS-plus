locationCheck(29)
global.mapTeleport=9

gameScene=instance_create(0,0,oEvCh8MainA)

bgFollow=instance_create(0,0,oBackgroundFollow)
bgFollow.type=2; bgFollow.backSet=backMM_ToxicJungleA
bgFollow.xMoveScale=0.6; bgFollow.yMoveScale=1
bgFollow.image_xscale=1.875; bgFollow.image_yscale=1.6
bgFollow.image_blend=make_color_rgb(136,72,40); bgFollow.depth=1499999

var tempMplay;
tempMplay=findMusic(409)
playMusic(tempMplay,0,0)
