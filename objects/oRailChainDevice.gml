#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: xMove,yMove,bResetChains
makeActive()
bMoving=0
turnDelay=0
moveSpd=2
connectionColorA=make_color_rgb(62,132,146)
connectionColorB=make_color_rgb(50,122,170)

myGrapplePoints[0]=instance_create(x+64,y,oStrikeChainPoint)
myGrapplePoints[1]=instance_create(x-64,y,oStrikeChainPoint)
myGrapplePoints[2]=instance_create(x,y+64,oStrikeChainPoint)
myGrapplePoints[3]=instance_create(x,y-64,oStrikeChainPoint)
myGrapplePoints[4]=instance_create(x,y,oStrikeChainPoint)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bMoving=1
  {
    if turnDelay=0
    {
      nextTurn=instance_nearest(x,y,oPlatRail) //find closest rail turn
      if point_distance(x,y,nextTurn.x+8,nextTurn.y+8)<moveSpd
      {
        x=nextTurn.x+8; y=nextTurn.y+8
        var tXvel,tYvel;
        tXvel=xVel; tYvel=yVel
        xVel=0; yVel=0
        if nextTurn.turnType=0 //top-left corner
        {
          if tYvel<0 {xVel=moveSpd}
          else if tXvel<0 {yVel=moveSpd}
          else {xVel=-tXvel; yVel=-tYvel}
          turnDelay=8
        }
        else if nextTurn.turnType=1 //top-right corner
        {
          if tXvel>0 {yVel=moveSpd}
          else if tYvel<0 {xVel=-moveSpd}
          else {xVel=-tXvel; yVel=-tYvel}
          turnDelay=8
        }
        else if nextTurn.turnType=2 //bottom-right corner
        {
          if tYvel>0 {xVel=-moveSpd}
          else if tXvel>0 {yVel=-moveSpd}
          else {xVel=-tXvel; yVel=-tYvel}
          turnDelay=8
        }
        else if nextTurn.turnType=3 //bottom-left corner
        {
          if tXvel<0 {yVel=-moveSpd}
          else if tYvel>0 {xVel=moveSpd}
          else {xVel=-tXvel; yVel=-tYvel}
          turnDelay=8
        }
        else if nextTurn.turnType=4 //turn around
        {
          xVel=-tXvel; yVel=-tYvel
          turnDelay=8
        }
      }
    }
    else {turnDelay-=1}
    x+=xVel
    y+=yVel
  }
  else
  {
    for(i=0;i<5;i+=1)
    {
      if myGrapplePoints[i].bGrappled=1
      {
        if bResetTraps=1
        {
          with oMarioChainBall
          {
            dir=initDir
          }
          with oMovingTrap
          {
            direction=initDir
            shiftTime=0
            x=xstart
            y=ystart
          }
        }
        bMoving=1
        xVel=xMove
        yVel=yMove
        break;
      }
    }
  }
  myGrapplePoints[0].x=x+64; myGrapplePoints[0].y=y
  myGrapplePoints[1].x=x-64; myGrapplePoints[1].y=y
  myGrapplePoints[2].x=x; myGrapplePoints[2].y=y+64
  myGrapplePoints[3].x=x; myGrapplePoints[3].y=y-64
  myGrapplePoints[4].x=x; myGrapplePoints[4].y=y
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_color(connectionColorA)
draw_set_alpha(1)
draw_line_width(myGrapplePoints[0].x,myGrapplePoints[0].y,myGrapplePoints[1].x,myGrapplePoints[1].y,3)
draw_line_width(myGrapplePoints[2].x,myGrapplePoints[2].y,myGrapplePoints[3].x,myGrapplePoints[3].y,3)
draw_circle(x,y,13,0)
draw_set_color(connectionColorB)
draw_line_width(myGrapplePoints[0].x,myGrapplePoints[0].y,myGrapplePoints[1].x,myGrapplePoints[1].y,1)
draw_line_width(myGrapplePoints[2].x,myGrapplePoints[2].y,myGrapplePoints[3].x,myGrapplePoints[3].y,1)
draw_circle(x,y,10,0)
