locationCheck(34)
global.mapTeleport=41

abilSetRemove(1)
global.hasShoes[0]=2
global.hasShoes[1]=2
global.canCharSwap=2
global.hasAbilToken[0]=2

backFollowFore=instance_create(0,0,oBackgroundFollow)
backFollowFore.type=2; backFollowFore.backSet=backMarioA
backFollowFore.xMoveScale=0.6; backFollowFore.yMoveScale=1; backFollowFore.depth=1499999

var tempMplay;
tempMplay=findMusic(101)
playMusic(tempMplay,0,0)
