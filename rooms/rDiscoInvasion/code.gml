locationCheck(88)

gameScene=instance_create(0,0,oEvCh19MainA)
if global.gameProgress=4630 or global.gameProgress>=4710
{
  invaderScene=instance_create(0,0,oEvCh19SpaceInvader)
}

var tempMplay;
tempMplay=findMusic(28)
playMusic(tempMplay,0,0)
