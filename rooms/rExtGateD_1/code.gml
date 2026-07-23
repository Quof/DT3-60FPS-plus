locationCheck(104)
global.mapTeleport=4

abilSetRemove(1)
global.hasShoes[0]=2
global.hasShoes[1]=2
global.hasShoes[2]=2
global.hasAbilToken[3]=5
global.activeAbility[0]=2
charSwitcher(0)

gameScene=instance_create(0,0,oEvExGates)

var tempMplay;
tempMplay=findMusic(904)
playMusic(tempMplay,0,0)
