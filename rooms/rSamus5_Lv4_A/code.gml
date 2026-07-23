locationCheck(49)

gameScene=instance_create(0,0,oEvCh13MainA)
metroidControl=instance_create(0,0,oEvCh13MetroidControl)

if global.gameProgress>=3070
{
  var tHeartContainer;
  tHeartContainer=instance_create(248,312,oHeartContainer)
  tHeartContainer.objectNum=5
}

var tempMplay;
tempMplay=findMusic(505)
playMusic(tempMplay,0,0)
