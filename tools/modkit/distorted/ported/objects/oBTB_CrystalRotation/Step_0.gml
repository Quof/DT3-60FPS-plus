if global.gamePaused=false and armsCreated=1
{
  armsRotation+=rotateSpd*gDeltaTime
  for(i=0;i<armNum;i+=1)
  {
    myGrapplePoints[i].x=x+lengthdir_x(armLength,(i*(360/armNum))+armsRotation)
    myGrapplePoints[i].y=y+lengthdir_y(armLength,(i*(360/armNum))+armsRotation)
  }
}
