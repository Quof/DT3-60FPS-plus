locationCheck(88)

oPlayer1.life=oPlayer1.maxLife
global.pLife=global.pMaxLife

if global.gameProgress=4670 {SS_SetSoundFreq(global.msc_Discombobulated,6300)}
else {SS_SetSoundFreq(global.msc_Discombobulated,22050)}

gameScene=instance_create(0,0,oEvCh19MainA)

if global.gameProgress=4660
{
  global.forceTime=1260
  var tTimer;
  tTimer=instance_create(412,8,oScreenTimer)
  tTimer.type=3; tTimer.mainColor=c_white; tTimer.shadowColor=c_black
}

var tempMplay;
tempMplay=findMusic(28)
playMusic(tempMplay,0,0)
