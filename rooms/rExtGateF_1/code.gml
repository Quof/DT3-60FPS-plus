locationCheck(106)
global.mapTeleport=6
global.desertHeat=1500

abilSetRemove(1)
for(i=0;i<4;i+=1)
{
  global.hasShoes[i]=2
}
global.hasAbilToken[4]=8
global.activeAbility[1]=2
charSwitcher(1)

oPlayer1.initialJumpAcc=-9.4; oPlayer1.jumpTimeTotal=35
oPlayer1.runAcc=0.8; oPlayer1.frictionRunningX=0.9

gameScene=instance_create(0,0,oEvExGates)
gravControl=instance_create(0,0,oGateF_GravControl)
sceneParticles=instance_create(0,0,oGateF_IceParticles)

var tempMplay;
tempMplay=findMusic(501)
playMusic(tempMplay,0,0)
