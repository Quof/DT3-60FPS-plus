locationCheck(58)

gameScene=instance_create(0,0,oEvCh15MainA)

if global.gameProgress>=3400
{
  var tempMplay;
  tempMplay=findMusic(601)
  playMusic(tempMplay,0,0)
}

musicUnload(0)
