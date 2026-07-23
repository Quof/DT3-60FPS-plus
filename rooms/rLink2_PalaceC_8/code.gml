locationCheck(10)

gameScene=instance_create(0,0,oEvCh4MainA)
//sideChat=instance_create(0,0,oEvCh4SideA)
blackTop=instance_create(0,0,oG2_BlackTop)

eSpawner=instance_create(0,0,oEnemySpawnerA)
eSpawner.spawnDelay=80

var tempMplay;
tempMplay=findMusic(205)
playMusic(tempMplay,0,0)
