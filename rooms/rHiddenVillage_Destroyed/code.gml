locationCheck(86)
playSound(global.snd_FireCrackle,1,0.88,1)
for(i=0;i<3;i+=1)
{
  global.tempAction[i]=0
}

if global.gameProgress=4940 {oPlayer1.life=oPlayer1.maxLife}

gameScene=instance_create(0,0,oEvCh19MainA)
mapScene=instance_create(0,0,oEvCh19SideA)
solidColor=instance_create(0,1200,oSolidBackgroundColor)
solidColor.image_blend=make_color_rgb(33,21,7)
solidColor.image_xscale=room_width; solidColor.image_yscale=80
background_blend[0]=make_color_rgb(104,76,20)
background_blend[1]=make_color_rgb(104,76,20)
background_blend[2]=make_color_rgb(104,76,20)
background_blend[3]=make_color_rgb(104,76,20)

var tempMplay;
if global.gameProgress=4940 {tempMplay=findMusic(1002)}
else {tempMplay=findMusic(1014)}
playMusic(tempMplay,0,0)
