locationCheck(108)

abilSetRemove(1)
for(i=0;i<2;i+=1)
{
  global.hasShoes[i]=2
}
charSwitcher(1)
global.bCanSave=0
global.charScan[0]=0; global.charScan[1]=0
oIdentifier.bCanScan=0; oIdentifier.bChaoActive=0
oPlayer1.runAcc=4
oPlayer1.frictionDuckingX=0.5
oPlayer1.initialJumpAcc=-5.5
oPlayer1.jumpTimeTotal=12

global.bCanForceGO=false
if global.optShowHUD<2 {global.optShowHUD+=2}

gameScene=instance_create(0,0,oEvGateH)

if global.gateHProg>0
{
  var tempMplay;
  if global.tempAction[0]=0 {tempMplay=findMusic(906)}
  else {tempMplay=findMusic(907)}
  playMusic(tempMplay,0,0)
}
else
{
  var tempMplay;
  tempMplay=findMusic(0)
  playMusic(tempMplay,0,0)
}
