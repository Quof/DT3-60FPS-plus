if room=rPttT_07
{
  oPlayer1.canAirDash=1
  oPlayer1.doubleJumpCheck=1
  other.yVel=-16
  bouncePlayerTime=round(7*image_xscale)
}
else
{
  if other.yVel>0
  {
    playSound(global.snd_SpringJump,0,0.95,1)
    oPlayer1.canAirDash=1
    oPlayer1.doubleJumpCheck=1
    other.yVel=-16
    bouncePlayerTime=round(7*image_xscale)
  }
}
