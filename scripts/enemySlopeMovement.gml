/*
This script lets enemies interact with slopes.
*/

//prepares the character to move up a hill
//we need to use the "slopeYPrev" variable later to know the "true" y previous value
//keep this condition the same
if maxSlope>0 and isCollisionBottom(1) and xVel!=0
{
  slopeYPrev=y
  for(y=y;y>=slopeYPrev-maxSlope;y-=1)
    if isCollisionTop(1)
      break
  slopeChangeInY=slopeYPrev-y
}
else
  slopeChangeInY=0
//moves the character, and balances out the effects caused by other processes
//keep this condition the same
if maxSlope*abs(xVel)>0 and isCollisionBottom(1)
{
  //we need to check if we should dampen out the speed as the character runs on upward slopes
  xPrev=x
  yPrev=slopeYPrev      //we don't want to use y, because y is too high
  yPrevHigh=y          //we'll use the higher previous variable later
  moveTo(xVel,yVel+slopeChangeInY)
  dist=point_distance(xPrev,yPrev,x,y) //overall distance that has been traveled
  //we should have only ran at xVel
  if dist>abs(xVelInteger)
  {
    //show_message(string(dist)+ " "+string(abs(xVelInteger)))
    excess=dist-abs(xVelInteger)
    if(xVelInteger<0)
      excess*=-1
    //move back since the character moved too far
    x=xPrev
    y=yPrevHigh  //we need the character to be high so the character can move down
    //this time we'll move the correct distance, but we need to shorten out the xVel a little
    //these lines can be changed for different types of slowing down when running up hills
    //ratio=abs(xVelInteger)/dist*0.9        //can be changed, init: 0.9
    ratio=1.075
    moveTo(round(xVelInteger*ratio),round(yVelInteger*ratio+slopeChangeInY))
  }
}
else
{
  //we simply move xVel and yVel while in the air or on a ladder
  moveTo(xVel,yVel)
}
//move the character downhill if possible
//we need to multiply maxDownSlope by the absolute value of xVel since the character normally runs at an xVel larger than 1
if isCollisionBottom(1)=0 and maxDownSlope>0 and xVelInteger!=0 and isCollisionBottom(1)
{
  //the character is floating just above the slope, so move the character down
  upYPrev=y
  for(y=y;y<=upYPrev+maxDownSlope;y+=1)
    if isCollisionBottom(1) //we hit a solid below
    {
      upYPrev=y //I know that this doesn't seem to make sense, because of the name of the variable, but it all works out correctly after we break out of this loop
      break
    }
  y=upYPrev
}
