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

if global.gateHProg=14 {global.tempAction[0]=0}
else if global.gateHProg=21 {global.tempAction[0]=0}
else if global.gateHProg=28 {global.tempAction[0]=0}
else if global.gateHProg=32 {global.tempAction[0]=0}

gameScene=instance_create(0,0,oEvGateH)

var tempMplay;
tempMplay=findMusic(906)
playMusic(tempMplay,0,0)
