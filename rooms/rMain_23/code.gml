locationCheck(23)
global.mapTeleport=0

gameScene=instance_create(0,0,oEvCh7MainA)
if global.gameProgress=1700 {boulderCon=instance_create(0,0,oEvCh7BoulderControl)}

backGrad=instance_create(0,0,oCh7GradientBack)
backGrad.type=1
backGrad.colorTop=make_color_rgb(252,144,36)
backGrad.yStart=470

var tempMplay;
tempMplay=findMusic(7)
playMusic(tempMplay,0,0)
