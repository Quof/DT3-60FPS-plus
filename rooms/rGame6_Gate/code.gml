locationCheck(58)
global.partySplit=0
abilSetRemove(1)
global.hasShoes[0]=2; global.hasShoes[1]=2

if global.gameProgress>=3430 //Claire Abil A/B
{
  global.hasAbilToken[6]=2
  global.activeAbility[1]=3
  if global.gameProgress>=3520 //Jerry Abil A/B
  {
    global.canCharSwap=2
    global.hasAbilToken[5]=2
    global.activeAbility[0]=3
    if global.gameProgress>=3600 //Double Jump
    {
      global.canDoubleJump=2
      if global.gameProgress>=3771 //Jerry/Claire Abil C
      {
        global.hasAbilToken[5]=3
        global.hasAbilToken[6]=3
        if global.gameProgress>=3840 //Dashes
        {
          global.hasShoes[2]=2; global.hasShoes[3]=2
        }
      }
    }
  }
}

gameScene=instance_create(0,0,oEvCh15MainA)

var tempMplay;
tempMplay=findMusic(601)
playMusic(tempMplay,0,0)

musicUnload(0)
