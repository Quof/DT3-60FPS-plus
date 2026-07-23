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
