locationCheck(99)
if global.gameProgress=5325 {global.gameProgress=5330}

background_visible[1]=1; background_visible[2]=1
background_alpha[1]=0.04; background_alpha[2]=0.04

abilSetRemove(1)
global.hasShoes[0]=2; global.hasShoes[1]=2

gameScene=instance_create(0,0,oEvCh20MainA)
mapScene=instance_create(0,0,oEvCh20SideA)

var tempMplay;
tempMplay=findMusic(1016)
playMusic(tempMplay,0,0)
