locationCheck(102)
global.mapTeleport=2

abilSetRemove(1)
global.hasShoes[0]=2
global.hasShoes[1]=2
global.hasAbilToken[1]=4
global.activeAbility[0]=1
charSwitcher(0)

gameScene=instance_create(0,0,oEvExGates)
roomControl=instance_create(0,0,oEvKeyControl)
roomControl.progCheck=1000000

var tempMplay;
tempMplay=findMusic(901)
playMusic(tempMplay,0,0)
