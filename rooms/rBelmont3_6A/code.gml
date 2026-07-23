locationCheck(15)
background_hspeed[0]=-1
background_vspeed[0]=1

if global.gameProgress=1400
  global.gameProgress=1410

gameScene=instance_create(0,0,oEvCh6MainA)
skyBack=instance_create(0,0,oSkyCastleBack)

var tempMplay;
tempMplay=findMusic(306)
playMusic(tempMplay,0,0)
