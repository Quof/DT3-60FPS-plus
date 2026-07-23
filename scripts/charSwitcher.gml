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

if tCharSwap=0 //Switch to Jerry
{
  oPlayer1.runAcc=6.6
  if global.location!=49 and global.location!=76 and global.location!=91
  {
    oPlayer1.initialJumpAcc=-7.1
    oPlayer1.jumpTimeTotal=21
  }
  oPlayer1.frictionAirX=0.82
  oPlayer1.frictionDuckingX=0.87
  for(i=0;i<3;i+=1)
    if global.equipJerry[i]=25
      oPlayer1.dashRecovery+=2
}
else if tCharSwap=1 //Switch to Claire
{
  oPlayer1.runAcc=7.3
  if global.location!=49 and global.location!=76 and global.location!=91
  {
    oPlayer1.initialJumpAcc=-7.1
    oPlayer1.jumpTimeTotal=21
  }
  oPlayer1.frictionAirX=0.82
  oPlayer1.frictionDuckingX=0.9
  for(i=0;i<3;i+=1)
    if global.equipClaire[i]=25
      oPlayer1.dashRecovery+=2
}
else if tCharSwap=2 //Switch to Jeremy
{
  oPlayer1.runAcc=4.5
  oPlayer1.initialJumpAcc=-7
  oPlayer1.jumpTimeTotal=60
  oPlayer1.frictionDuckingX=0.5
}
