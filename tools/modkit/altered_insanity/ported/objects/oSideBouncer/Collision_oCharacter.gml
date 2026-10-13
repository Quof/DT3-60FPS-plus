//if (other.xVel>0 and facing = 0) or (other.xVel<0 and facing = 1) //use facing instead!
//{
  if facing = 0
    oPlayer1.facing=18
  else
    oPlayer1.facing=19
    
  playSound(global.snd_SpringJump,0,0.9,1)
  oPlayer1.canAirDash=1
  oPlayer1.doubleJumpCheck=1
  if facing = 0
    other.xVel = -14
  else
    other.xVel = 14
  other.xVelSetExt=1 //60fps change (added): a velocity another object sets, so the player's move uses the 30fps formula for it (pMoveToWrapNew), as fans and blasts do
  bouncePlayerTime=0
  if oPlayer1.state = 15 or oPlayer1.state = 16
  {
    //other.yVel =-6
    other.yVel =-6; other.yVelSetExt=1 //60fps change: see above
  }
//}
