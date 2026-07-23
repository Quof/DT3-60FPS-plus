locationCheck(99)
global.mapTeleport=0
if global.optShowDamage>1 {global.optShowDamage-=2}
global.partySplit=1

if global.newMapX=5424 //Make sure Claire always spawns on top when starting from the right
{
  if global.newMapY=176
  {
    oPlayerIdle.y=288
    charSwitcher(1)
  }
  else if global.newMapY=288
  {
    oPlayerIdle.y=176
    charSwitcher(0)
  }
}

gameScene=instance_create(0,0,oEvCh20MainA)
mapScene=instance_create(0,0,oEvCh20SideA)
cloudBack=instance_create(0,0,oWarshipCloudBack)
windEffect=instance_create(0,0,oWarshipWindPGen)

var tempMplay;
tempMplay=findMusic(1015)
playMusic(tempMplay,0,0)
