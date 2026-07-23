locationCheck(59)

gameScene=instance_create(0,0,oEvCh17MainA)
mapScene=instance_create(0,0,oEvCh17SideA)

if global.gameProgress>=4060
{
  instance_create(0,0,oScreenColorOverlay)
  oScreenColorOverlay.image_blend=c_red
  oScreenColorOverlay.image_alpha=0.4
}

var tempMplay;
tempMplay=findMusic(20)
playMusic(tempMplay,0,0)
