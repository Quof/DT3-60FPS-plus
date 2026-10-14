/*
This script swaps out Jerry and Claire.
argument0: Who to swap in
-- 0: Jerry
    -- Top Speed (Land):  6.55
    -- Top Speed (Water): 4.55

-- 1: Claire
    -- Top Speed (Land):  7.45
    -- Top Speed (Water): 5.18
*/

var tCharSwap;
tCharSwap=argument0

global.activeCharacter=tCharSwap

oPlayer1.dashRecovery=20+(global.skillTree[22]*4)
if room=rWarshipZ_E3
{
  if global.bBossGallery=0 {oPlayer1.dashRecovery+=35}
  else {oPlayer1.dashRecovery+=11}
}
else if room=rFinalCurse         //spsp
{
    if oWM_B.warmasterCheck>=6 {oPlayer1.dashRecovery+=18}
    else if oWM_B.warmasterCheck>=4 {oPlayer1.dashRecovery+=12}
    else if oWM_B.warmasterCheck>=2 {oPlayer1.dashRecovery+=6}
}
else if room=rWarshipZ_E2 and true    //spsp
{
    oPlayer1.dashRecovery+=6
}
else if room=rSerasFunhouse                                 //spsp DDLC
{
    oPlayer1.dashRecovery+=10
}
else if room=rDEX                                           //spsp DDLC
{
    if instance_exists(oDEX)
    {
        if oDEX.atkPhase=3 {oPlayer1.dashRecovery=0}
    }
}
if tCharSwap=0 //Switch to Jerry
{
  oPlayer1.runAcc=6.6
  if room=rReckoningOne or room=rReckoningTwo or global.modeNice=1 {oPlayer1.runAcc=0.7233; oPlayer1.frictionRunningX=0.9} //spsp
  if global.location!=49 and global.location!=76 and global.location!=91
  {
    oPlayer1.initialJumpAcc=-7.1
    oPlayer1.jumpTimeTotal=21
    oPlayer1.jumpBodge60=1.07; oPlayer1.jumpGravComp60=0.5; oPlayer1.doubleJumpBodge60=0.98 //60fps jump corrections for the standard jump
  }
  oPlayer1.frictionAirX=0.82
  oPlayer1.frictionDuckingX=0.87
  for(i=0;i<3;i+=1)
    if global.equipJerry[i]=25
      oPlayer1.dashRecovery+=2
  //if global.optSwapType=4 and global.hasAbilToken[4]=0 and global.activeAbility[0]=2 {pSwapAbility()}   //spsp
  //(Distorted's swap type 4, Thematic, is DT3+'s Standard (Fixed), which gives the character swapped to their linked set itself: scrSwapLinkedSet)
  /*if global.optSwapType=4
  {
    if global.activeAbility[1]=1 and global.hasAbilToken[1]=2
        global.activeAbility[0]=global.activeAbility[1]
    else if global.activeAbility[1]=2 and global.hasAbilToken[3]=2
        global.activeAbility[0]=global.activeAbility[1]
    else if global.activeAbility[1]=4
        global.activeAbility[0]=global.activeAbility[1]
  }*/
}
else if tCharSwap=1 //Switch to Claire
{
  oPlayer1.runAcc=7.3
  if room=rReckoningOne or room=rReckoningTwo or global.modeNice=1 {oPlayer1.runAcc=0.8; oPlayer1.frictionRunningX=0.9} //spsp
  if global.location!=49 and global.location!=76 and global.location!=91
  {
    oPlayer1.initialJumpAcc=-7.1
    oPlayer1.jumpTimeTotal=21
    oPlayer1.jumpBodge60=1.07; oPlayer1.jumpGravComp60=0.5; oPlayer1.doubleJumpBodge60=0.98 //60fps jump corrections for the standard jump
  }
  oPlayer1.frictionAirX=0.82
  oPlayer1.frictionDuckingX=0.9
  for(i=0;i<3;i+=1)
    if global.equipClaire[i]=25
      oPlayer1.dashRecovery+=2
  /*if global.optSwapType=4
  {
    if global.activeAbility[0]=1 and global.hasAbilToken[2]=2
        global.activeAbility[1]=global.activeAbility[0]
    else if global.activeAbility[0]=2 and global.hasAbilToken[4]=2
        global.activeAbility[1]=global.activeAbility[0]
    else if global.activeAbility[0]=4
        global.activeAbility[1]=global.activeAbility[0]
  }*/
}
else if tCharSwap=2 //Switch to Jeremy
{
  oPlayer1.runAcc=4.5
  oPlayer1.initialJumpAcc=-7
  oPlayer1.jumpTimeTotal=60
  oPlayer1.jumpBodge60=0.99; oPlayer1.jumpGravComp60=0; oPlayer1.doubleJumpBodge60=0.98 //mech jump (-7 / 60): tuned so it matches 30fps at 60 and 120fps
  oPlayer1.frictionDuckingX=0.5
}
