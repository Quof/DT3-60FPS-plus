locationCheck(15)
background_hspeed[0]=-1
background_vspeed[0]=0.5
background_blend[0]=make_color_rgb(255,90,90)

gameScene=instance_create(0,0,oEvCh6MainA)

if global.gameProgress>=1500
{
  var tNewTrap;
  tNewTrap=instance_create(336,48,oSpikePlatformA)
  tNewTrap.maxDrop=96
  tNewTrap=instance_create(816,48,oSpikePlatformA)
  tNewTrap.maxDrop=96
}

var tempMplay;
tempMplay=findMusic(307)
playMusic(tempMplay,0,0)
