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
    if !place_meeting(x,y-runAcc*gDeltaTime,oSolid) //check up first
    {
      if place_meeting(x-runAcc*gDeltaTime,y,oSolid) //check left
        y-=runAcc*gDeltaTime //continue up
      else
      {
        currentDir=LEFT
        x-=runAcc*gDeltaTime //move left once
      }
    }
    else
    {
      currentDir=RIGHT
      x+=runAcc*gDeltaTime
    }
  }
  else if currentDir=DOWN
  {
    if !place_meeting(x,y+runAcc*gDeltaTime,oSolid) //check down first
    {
      if place_meeting(x+runAcc*gDeltaTime,y,oSolid) //check right
        y+=runAcc*gDeltaTime //continue down
      else
      {
        currentDir=RIGHT
        x+=runAcc*gDeltaTime //move right once
      }
    }
    else
    {
      currentDir=LEFT
      x-=runAcc*gDeltaTime
    }
  }
  else if currentDir=LEFT
  {
    if !place_meeting(x-runAcc*gDeltaTime,y,oSolid) //check left first
    {
      if place_meeting(x,y+runAcc*gDeltaTime,oSolid) //check down
        x-=runAcc*gDeltaTime //continue left
      else
      {
        currentDir=DOWN
        y+=runAcc*gDeltaTime //move down once
      }
    }
    else
    {
      currentDir=UP
      y-=runAcc*gDeltaTime
    }
  }
  else if currentDir=RIGHT
  {
    if !place_meeting(x+runAcc*gDeltaTime,y,oSolid) //check right first
    {
      if place_meeting(x,y-runAcc*gDeltaTime,oSolid) //check up
        x+=runAcc*gDeltaTime //continue right
      else
      {
        currentDir=UP
        y-=runAcc*gDeltaTime //move up once
      }
    }
    else
    {
      currentDir=DOWN
      y+=runAcc*gDeltaTime
    }
  }
}
else //******************** CLOCK-WISE ********************
{
  if currentDir=UP
  {
    if !place_meeting(x,y-runAcc*gDeltaTime,oSolid) //check up first
    {
      if place_meeting(x+runAcc*gDeltaTime,y,oSolid) //check right
        y-=runAcc*gDeltaTime //continue up
      else
      {
        currentDir=RIGHT
        x+=runAcc*gDeltaTime //move right once
      }
    }
    else
    {
      currentDir=LEFT
      x-=runAcc*gDeltaTime
    }
  }
  else if currentDir=DOWN
  {
    if !place_meeting(x,y+runAcc*gDeltaTime,oSolid) //check down first
    {
      if place_meeting(x-runAcc*gDeltaTime,y,oSolid) //check left
        y+=runAcc*gDeltaTime //continue down
      else
      {
        currentDir=LEFT
        x-=runAcc*gDeltaTime //move left once
      }
    }
    else
    {
      currentDir=RIGHT
      x+=runAcc*gDeltaTime
    }
  }
  else if currentDir=LEFT
  {
    if !place_meeting(x-runAcc*gDeltaTime,y,oSolid) //check left first
    {
      if place_meeting(x,y-runAcc*gDeltaTime,oSolid) //check up
        x-=runAcc*gDeltaTime //continue left
      else
      {
        currentDir=UP
        y-=runAcc*gDeltaTime //move up once
      }
    }
    else
    {
      currentDir=DOWN
      y+=runAcc*gDeltaTime
    }
  }
  else if currentDir=RIGHT
  {
    if !place_meeting(x+runAcc*gDeltaTime,y,oSolid) //check right first
    {
      if place_meeting(x,y+runAcc*gDeltaTime,oSolid) //check down
        x+=runAcc*gDeltaTime //continue right
      else
      {
        currentDir=DOWN
        y+=runAcc*gDeltaTime //move down once
      }
    }
    else
    {
      currentDir=UP
      y-=runAcc*gDeltaTime
    }
  }
}
