abilSetRemove(1)
global.gamePaused=1
global.canPause=0
global.showHUD=0
global.activeCharacter=0
global.hasShoes[0]=2
global.hasShoes[1]=2
oIdentifier.bCanScan=0; oIdentifier.deactivate=1

oPlayer1.x=256; oPlayer1.y=464
cheaterRoom=instance_create(0,0,oEvCheaterRoom)

var tempMplay;
tempMplay=findMusic(0)
playMusic(tempMplay,0,0)
