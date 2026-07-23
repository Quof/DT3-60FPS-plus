locationCheck(10)
global.zEncZone=4

gameScene=instance_create(0,0,oEvCh4MainA)
//sideChat=instance_create(0,0,oEvCh4SideA)
bubbleSpawn=instance_create(0,0,oEvCh4BubbleSpawn); bubbleSpawn.spawnDelay=18

var tempMplay;
tempMplay=findMusic(203)
playMusic(tempMplay,0,0)
