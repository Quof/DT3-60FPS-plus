locationCheck(76)

if global.gameProgress>=5580
{
  global.partySplit=0
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2
  charSwitcher(2)
}

backFollow=instance_create(0,0,oBackWastelands)
backFollow.type=0; backFollow.depth=1499999
backFollow=instance_create(0,0,oBackWastelands)
backFollow.type=1; backFollow.depth=1499999
backFollow=instance_create(0,0,oBackWastelands)
backFollow.type=2; backFollow.depth=10
backFollow=instance_create(0,0,oBackWastelands)
backFollow.type=3; backFollow.depth=1499999

gameScene=instance_create(0,0,oEvCh21MainA)
sideChat=instance_create(0,0,oEvCh21SideA)

var tempMplay;
tempMplay=findMusic(0)
playMusic(tempMplay,0,0)
