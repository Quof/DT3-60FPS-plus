locationCheck(99)
background_visible[1]=1; background_visible[2]=1
background_alpha[1]=0.04; background_alpha[2]=0.04

abilSetRemove(1)
global.hasShoes[0]=2; global.hasShoes[1]=2
if global.gameProgress<=5310 or global.bBossGallery=1
{
  global.canCharSwap=2; global.canDoubleJump=2
  global.hasAbilToken[0]=2
}
else
{
  charSwitcher(2)
}

gameScene=instance_create(0,0,oEvCh20MainA)
mapScene=instance_create(0,0,oEvCh20SideA)

var tempMplay;
if global.bossTrack=0 {tempMplay=findMusic(1016)}
else if global.bossTrack=1 //Boss Fight: Warmaster
{
  abilSetRemove(0)
  with oNPC_GeneralC {instance_destroy()}
  var tCamera,boss;
  tCamera=instance_create(368,304,oGameCamera); tCamera.type=0
  oPlayer1.x=288; oPlayer1.y=304
  view_xview[0]=160
  instance_create(128,240,oWarshipFinalDoor)
  tempMplay=findMusic(829)
  boss=instance_create(448,304,oCHAOS_Warmaster_Main)
  boss.activateBoss=1
  storeStatus(1)
}
playMusic(tempMplay,0,0)
