locationCheck(11)
global.desertHeat=1500

if global.gameProgress=1080 {global.gameProgress=1090}

gameScene=instance_create(0,0,oEvCh5MainA)
if global.gameProgress<=2000
{
  efDistortion=instance_create(3016,992,oEvCh5Distortion)
  efDistortion.maxFuzz=0.33
  efDistortion.fuzzRange=832
}
instance_create(0,0,oCh5_LeafSpawner)

var tempMplay;
tempMplay=findMusic(4)
playMusic(tempMplay,0,0)
