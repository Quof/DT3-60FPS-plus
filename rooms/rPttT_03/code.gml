locationCheck(76)
if global.gamePttT_Prog>=60 {global.mapTeleport=29}
global.partySplit=1

if global.gamePttT_Prog<30 {global.gamePttT_Prog=30}

gameScene=instance_create(0,0,oEvPttT)
flashbacks=instance_create(0,0,oEvPttT_Flashbacks)

if global.gamePttT_Prog<40
{
  roomControl=instance_create(0,0,oEvKeyControl)
  roomControl.progCheck=10000
}
else
{
  roomControl=instance_create(0,0,oEvKeyControl)
  roomControl.progCheck=0
}

var tempMplay;
tempMplay=findMusic(1024)
playMusic(tempMplay,0,0)
