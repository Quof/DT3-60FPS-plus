locationCheck(8)

if global.gameProgress=520 {global.gameProgress=525}

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2
backFollow.backSet=backMeadeland1
backFollow.xMoveScale=0.6
backFollow.yMoveScale=1
backFollow.depth=1499999

gameScene=instance_create(0,0,oEvCh3MainA)

birdSpawner=instance_create(0,0,oSpawnGrayBirds)

var tempMplay;
tempMplay=findMusic(1)
playMusic(tempMplay,0,0)
