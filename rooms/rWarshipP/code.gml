locationCheck(99)

global.partySplit=0
if global.gameProgress>=5260
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2
  global.canCharSwap=2; global.canDoubleJump=2
  global.hasAbilToken[0]=2
}

gameScene=instance_create(0,0,oEvCh20MainA)
mapScene=instance_create(0,0,oEvCh20SideA)

var tempMplay;
if global.gameProgress>=5250 {tempMplay=findMusic(1001)}
else {tempMplay=findMusic(1015)}
playMusic(tempMplay,0,0)
