locationCheck(17)
global.challengeRoom=0

gameScene=instance_create(0,0,oEvCh5MainA)

if global.gameProgress<=2000
{
  efDistortion=instance_create(1600,608,oEvCh5Distortion)
  efDistortion.maxFuzz=1
  efDistortion.fuzzRange=sqrt(sqr(room_width)+sqr(room_height))
}
instance_create(0,0,oCh5_LeafSpawner)

var tempMplay;
tempMplay=findMusic(4)
playMusic(tempMplay,0,0)
