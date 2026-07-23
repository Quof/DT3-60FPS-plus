locationCheck(63)

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=5
backFollow.backSet=backStarrySkiesA1
backFollow.xMoveScale=0.6
backFollow.yMoveScale=0.9
backFollow.depth=1499999
backFollow.SetA=backStarrySkiesA1
backFollow.SetB=backStarrySkiesA2
backFollow.cycleSpd=20

gameScene=instance_create(0,0,oEvCh18MainA)
instance_create(0,0,oCh18_SnowflakeSpawn)
instance_create(0,0,oCh18Snowstorm)
instance_create(0,0,oCh18CloudySky)

var tempMplay;
tempMplay=findMusic(21)
playMusic(tempMplay,0,0)
