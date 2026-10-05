/*
This script makes an object follow along solid borders.
use: enemyFollowBorder()

--Default values--
runAcc=2
bClockWise=0
UP=0
DOWN=1
LEFT=2
RIGHT=3
currentDir=LEFT
*/
//Above 30fps the path logic below still runs once per 30fps tick (its place_meeting checks probe runAcc pixels ahead,
//so it has to stay on the runAcc grid), on the logical position efbLX/efbLY. The visible x/y then slides along that
//tick's single straight step over the tick's frames, instead of jumping runAcc pixels once per tick.
if gDeltaTime!=1
{
  if !variable_local_exists("efbLX") {efbLX=x; efbLY=y; efbSX=x; efbSY=y; efbVX=x; efbVY=y}
  if x!=efbVX or y!=efbVY {efbLX=x; efbLY=y; efbSX=x; efbSY=y} //moved by something else: carry on from there
  if gDeltaDoTicks {x=efbLX; y=efbLY}
}
if gDeltaTime==1 or gDeltaDoTicks {
if bClockWise=false //******************** COUNTER-CLOCK-WISE ********************
{
  if currentDir=UP
  {
    if !place_meeting(x,y-runAcc,oSolid) //check up first
    {
      if place_meeting(x-runAcc,y,oSolid) //check left
        y-=runAcc //continue up
      else
      {
        currentDir=LEFT
        x-=runAcc //move left once
      }
    }
    else
    {
      currentDir=RIGHT
      x+=runAcc
    }
  }
  else if currentDir=DOWN
  {
    if !place_meeting(x,y+runAcc,oSolid) //check down first
    {
      if place_meeting(x+runAcc,y,oSolid) //check right
        y+=runAcc //continue down
      else
      {
        currentDir=RIGHT
        x+=runAcc //move right once
      }
    }
    else
    {
      currentDir=LEFT
      x-=runAcc
    }
  }
  else if currentDir=LEFT
  {
    if !place_meeting(x-runAcc,y,oSolid) //check left first
    {
      if place_meeting(x,y+runAcc,oSolid) //check down
        x-=runAcc //continue left
      else
      {
        currentDir=DOWN
        y+=runAcc //move down once
      }
    }
    else
    {
      currentDir=UP
      y-=runAcc
    }
  }
  else if currentDir=RIGHT
  {
    if !place_meeting(x+runAcc,y,oSolid) //check right first
    {
      if place_meeting(x,y-runAcc,oSolid) //check up
        x+=runAcc //continue right
      else
      {
        currentDir=UP
        y-=runAcc //move up once
      }
    }
    else
    {
      currentDir=DOWN
      y+=runAcc
    }
  }
}
else //******************** CLOCK-WISE ********************
{
  if currentDir=UP
  {
    if !place_meeting(x,y-runAcc,oSolid) //check up first
    {
      if place_meeting(x+runAcc,y,oSolid) //check right
        y-=runAcc //continue up
      else
      {
        currentDir=RIGHT
        x+=runAcc //move right once
      }
    }
    else
    {
      currentDir=LEFT
      x-=runAcc
    }
  }
  else if currentDir=DOWN
  {
    if !place_meeting(x,y+runAcc,oSolid) //check down first
    {
      if place_meeting(x-runAcc,y,oSolid) //check left
        y+=runAcc //continue down
      else
      {
        currentDir=LEFT
        x-=runAcc //move left once
      }
    }
    else
    {
      currentDir=RIGHT
      x+=runAcc
    }
  }
  else if currentDir=LEFT
  {
    if !place_meeting(x-runAcc,y,oSolid) //check left first
    {
      if place_meeting(x,y-runAcc,oSolid) //check up
        x-=runAcc //continue left
      else
      {
        currentDir=UP
        y-=runAcc //move up once
      }
    }
    else
    {
      currentDir=DOWN
      y+=runAcc
    }
  }
  else if currentDir=RIGHT
  {
    if !place_meeting(x+runAcc,y,oSolid) //check right first
    {
      if place_meeting(x,y+runAcc,oSolid) //check down
        x+=runAcc //continue right
      else
      {
        currentDir=DOWN
        y+=runAcc //move down once
      }
    }
    else
    {
      currentDir=UP
      y-=runAcc
    }
  }
}
}
if gDeltaTime!=1
{
  if gDeltaDoTicks {efbSX=efbLX; efbSY=efbLY; efbLX=x; efbLY=y}
  var tF;
  tF=min(1,gDeltaTick+gDeltaTime) //how far through the current tick this frame ends
  x=efbSX+(efbLX-efbSX)*tF
  y=efbSY+(efbLY-efbSY)*tF
  efbVX=x; efbVY=y
}
