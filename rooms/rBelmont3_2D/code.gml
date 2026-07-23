locationCheck(15)

gameScene=instance_create(0,0,oEvCh6MainA)
//sideChat=instance_create(0,0,oEvCh4SideA)

mHeadSpawner=instance_create(0,0,oMedusaHeadSpawner)
mHeadSpawner.reSpawnSpeed=95

var tempMplay;
tempMplay=findMusic(302)
playMusic(tempMplay,0,0)
