/*
This script checks if a solid is in front of the object.
use: aiCheckHoriz(type,xMax,pixelIncre,xAdjust,yAdjust)

argument0: type
argument1: x increments to check in [argument1] pixels
argument2: pixel increments (auto checks left or right based on image_xscale - negative for reverse)
argument3: x adjust
argument4: y adjust
*/

var tAiType,tAiXMax,tAiIncre,tAiXAdjust,tAiYAdjust;
tAiType=argument0
tAiXMax=argument1
tAiIncre=argument2*image_xscale
tAiXAdjust=argument3*image_xscale
tAiYAdjust=argument4

if tAiType=0 //Is collision
{
  for(i=0;i<tAiXMax;i+=1)
  {
    if collision_point(x+tAiXAdjust+(i*tAiIncre),y+tAiYAdjust,oSolid,0,1)
    {
      return 1;
      break;
    }
  }
}
else if tAiType=1 //No collision
{
  for(i=0;i<tAiXMax;i+=1)
  {
    if !collision_point(x+tAiXAdjust+(i*tAiIncre),y+tAiYAdjust,oSolid,0,1)
    {
      return 1;
      break;
    }
  }
}
