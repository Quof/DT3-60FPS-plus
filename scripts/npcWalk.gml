/*
This script is used for NPC characters.
It will make the npc walk/stand randomly.

use: npcWalk(standAnim,animSpdStand,standTime,walkAnim,animSpdWalk,walkTime)
argument0: image_speed to use when walking
argument1: standing animation
argument2: walking animation
*/
var tAnimStand,tImgSpdStand,tStandTime,tAnimWalk,tImgSpdWalk,tWalkTime;
tAnimStand=argument0
tImgSpdStand=argument1
tStandTime=argument2
tAnimWalk=argument3
tImgSpdWalk=argument4
tWalkTime=argument5

if bStandOnly=false
{
  if bWalking=true
  {
    if image_xscale=1
      xVel=runAcc
    else
      xVel=-runAcc
    if walkingTime<=0
    {
      sprite_index=tAnimStand
      image_speed=tImgSpdStand
      image_index=0
      xVel=0
      walkingTime=tStandTime
      bWalking=false
    }
    else
      walkingTime-=1
  }
  else
  {
    if walkingTime<=0
    {
      if round(random(10))>=6
        image_xscale=1
      else
        image_xscale=-1
      sprite_index=tAnimStand
      image_speed=tImgSpdWalk
      walkingTime=tWalkTime
      bWalking=true
    }
    else
      walkingTime-=1
  }
}

if x<0
{
  xVel=0
  x=0
}
else if x>room_width
{
  xVel=0
  x=room_width
}

yVel+=0.2
if isCollisionBottom(1)
  yVel=0
if isCollisionLeft(1)
  xVel=runAcc
if isCollisionRight(1)
  xVel=-runAcc
moveTo(xVel,yVel)
if isCollisionSolid()
  y-=2
