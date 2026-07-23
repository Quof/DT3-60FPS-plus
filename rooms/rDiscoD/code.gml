locationCheck(88)

if global.gameProgress=4600 {global.gameProgress=4610}

gameScene=instance_create(0,0,oEvCh19MainA)
if global.gameProgress=4610 or global.gameProgress=4620 or global.gameProgress>=4710
{
  warScene=instance_create(0,0,oEvCh19WarRoom)
}

var tempMplay;
if global.gameProgress<=4610 or global.gameProgress>=4630 {tempMplay=findMusic(28)}
else {tempMplay=findMusic(1001)}
playMusic(tempMplay,0,0)
