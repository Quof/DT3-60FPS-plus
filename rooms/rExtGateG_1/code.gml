locationCheck(107)
global.mapTeleport=7

abilSetRemove(1)
for(i=0;i<4;i+=1)
{
  global.hasShoes[i]=2
}
global.hasAbilToken[5]=3
global.hasAbilToken[6]=3
global.activeAbility[0]=3
global.activeAbility[1]=3
global.canDoubleJump=2
global.canCharSwap=2

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2
backFollow.backSet=backG6ForgottenIsles
backFollow.xMoveScale=0.6; backFollow.yMoveScale=1
backFollow.depth=1499999
backFollow.image_xscale=2; backFollow.image_yscale=2
backDraw=instance_create(0,0,oG6_CastleBack)
backDraw.yStartDraw=207

gameScene=instance_create(0,0,oEvExGates)

var tempMplay;
tempMplay=findMusic(905)
playMusic(tempMplay,0,0)
