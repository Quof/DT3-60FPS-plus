locationCheck(24)

global.partySplit=0
gameScene=instance_create(0,0,oEvCh7MainA)

backGrad=instance_create(0,0,oCh7GradientBack)
backGrad.type=1
backGrad.colorTop=make_color_rgb(252,144,36)
backGrad.yStart=370

var tempMplay;
tempMplay=findMusic(7)
playMusic(tempMplay,0,0)
