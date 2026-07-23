locationCheck(49)

gameScene=instance_create(0,0,oEvCh13MainA)

if global.gameProgress=2710
{
  instance_create(0,0,oCheckpointNotice)
  oPlayer1.life=oPlayer1.maxLife
  global.pLife=global.pMaxLife

  global.metCheckpoint[0]=room
  global.metCheckpoint[1]=64
  global.metCheckpoint[2]=288
  global.gameProgress=2720
}
else if global.gameProgress>=2730
{
  with oRidDoorBeacon {instance_destroy()}
}
var tempMplay;
if global.gameProgress=2720 {tempMplay=findMusic(816)}
else {tempMplay=findMusic(502)}
playMusic(tempMplay,0,0)
