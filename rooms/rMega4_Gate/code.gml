locationCheck(29)
global.mapTeleport=9

if global.gameProgress=1750 {global.gameProgress=1760}

if global.hasAbilToken[3]=1 and global.gameProgress<=1980
{
  global.canCharSwap=1
  charSwitcher(0)
  global.activeAbility[0]=2
  global.hasAbilToken[1]=1

  if global.gameProgress<=1770
    global.hasAbilToken[3]=2
  else if global.gameProgress>=1841 and global.gameProgress<=1843
    global.hasAbilToken[3]=3
  else if global.gameProgress=1844
    global.hasAbilToken[3]=4
  else if global.gameProgress>=1845
    global.hasAbilToken[3]=5

  if global.gameProgress>=1920 {global.charScan[0]=0}
}

bgFollow=instance_create(0,0,oBackgroundFollow)
bgFollow.type=2; bgFollow.backSet=backMM_IntroA
bgFollow.xMoveScale=0.6; bgFollow.yMoveScale=0.6; bgFollow.depth=1499999

if global.gameProgress>=1840
{
  var newExit;
  newExit=instance_create(320,304,oExit)
  newExit.sprite_index=sWarpGateStand
  newExit.bShowArrow=false; newExit.exitType=0
  newExit.newMapX=0; newExit.newMapY=0; newExit.toRoom=rMega4_Map
}

gameScene=instance_create(0,0,oEvCh8MainA)

if global.gameProgress>=1780
{
  var tempMplay;
  tempMplay=findMusic(401)
  playMusic(tempMplay,0,0)
}

musicUnload(0)
