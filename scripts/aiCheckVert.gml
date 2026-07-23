/*
This script checks if a solid is below or above the object.
use: aiCheckVert(type,yMax,pixelIncre,xAdjust,yAdjust)

argument0: type
argument1: y increments to check in [argument2] pixels
argument2: pixel increments (positive for down, negative for up)
argument3: x adjust
argument4: y adjust
*/
var tAiType,tAiYMax,tAiIncre,tAiXAdjust,tAiYAdjust;
tAiType=argument0
tAiYMax=argument1
tAiIncre=argument2
tAiXAdjust=argument3
tAiYAdjust=argument4

if tAiType=0 //Is collision
{
  for(i=0;i<tAiYMax;i+=1)
  {
    if collision_point(x+(tAiXAdjust*image_xscale),y+tAiYAdjust+(i*tAiIncre),oSolid,0,1)
    {
      return 1;
      break;
    }
  }
}
else if tAiType=1 //No collision
{
  for(i=0;i<tAiYMax;i+=1)
  {
    if !collision_point(x+(tAiXAdjust*image_xscale),y+tAiYAdjust+(i*tAiIncre),oSolid,0,1)
    {
      return 1;
      break;
    }
  }
}
