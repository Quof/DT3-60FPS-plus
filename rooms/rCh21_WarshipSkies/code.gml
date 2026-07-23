locationCheck(99)

gameScene=instance_create(0,0,oEvCh21Falling)
if global.newMapX=240 {cloudBack=instance_create(0,0,oWarshipCloudBack)}

if global.gameProgress>=5520
{
  var tempMplay;
  tempMplay=findMusic(1025)
  playMusic(tempMplay,0,0)
}
else
{
  var tempMplay;
  tempMplay=findMusic(0)
  playMusic(tempMplay,0,0)
}
