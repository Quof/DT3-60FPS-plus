locationCheck(95)

gameScene=instance_create(0,0,oEvCh9MainA)

ringManager=instance_create(0,0,oCh9RingManager)
ringManager.doorID=(GID(239887))
ringManager.itemIndex=29
ringManager.ringMax=7

var tempMplay;
tempMplay=findMusic(202)
playMusic(tempMplay,0,0)
