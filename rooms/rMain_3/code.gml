locationCheck(3)
if global.gameProgress=30
{
  newTutorial=instance_create(0,0,oTutorialPanel)
  newTutorial.tutorialTitle="Pause Menu"
  newTutorial.tutorialInfo="To open the Pause Menu, press [P]. From there, you can save your progress and do all sorts of other stuff."
  newTutorial.scrAreaY=0
  global.gameProgress=40
}

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2
backFollow.backSet=backMeadeland1
backFollow.xMoveScale=0.6
backFollow.yMoveScale=1
backFollow.depth=1499999

gameScene=instance_create(0,0,oEvCh1MainA)
sideChat=instance_create(0,0,oEvCh1SideA)

var tempMplay;
tempMplay=findMusic(1)
playMusic(tempMplay,0,0)
