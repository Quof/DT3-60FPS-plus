locationCheck(10)
secondaryLocCheck(2,2)
background_visible[0]=0

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2
backFollow.backSet=backZeldaForestTrees
backFollow.xMoveScale=0.6
backFollow.yMoveScale=0.9
backFollow.depth=1499999

backFollow=instance_create(0,0,oBackgroundStatic)
backFollow.backSet=backZForF2b
backFollow.depth=1100000

gameScene=instance_create(0,0,oEvCh4MainA)
sideChat=instance_create(0,0,oEvCh4SideA)

var tempMplay;
tempMplay=findMusic(209)
playMusic(tempMplay,0,0)
