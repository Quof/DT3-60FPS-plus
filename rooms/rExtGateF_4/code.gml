locationCheck(106)
global.mapTeleport=6

oPlayer1.initialJumpAcc=-9.4; oPlayer1.jumpTimeTotal=35
oPlayer1.runAcc=0.8; oPlayer1.frictionRunningX=0.9

gameScene=instance_create(0,0,oEvExGates)
gravControl=instance_create(0,0,oGateF_GravControl)
sceneParticles=instance_create(0,0,oGateF_IceParticles)

var tempMplay;
tempMplay=findMusic(501)
playMusic(tempMplay,0,0)
