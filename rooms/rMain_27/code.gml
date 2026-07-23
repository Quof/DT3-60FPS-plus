locationCheck(27)
global.desertHeat=1500

gameScene=instance_create(0,0,oEvCh7MainA)

for(i=0;i<8;i+=1)
{
  backGStatic=instance_create(255+(i*256),117,oBackgroundStatic)
  backGStatic.backSet=backBegoniaF
  backGStatic.image_angle=180
}

var tempMplay;
tempMplay=findMusic(7)
playMusic(tempMplay,0,0)
