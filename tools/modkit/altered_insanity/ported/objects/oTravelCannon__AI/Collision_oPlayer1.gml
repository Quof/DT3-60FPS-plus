//Get in cannon
if oKeyCodes.kCodePressed[3]=1 and bCannonInUse=0 and global.gamePaused=false
{
  oPlayer1.kLeft=0
  oPlayer1.kRight=0
  oPlayer1.kUp=0
  oPlayer1.kDown=0
  oPlayer1.xVel=0; oPlayer1.xAcc=0
  oPlayer1.state=oPlayer1.STANDING
  oPlayer1.attackState=oPlayer1.ACT_IN_CANNON
  oPlayer1.bCanTakeDamage=false
  oPlayer1.canAirDash=1
  oPlayer1.doubleJumpCheck=1
  oPlayer1.visible=0
  depth=10
  bCannonInUse=1
}
