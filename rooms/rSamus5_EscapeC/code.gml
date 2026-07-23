locationCheck(49)

gameScene=instance_create(0,0,oEvCh13MainA)

if global.gameProgress<=3060
{
  var tempMplay;
  tempMplay=findMusic(816)
  instance_create(0,0,oEvG5EscapeEffects)
  var tTimer;
  tTimer=instance_create(412,8,oScreenTimer)
  tTimer.type=3; tTimer.mainColor=c_white; tTimer.shadowColor=c_black
}
else
{
  var tempMplay;
  tempMplay=findMusic(505)
}
playMusic(tempMplay,0,0)
