locationCheck(29)
global.mapTeleport=9

gameScene=instance_create(0,0,oEvCh8MainA)

var tempMplay;
tempMplay=findMusic(404)
playMusic(tempMplay,0,0)

background_hspeed[0]=-1 //raw 30fps units: oGame scales background scrolling
background_vspeed[0]=1
