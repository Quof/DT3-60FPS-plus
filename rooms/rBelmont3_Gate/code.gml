locationCheck(15)

if global.gameProgress=1140 {global.gameProgress=1150}

if global.hasAbilToken[2]=1 and global.gameProgress<=1510
{
  global.canCharSwap=1
  charSwitcher(1)
  global.activeAbility[1]=1

  if global.gameProgress<=1200
    global.hasAbilToken[2]=2
  else if global.gameProgress>=1210 and global.gameProgress<=1250
    global.hasAbilToken[2]=3
  else if global.gameProgress>=1260
    global.hasAbilToken[2]=4
}

gameScene=instance_create(0,0,oEvCh6MainA)

var tempMplay;
tempMplay=findMusic(202)
playMusic(tempMplay,0,0)

musicUnload(0)
