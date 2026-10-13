tGrabEnemy=0
        if global.alterEquip=1
        {
            for(i=0;i<3;i+=1)
            {
              if global.equipJerry[i]= 4{tGrabEnemy=1}
            }
        }
if oPlayer1.grappleState=1 and tGrabEnemy=1
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
