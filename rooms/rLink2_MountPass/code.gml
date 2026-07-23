locationCheck(10)

if global.gameProgress=740
  global.gameProgress=750

backA=instance_create(0,0,oBackgroundFollow)
backA.type=2
backA.image_xscale=1.875
backA.image_yscale=1.84
backA.backSet=backZeldaMountain
backA.xMoveScale=0.6
backA.yMoveScale=1
backA.depth=1499999

gameScene=instance_create(0,0,oEvCh4MainA)
sideChat=instance_create(0,0,oEvCh4SideA)

var tempMplay;
tempMplay=findMusic(208)
playMusic(tempMplay,0,0)
