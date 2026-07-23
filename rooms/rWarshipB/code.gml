locationCheck(99)
if global.gameProgress=5050 {global.gameProgress=5060}

global.partySplit=1

if global.newMapX=48
{
  if global.newMapY=176
  {
    oPlayerIdle.y=288
    charSwitcher(1)
  }
  else if global.newMapY=288 {charSwitcher(0)}
}

gameScene=instance_create(0,0,oEvCh20MainA)
mapScene=instance_create(0,0,oEvCh20SideA)
cloudBack=instance_create(0,0,oWarshipCloudBack)
windEffect=instance_create(0,0,oWarshipWindPGen)

var tempMplay;
tempMplay=findMusic(1015)
playMusic(tempMplay,0,0)
