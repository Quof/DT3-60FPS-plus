xVelFrac=frac(abs(xVel))
yVelFrac=frac(abs(yVel))
xVelInteger=0
yVelInteger=0
//(60fps change: oGame.time30, 30fps ticks, for oGame.time, as gameStepEvent's moving solids)
if xVelFrac!=0
  if round(1/xVelFrac)!=0
    //xVelInteger=(oGame.time mod round(1/xVelFrac)=0)
    xVelInteger=(oGame.time30 mod round(1/xVelFrac)=0)
if yVelFrac!=0
  if round(1/yVelFrac)!=0
    //yVelInteger=(oGame.time mod round(1/yVelFrac)=0)
    yVelInteger=(oGame.time30 mod round(1/yVelFrac)=0)
xVelInteger+=floor(abs(xVel))
yVelInteger+=floor(abs(yVel))
if xVel<0
  xVelInteger*=-1
if yVel<0
  yVelInteger*=-1
xVelInteger=round(xVelInteger)
yVelInteger=round(yVelInteger)

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
  //moveTo(xVel,yVel+slopeChangeInY)
  dist=point_distance(xPrev,yPrev,x,y) //overall distance that has been traveled
  //we should have only ran at xVel
  if dist>abs(xVelInteger)
  {
    //show_message(string(dist)+ " "+string(abs(xVelInteger)))
    excess=dist-abs(xVelInteger)
    if(xVelInteger<0)
      excess*=-1
    //move back since the character moved too far
    //x=xPrev
    //y=yPrevHigh  //we need the character to be high so the character can move down
    //this time we'll move the correct distance, but we need to shorten out the xVel a little
    //these lines can be changed for different types of slowing down when running up hills
    //ratio=abs(xVelInteger)/dist*0.9        //can be changed, init: 0.9
    ratio=1.075
    xVel = xVelInteger*ratio
    yVel = yVelInteger*ratio+slopeChangeInY
    //moveTo(round(xVelInteger*ratio),round(yVelInteger*ratio+slopeChangeInY))
  }
}
