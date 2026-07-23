locationCheck(105)
global.mapTeleport=5

abilSetRemove(1)
for(i=0;i<4;i+=1)
{
  global.hasShoes[i]=2
}
global.canCharSwap=2
for(i=0;i<4;i+=1)
{
  global.hasAbilToken[i]=5
}
global.activeAbility[0]=1
global.activeAbility[1]=1

gameScene=instance_create(0,0,oEvExGates)
instance_create(0,0,oVaultVisualControl)

colorControl=instance_create(0,0,oColorIndControl)
colorControl.warnDelay=210

var tempMplay;
tempMplay=findMusic(11)
playMusic(tempMplay,0,0)
