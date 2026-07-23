locationCheck(99)
for(i=0;i<5;i+=1)
{
  background_blend[i]=c_gray
}

gameScene=instance_create(0,0,oEvTrueEscape)
mapScene=instance_create(0,0,oEvCh20SideA)
cloudBack=instance_create(0,0,oWarshipCloudBack)
windEffect=instance_create(0,0,oWarshipWindPGen)
escapeEff=instance_create(0,0,oWarshipEscapeEffects)

var tTimer;
tTimer=instance_create(412,8,oScreenTimer)
tTimer.type=3; tTimer.mainColor=c_white; tTimer.shadowColor=c_black

var tempMplay;
tempMplay=findMusic(1020)
playMusic(tempMplay,0,0)
