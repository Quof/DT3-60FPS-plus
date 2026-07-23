locationCheck(75)
global.altEndingProg=1

if global.gameProgress>=5560
{
  abilSetRemove(0)
  if global.activeCharacter=2 {charSwitcher(0)}
}
global.canCharSwap=2

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2
backFollow.backSet=backBarrensA
backFollow.xMoveScale=0.6
backFollow.yMoveScale=0.92
backFollow.depth=1499999
backFollow.image_xscale=2.8
backFollow.image_yscale=2.8

gameScene=instance_create(0,0,oEvCh21MainA)
sideChat=instance_create(0,0,oEvCh21SideA)
heatTrack=instance_create(0,0,oDesertHeat)

var tempMplay;
tempMplay=findMusic(13)
playMusic(tempMplay,0,0)
