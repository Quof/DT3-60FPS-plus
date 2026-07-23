if global.gameProgress=390
  global.gameProgress=400

backFollowFore=instance_create(0,0,oBackgroundFollow)
backFollowFore.type=2
backFollowFore.backSet=backMarioA
backFollowFore.xMoveScale=0.6
backFollowFore.yMoveScale=1
backFollowFore.depth=1499999

gameScene=instance_create(0,0,oEvCh2MainA)
sideChat=instance_create(0,0,oEvCh2SideA)

var tempMplay;
tempMplay=findMusic(101)
playMusic(tempMplay,0,0)
