locationCheck(103)
global.mapTeleport=3

abilSetRemove(1)
global.hasShoes[0]=2
global.hasShoes[1]=2
global.hasShoes[2]=2
global.canCharSwap=1
global.hasAbilToken[2]=4
global.activeAbility[1]=1
charSwitcher(1)

gameScene=instance_create(0,0,oEvExGates)
roomProg=instance_create(0,0,oGateCRoomProg)

var tempMplay;
tempMplay=findMusic(903)
playMusic(tempMplay,0,0)
