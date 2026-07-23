locationCheck(81)

gameScene=instance_create(0,0,oEvCh19MainA)
mapScene=instance_create(0,0,oEvCh19SideA)

var tempMplay;
if global.gameProgress<=4940 {tempMplay=findMusic(24)}
else
{
  instance_create(0,0,oHighlandChanges)
  tempMplay=findMusic(25)
}
playMusic(tempMplay,0,0)
