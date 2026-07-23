locationCheck(49)

gameScene=instance_create(0,0,oEvCh13MainA)
metroidControl=instance_create(0,0,oEvCh13MetroidControl)

global.currentBoss=""
global.bossTrack=0

var tempMplay;
tempMplay=findMusic(505)
playMusic(tempMplay,0,0)
