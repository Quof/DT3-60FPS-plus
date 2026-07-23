locationCheck(15)
background_hspeed[0]=-1
background_vspeed[0]=1

gameScene=instance_create(0,0,oEvCh6MainA)
skyBack=instance_create(0,0,oSkyCastleBack)
if global.gameProgress<=1430
{
  EfDarken=instance_create(0,0,oEvCh6Darken)
  EfDarken.maxDark=0.6
}

var tempMplay;
tempMplay=findMusic(306)
playMusic(tempMplay,0,0)
