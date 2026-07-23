
  //Limits the acceleration if it is too extreme
  if xAcc>xAccLimit {xAcc=xAccLimit}
  else if xAcc<-1*xAccLimit {xAcc=-1*xAccLimit}
  if yAcc>yAccLimit {yAcc=yAccLimit}
  else if yAcc<-1*yAccLimit {yAcc=-1*yAccLimit}

  //applies the acceleration
  var xAccapply, yAccapply;
  var xFricapply, yFricapply;
  xFricapply = xFric
  yFricapply = yFric
  if (xFric > 0.0 and xFric < 1.0)
  {
      xFricapply = exp(ln(xFric + 0.000001)*gDeltaTime)
      xAccapply = xAcc * xFric * (xFricapply - 1.0) / (xFric - 1.0 - 0.000001)
  }
  else if (xFric == 1.0)
      xAccapply = xAcc * gDeltaTime
  if (yFric > 0.0 and yFric < 1.0)
  {
      yFricapply = exp(ln(yFric + 0.000001)*gDeltaTime)
      yAccapply = yAcc * yFric * (yFricapply - 1.0) / (yFric - 1.0 - 0.000001)
  }
  else if (yFric == 1.0)
      yAccapply = yAcc * gDeltaTime

  xAccapply-=xVel * (1.0 - xFricapply)
  yAccapply-=yVel * (1.0 - yFricapply)

  xAccapply *= 0.5
  yAccapply *= 0.5

  xVel+=xAccapply
  //xVel+=xAccapply // !
  yVel+=yAccapply

  // friction bodge so that microadjusting is easier
  if xAccInputWalk == 0.0 && xFric > 0.2 && xFric < 0.8 && abs(xVel) < 3.0
  {
      var xVelSign;
      xVelSign = sign(xVel)
      xVel -= xVelSign * 2.0 * gDeltaTime * (1.0 - xFric)
      if sign(xVel) != xVelSign
        xVel = 0.0
  }


  xAcc=0
  yAcc=0

  //apply the limits since the velocity may be too extreme
  if xVel>xVelLimit {xVel=xVelLimit}
  else if xVel<-1*xVelLimit {xVel=-1*xVelLimit}
  if yVel>yVelLimit {yVel=yVelLimit}
  else if yVel<-16 {yVel=-16}
  //approximates the "active" variables
  if approximatelyZero(xVel) {xVel=0}
  if approximatelyZero(yVel) {yVel=0}
  if approximatelyZero(xAcc) {xAcc=0}
  if approximatelyZero(yAcc) {yAcc=0}

  effectiveMaxSlope = floor(maxSlope*gDeltaTime+frac(ditherCounter * 0.618))

  // !!!!EVIL HACK!!!!
  // maxSlope doesn't function as a slope speed penalty at high framerates
  // so we need to manually bodge it
  //var speedmod;
  speedmod = 1.0
  if platformCharacterIs(ON_GROUND) && abs(xVel)>0
  {
    //var __xtemp, __ytemp, __ystart, __yend;
    __xtemp=x;
    __ytemp=y;
    __ystart = __ytemp-3
    __yend = __ytemp+3
    //var d_center, d_left, d_right, d_slope;
    d_slope = 0
    x = __xtemp-2
    y = __ytemp-3
    for (y = __ystart; y <= __yend; y += 1)
        if pCheckLandBelow() break;
    d_left = y - __ystart
    x = __xtemp
    y = __ytemp-3
    for (y = __ystart; y <= __yend; y += 1)
        if pCheckLandBelow() break;
    d_center = y - __ystart
    x = __xtemp+2
    y = __ytemp-3
    for (y = __ystart; y <= __yend; y += 1)
        if pCheckLandBelow() break;
    d_right = y - __ystart
    if d_left != 0 && d_left != 6 && d_right != 0 && d_right != 6
        { d_slope = (d_right-d_left)/4 }
    else if d_center != 0 && d_center != 6 && d_right != 0 && d_right != 6
        { d_slope = (d_right-d_center)/2 }
    else if d_left != 0 && d_left != 6 && d_center != 0 && d_center != 6
        { d_slope = (d_center-d_left)/2 }
    
    if sign(d_slope) != sign(xVel)
        speedmod = 1.0/(1.0+max(0.0, abs(d_slope)*0.8-0.4))
    
    x = __xtemp
    y = __ytemp
  }
  
  //prepares the character to move up a hill
  //we need to use the "slopeYPrev" variable later to know the "true" y previous value
  //keep this condition the same
  if effectiveMaxSlope>0 and platformCharacterIs(ON_GROUND) and xVel!=0
  {
    slopeYPrev=y
    for(y=y;y>=slopeYPrev-effectiveMaxSlope;y-=1)
      if isCollisionTop(1)
        break
    slopeChangeInY=slopeYPrev-y
  }
  else {slopeChangeInY=0}
  
  //moves the character, and balances out the effects caused by other processes
  //keep this condition the same
  if effectiveMaxSlope*abs(xVel)>0 and platformCharacterIs(ON_GROUND)
  {
    //we need to check if we should dampen out the speed as the character runs on upward slopes
    xPrev=x
    yPrev=slopeYPrev      //we don't want to use y, because y is too high
    yPrevHigh=y          //we'll use the higher previous variable later
    pMoveTo(xVel*gDeltaTime*speedmod,yVel*gDeltaTime*speedmod+slopeChangeInY)
    dist=point_distance(xPrev,yPrev,x,y) //overall distance that has been traveled
    //we should have only ran at xVel
    if dist>abs(xVelInteger)
    {
      //show_message(string(dist)+ " "+string(abs(xVelInteger)))
      //excess=dist-abs(xVelInteger)
      //if xVelInteger<0 {excess*=-1}
      //move back since the character moved too far
      x=xPrev
      y=yPrevHigh  //we need the character to be high so the character can move down
      //this time we'll move the correct distance, but we need to shorten out the xVel a little
      //these lines can be changed for different types of slowing down when running up hills
      //ratio=abs(xVelInteger)/dist*0.9        //can be changed, init: 0.9
      ratio=1.075
      pMoveTo((xVel*gDeltaTime*ratio*speedmod),(yVel*gDeltaTime*ratio*speedmod+slopeChangeInY))
    }
  }
  else
  {
    //we simply move xVel and yVel while in the air or on a ladder
    pMoveTo(xVel*gDeltaTime,yVel*gDeltaTime)
  }

  xVel+=xAccapply
  yVel+=yAccapply

  //apply the limits since the velocity may be too extreme
  if xVel>xVelLimit {xVel=xVelLimit}
  else if xVel<-1*xVelLimit {xVel=-1*xVelLimit}
  if yVel>yVelLimit {yVel=yVelLimit}
  else if yVel<-16 {yVel=-16}
  //approximates the "active" variables
  if approximatelyZero(xVel) {xVel=0}
  if approximatelyZero(yVel) {yVel=0}
  if approximatelyZero(xAcc) {xAcc=0}
  if approximatelyZero(yAcc) {yAcc=0}
