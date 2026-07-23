locationCheck(20)
global.challengeRoom=0

if global.gameProgress=1540 {global.gameProgress=1550}

gameScene=instance_create(0,0,oEvCh7MainA)

backGrad=instance_create(0,0,oCh7GradientBack)
backGrad.type=0
backGrad.colorTop=make_color_rgb(0,104,248)
backGrad.colorBottom=make_color_rgb(48,152,248)
backGrad.yStart=0; backGrad.yEnd=224

for(i=0;i<12;i+=1)
{
  backGStatic=instance_create(255+(i*256)-1,571,oBackgroundStatic)
  backGStatic.backSet=backBegoniaF
  backGStatic.image_angle=180
}

backGrad=instance_create(0,0,oCh7GradientBack)
backGrad.type=0
backGrad.colorTop=make_color_rgb(64,128,176)
backGrad.colorBottom=make_color_rgb(64,128,176)
backGrad.yStart=303; backGrad.yEnd=453

backGrad=instance_create(0,0,oCh7GradientBack)
backGrad.type=0
backGrad.colorTop=make_color_rgb(48,152,248)
backGrad.colorBottom=make_color_rgb(39,181,234)
backGrad.yStart=544; backGrad.yEnd=1206

backGrad=instance_create(0,0,oCh7GradientBack)
backGrad.type=1
backGrad.colorTop=make_color_rgb(118,225,0)
backGrad.yStart=1364

tile_layer_hide(999990)
indexCheck=string_char_at(global.gameOptShortcuts,1)
if indexCheck="1"
{
  tile_layer_show(999990)
  var tNewCol;
  tNewCol=instance_create(2576,1232,oInvisibleSolid); tNewCol.image_xscale=3
  tNewCol=instance_create(2640,1152,oInvisibleSolid); tNewCol.image_xscale=3
  tNewCol=instance_create(2704,1072,oInvisibleSolid); tNewCol.image_xscale=3
}

var tempMplay;
tempMplay=findMusic(7)
playMusic(tempMplay,0,0)
