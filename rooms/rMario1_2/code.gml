if global.gameProgress=170
  global.gameProgress=180

backFollowFore=instance_create(0,0,oBackgroundFollow)
backFollowFore.type=2
backFollowFore.backSet=backMarioB
backFollowFore.xMoveScale=0.6
backFollowFore.yMoveScale=1
backFollowFore.depth=1499999

gameScene=instance_create(0,0,oEvCh2MainA)
sideChat=instance_create(0,0,oEvCh2SideA)

SS_FreeSound(global.msc_MarioClear); global.msc_MarioClear=0
var tempMplay;
tempMplay=findMusic(104)
playMusic(tempMplay,0,0)
