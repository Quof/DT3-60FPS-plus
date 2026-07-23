locationCheck(7)

if global.gameProgress=140
  global.gameProgress=150
else if global.gameProgress>=170
  instance_create(5136,240,oMarioQBlock)

if global.hasAbilToken[0]=1 and global.gameProgress<=500
  global.hasAbilToken[0]=2

backFollowFore=instance_create(0,0,oBackgroundFollow)
backFollowFore.type=2; backFollowFore.backSet=backMarioA
backFollowFore.xMoveScale=0.6; backFollowFore.yMoveScale=1; backFollowFore.depth=1499999

gameScene=instance_create(0,0,oEvCh2MainA)
sideChat=instance_create(0,0,oEvCh2SideA)

if global.gameProgress>=160
{
  var tempMplay;
  tempMplay=findMusic(101)
  playMusic(tempMplay,0,0)
}

musicUnload(0)
