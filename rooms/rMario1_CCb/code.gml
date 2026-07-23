if global.gameProgress=450
  global.gameProgress=460
else if global.gameProgress=470
{
  global.canCharSwap=1
  charSwitcher(0)
}

gameScene=instance_create(0,0,oEvCh2MainA)
sideChat=instance_create(0,0,oEvCh2SideA)

var tempMplay;
tempMplay=findMusic(103)
playMusic(tempMplay,0,0)
