locationCheck(10)
global.zEncZone=2

gameScene=instance_create(0,0,oEvCh4MainA)
//sideChat=instance_create(0,0,oEvCh4SideA)

eSpawner=instance_create(0,0,oEnemySpawnerA)
eSpawner.spawnDelay=50
eSpawner.newEnemySpawn=oBagoBago

var tempMplay;
tempMplay=findMusic(203)
playMusic(tempMplay,0,0)
