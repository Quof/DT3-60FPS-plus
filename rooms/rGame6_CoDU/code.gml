locationCheck(58)
if global.gameProgress>=3870 {global.mapTeleport=23}
background_hspeed[0]=-1
background_vspeed[0]=0.5

gameScene=instance_create(0,0,oEvCh15MainA)
mapScene=instance_create(0,0,oEvCh15SideA)

if global.gameProgress>=3870
{
  var tHeartContainer;
  tHeartContainer=instance_create(240,808,oHeartContainer)
  tHeartContainer.objectNum=6
}

var tempMplay;
if global.gameProgress<=3860 {tempMplay=findMusic(604)}
else {tempMplay=findMusic(1012)}
playMusic(tempMplay,0,0)
