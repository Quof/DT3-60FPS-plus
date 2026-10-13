if oPlayer1.grappleState=1 and reuseTime=0
{
  playSound(global.snd_HookLatch,0,0.92,1)
  bGrappled=1
  oPlayer1.grappleState=2
  oPlayer1.groundDashRecovery=0
  oPlayer1.airDashRecovery=0
  oPlayer1.xVel=0
  oPlayer1.yVel=0
  oPlayer1.grappleID=id
}
