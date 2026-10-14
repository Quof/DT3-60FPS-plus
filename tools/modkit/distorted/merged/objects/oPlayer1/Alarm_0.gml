///VARIOUS CHECKS
//Set if the player can wall jump
if global.location=29 or global.location=91 or global.location=104 or room=rHexPlat42 or room=rExtGateF_1 {bCanWallJump=1}  //spsp

if global.location=49 //Gate 5 jump upgrades
{
  if global.metJumpUpgrade=1 {initialJumpAcc=-7.8; jumpTimeTotal=28}
  else if global.metJumpUpgrade=2 {initialJumpAcc=-9.4; jumpTimeTotal=35}
}

if room=rReckoningOne or global.modeNice=1//spsp
{
  if global.activeCharacter=1 {oPlayer1.runAcc=0.8}
  else {oPlayer1.runAcc=0.7233}
  oPlayer1.frictionRunningX=0.9
}

//Set the player in morph mode at map start
if room=rMain_48 {if global.newMapX>2736 {charSwitcher(1); global.activeAbility[1]=2; scrMorphMode()}}
else if room=rMain_75 {if global.newMapX<128 {charSwitcher(1); global.activeAbility[1]=2; scrMorphMode()}}
else if room=rSamus5_Lv2_R {if global.newMapX>352 {charSwitcher(1); global.activeAbility[1]=2; scrMorphMode()}}
else if room=rWepFacA {if global.newMapX<128 {charSwitcher(1); global.activeAbility[1]=2; scrMorphMode()}}
else if room=rWepFacB {if global.newMapY>272 {charSwitcher(1); global.activeAbility[1]=2; scrMorphMode()}}
else if room=rWepFacC {if global.newMapY>272 {charSwitcher(1); global.activeAbility[1]=2; scrMorphMode()}}
else if room=rWepFacD {if global.newMapX>512 and global.newMapY>272 {charSwitcher(1); global.activeAbility[1]=2; scrMorphMode()}}
else if room=rLowFacQ {if global.newMapX<512 {charSwitcher(1); global.activeAbility[1]=2; scrMorphMode()}}

//Other checks
if room=rVault_22 {bKeepPlayerOnScreen=0}

//Teleports
if global.bBossGallery=0
{
  if global.location=7 and global.gameProgress>=510 {global.mapTeleport=31}
  else if global.location=10 and global.gameProgress>=910 {global.mapTeleport=32}
  else if global.location=15 and global.gameProgress>=1520 {global.mapTeleport=33}
  else if global.location=29 and global.gameProgress>=1990 {global.mapTeleport=34}
  else if global.location=49 and global.gameProgress>=3070 {global.mapTeleport=35}
  else if global.location=58 and global.gameProgress>=3870 {global.mapTeleport=36}

  if global.location=24 and global.gameProgress>=1710 {global.mapTeleport=24}
  else if global.location=90 and global.gameProgress>=4800 {global.mapTeleport=25}
  else if global.location=93 and global.gameProgress>=5050 {global.mapTeleport=26}
  else if global.location=59 and global.gameProgress>=4200 {global.mapTeleport=27}
}
else
{
  global.hudMega_BusterEn[0]=32
  global.hudMega_ShotIceEn[0]=32
  global.hudMega_GravityEn[0]=32
}

//Display header text
if global.charScan[0]=1 and global.charScan[1]=1 and global.optShowMapHeader=1 and global.checkForDeath=0 and global.location!=99
{
  instance_create(0,0,oDisplayHeaderText)
}
global.checkForDeath=0
