/*
-Types-
1:  Enemies
2:  Traps
3:  Blackmoor
5:  Normal Switches
6:  Timed Switches
7: spsp ns
8: spsp ns brian balls
*/
if type=2 or type=3 or type=7 //Trap or Blackmoor to Player
{
  with oPlayer1
    hitPlayer(other.ownerID)
}
else if type=8 //spsp ns shadow brian balls
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
